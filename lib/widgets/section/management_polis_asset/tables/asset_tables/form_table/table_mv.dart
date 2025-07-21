import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:eassist_tools_app/blocs/gen_aset_mv/asetmvcari_bloc.dart';
import 'package:eassist_tools_app/models/gen_aset_mv/asetmvcari_model.dart';
import '../../../../../../common/constants.dart';
import '../../../../../../helper/export_helper.dart';
import '../../../../../../helper/mobile_expert_helper.dart';
import '../../../category_type.dart';
import '../../asset_tables/action_button_section.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class TableMv extends StatefulWidget {
  final BoxConstraints constraints;
  const TableMv({super.key, required this.constraints});

  @override
  State<TableMv> createState() => _TableMvState();
}

class _TableMvState extends State<TableMv> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  late final ActionButtonSection _actionButton;
  List<Map<String, dynamic>> _originalItems = [];
  TrinaGridStateManager? _stateManager;

  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxW => widget.constraints.maxWidth;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();

    _actionButton = ActionButtonSection(
      key: _actionKey,
      constraints: widget.constraints,
      selectedCategory: CategoryType.kendaraan,
      tableData: _originalItems,
      onAddAsset: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('🚗 Tambah Aset Kendaraan dijalankan')),
        );
      },
      onExportSelected: (format) async {
        final messenger = ScaffoldMessenger.of(context);
        if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          await ExportHelper.export(format, _originalItems, CategoryType.kendaraan);
          messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh ke perangkat Web/Desktop')));
        } else {
          final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
          final fileName = 'laporan_kendaraan.$extension';
          await MobileDownloadHelper.download(
            context: context,
            fileName: fileName,
            data: _originalItems,
            format: format,
          );
        }
      },
      onRefresh: (searchText, statusId) {
        context.read<AsetMvCariBloc>().add(
          RefreshAsetMvCariEvent(statusId: statusId, searchText: searchText),
        );
      },
    );

    Future.delayed(Duration.zero, () {
      context.read<AsetMvCariBloc>().add(
        RefreshAsetMvCariEvent(statusId: '10001', searchText: ''),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionButton,
        const SizedBox(height: 16),
        BlocBuilder<AsetMvCariBloc, AsetMvCariState>(
          builder: (context, state) {
            debugPrint('🧱 BlocBuilder rebuild | items=\${state.items.length} | status=\${state.status}');
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(_mapToJson).toList();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _actionKey.currentState?.updateTableData(_originalItems);
              });

              return SizedBox(
                height: 500,
                child: TrinaGrid(
                  columns: _buildColumns(),
                  rows: _buildRows(_originalItems),
                  mode: TrinaGridMode.normal,
                  configuration: TrinaGridConfiguration(
                    enableMoveHorizontalInEditing: false,
                    columnSize: TrinaGridColumnSizeConfig(
                      autoSizeMode: TrinaAutoSizeMode.none,
                      resizeMode: TrinaResizeMode.none,
                    ),
                    style: TrinaGridStyleConfig(
                      rowHeight: 100,
                      columnHeight: 45,
                      borderColor: Colors.grey[300]!,
                      gridBorderColor: Colors.grey[300]!,
                      cellTextStyle: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: isMobile ? 10 : 14,
                      ),
                      columnTextStyle: TextStyle(
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 11 : 15,
                      ),
                    ),
                  ),
                  createFooter: (stateManager) => TrinaPagination(stateManager),
                  onLoaded: (event) {
                    _stateManager = event.stateManager;
                    _stateManager?.setPageSize(10, notify: true);
                    _stateManager?.setPage(1);
                  },
                ),
              );
            } else if (state.status == ListStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No Data Available!!'));
            }
          },
        ),
      ],
    );
  }


  Map<String, dynamic> _mapToJson(AsetMvCariModel item) {
    return {
      'jenis': item.jenisMv,
      'merk': item.merk,
      'type': item.tipe,
      'tahun': item.tahun,
      'nopol': item.noPolisi,
      'tsi': item.sumInsured,
      'premi': item.premi,
      'status': 'Aktif',
    };
  }

  List<TrinaColumn> _buildColumns() {
    final raw = [
      ('No', 'no', 60.0),
      ('Jenis Kendaraan', 'jenis', maxW * 0.15),
      ('Merk', 'merk', maxW * 0.1),
      ('Type', 'type', maxW * 0.13),
      ('Tahun', 'tahun', maxW * 0.07),
      ('No Polis', 'nopol', maxW * 0.13),
      ('Harga Pertanggungan', 'tsi', maxW * 0.15),
      ('Premi', 'premi', maxW * 0.15),
      ('Status', 'status', maxW * 0.12),
    ];

    return [
      TrinaColumn(
        title: '',
        field: 'checkbox',
        type: TrinaColumnType.select([]),
        enableRowChecked: true,
        enableSorting: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        width: 60,
        minWidth: 60,
        frozen: TrinaColumnFrozen.start,
      ),
      ...raw.asMap().entries.map((e) {
        final (title, field, width) = e.value;
        final isCurrency = field == 'tsi' || field == 'premi';

        return TrinaColumn(
          title: title,
          field: field,
          type: isCurrency
              ? TrinaColumnType.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
              : TrinaColumnType.text(),
          titleSpan: TextSpan(text: title),
          width: width,
          minWidth: width,
          frozen: e.key < 2 ? TrinaColumnFrozen.start : TrinaColumnFrozen.none,
          enableSorting: false,
          enableEditingMode: false,
          enableColumnDrag: false,
          enableContextMenu: false,
          renderer: (context) {
            final value = context.cell.value.toString();
            if (field == 'status') {
              Color bgColor;
              Color textColor;
              switch (value.toLowerCase()) {
                case 'aktif':
                  bgColor = const Color(0xFFDFF5E3);
                  textColor = const Color(0xFF1F9B2D);
                  break;
                case 'non aktif':
                  bgColor = const Color(0xFFFFEAEA);
                  textColor = const Color(0xFFEB5757);
                  break;
                case 'sedang diproses':
                case 'akan berakhir':
                  bgColor = const Color(0xFFFFF7E6);
                  textColor = const Color(0xFFF2994A);
                  break;
                default:
                  bgColor = Colors.grey[200]!;
                  textColor = Colors.grey[700]!;
              }
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  value,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 10 : 13,
                  ),
                ),
              );
            }
            if (isCurrency) {
              final numericValue = double.tryParse(value) ?? 0;
              final formattedValue = currencyFormat.format(numericValue);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  formattedValue,
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: isMobile ? 10 : 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: isMobile ? 10 : 14,
                ),
              ),
            );
          },
        );
      }).toList(),
      TrinaColumn(
        title: 'AKSI',
        field: 'aksi',
        type: TrinaColumnType.text(),
        width: maxW * 0.1,
        minWidth: 100,
        enableSorting: false,
        enableEditingMode: false,
        enableColumnDrag: false,
        enableContextMenu: false,
        renderer: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context.stateManager.gridKey.currentContext!)
                    .showSnackBar(
                  SnackBar(content: Text('Melacak data ke-${context.rowIdx + 1}')),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFE8F3FF),
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.w500),
              ),
              icon: const Icon(Icons.location_on_outlined, size: 16),
              label: const Text("Lacak"),
            ),
          );
        },
      ),
    ];
  }

  List<TrinaRow> _buildRows(List<Map<String, dynamic>> items) {
    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      return TrinaRow(cells: {
        'checkbox': TrinaCell(value: ''),
        'no': TrinaCell(value: (i + 1).toString()),
        'jenis': TrinaCell(value: item['jenis']),
        'merk': TrinaCell(value: item['merk']),
        'type': TrinaCell(value: item['type']),
        'tahun': TrinaCell(value: item['tahun']),
        'nopol': TrinaCell(value: item['nopol']),
        'tsi': TrinaCell(value: item['tsi'].toString()),
        'premi': TrinaCell(value: item['premi'].toString()),
        'status': TrinaCell(value: item['status']),
        'aksi': TrinaCell(value: ''),
      });
    }).toList();
  }
}