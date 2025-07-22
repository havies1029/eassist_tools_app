import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
import 'package:eassist_tools_app/models/gen_aset_par/asetparcari_model.dart';
import '../../../../../../common/constants.dart';
import '../../../../../../helper/export_helper.dart';
import '../../../../../../helper/mobile_expert_helper.dart';
import '../../../category_type.dart';
import '../../asset_tables/action_button_section.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class TableProperti extends StatefulWidget {
  final BoxConstraints constraints;
  const TableProperti({super.key, required this.constraints});

  @override
  State<TableProperti> createState() => _TablePropertiState();
}

class _TablePropertiState extends State<TableProperti> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  late final ActionButtonSection _actionButton;
  List<Map<String, dynamic>> _originalItems = [];
  // List<Map<String, dynamic>> _filteredItems = [];
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
      selectedCategory: CategoryType.properti,
      tableData: _originalItems,
      // onDataFiltered: (filtered) {
      //   setState(() {
      //     _filteredItems = filtered;
      //   });
      //
      //   _stateManager?.removeAllRows();
      //   _stateManager?.appendRows(_buildRows(filtered));
      //   _stateManager?.setPage(1, notify: true);
      // },
      onAddAsset: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('🏡 Tambah Aset Properti dijalankan')),
        );
      },
      onExportSelected: (format) async {
        final messenger = ScaffoldMessenger.of(context);
        if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          await ExportHelper.export(format, _originalItems, CategoryType.properti);
          messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh ke perangkat Web/Desktop')));
        } else {
          final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
          final fileName = 'laporan_properti.$extension';
          await MobileDownloadHelper.download(
            context: context,
            fileName: fileName,
            data: _originalItems,
            format: format,
          );
        }
      },
      onRefresh: (searchText, statusId) {
        context.read<AsetParCariBloc>().add(
          RefreshAsetParCariEvent(
            statusId: statusId,
            searchText: searchText,
          ),
        );
      },
    );

    Future.delayed(Duration.zero, () {
      context.read<AsetParCariBloc>().add(
        RefreshAsetParCariEvent(statusId: '10001', searchText: ''),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionButton,
        const SizedBox(height: 16),
        BlocBuilder<AsetParCariBloc, AsetParCariState>(
          builder: (context, state) {
            debugPrint('🧱 BlocBuilder rebuild | items=${state.items.length} | status=${state.status}');
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(_mapToJson).toList();
              // _filteredItems = List.from(_originalItems);

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
              // return const Center(child: Text('No Data Available!!'));
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }

  Map<String, dynamic> _mapToJson(AsetParCariModel item) {
    return {
      'alamat': item.alamat,
      'tsi': item.sumInsured,
      'premi': item.premi,
      'klausa': item.klausulaBank,
      'status': item.status,
    };
  }

  List<TrinaColumn> _buildColumns() {
    return [
      TrinaColumn(
        title: '',
        field: 'checkbox',
        type: TrinaColumnType.select([]),
        enableRowChecked: true,
        width: 60,
        minWidth: 60,
        frozen: TrinaColumnFrozen.start,
      ),
      _textCol('No', 'no', 60),
      _textCol('Alamat', 'alamat', maxW * 0.2),
      _textCol('Harga Pertanggungan', 'tsi', maxW * 0.15, isCurrency: true),
      _textCol('Premi', 'premi', maxW * 0.1, isCurrency: true),
      _textCol('Klausa Bank', 'klausa', maxW * 0.15),
      _textCol('Status', 'status', maxW * 0.11, isStatus: true),
    ];
  }

  TrinaColumn _textCol(String title, String field, double width, {bool isCurrency = false, bool isStatus = false}) {
    return TrinaColumn(
      title: title,
      field: field,
      type: isCurrency
          ? TrinaColumnType.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
          : TrinaColumnType.text(),
      width: width,
      minWidth: width,
      renderer: (context) {
        final value = context.cell.value.toString();

        if (isStatus) {
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
  }

  List<TrinaRow> _buildRows(List<Map<String, dynamic>> items) {
    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      return TrinaRow(cells: {
        'checkbox': TrinaCell(value: ''),
        'no': TrinaCell(value: (i + 1).toString()),
        'alamat': TrinaCell(value: item['alamat']),
        'tsi': TrinaCell(value: item['tsi'].toString()),
        'premi': TrinaCell(value: item['premi'].toString()),
        'klausa': TrinaCell(value: item['klausa']),
        'status': TrinaCell(value: item['status']),
      });
    }).toList();
  }
}
