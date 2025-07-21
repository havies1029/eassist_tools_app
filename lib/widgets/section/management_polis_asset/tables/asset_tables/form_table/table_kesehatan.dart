import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:eassist_tools_app/blocs/gen_aset_health/asethealthcari_bloc.dart';
import 'package:eassist_tools_app/models/gen_aset_health/asethealthcari_model.dart';
import '../../../../../../helper/export_helper.dart';
import '../../../../../../helper/mobile_expert_helper.dart';
import '../../../../../../common/constants.dart';
import '../../../category_type.dart';
import '../../asset_tables/action_button_section.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class TableKesehatan extends StatefulWidget {
  final BoxConstraints constraints;
  const TableKesehatan({super.key, required this.constraints});

  @override
  State<TableKesehatan> createState() => _TableKesehatanState();
}

class _TableKesehatanState extends State<TableKesehatan> {
  List<Map<String, dynamic>> _originalItems = [];
  List<Map<String, dynamic>> _filteredItems = [];
  TrinaGridStateManager? _stateManager;

  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxW => widget.constraints.maxWidth;
  final dateFormat = DateFormat('dd MMM yyyy');
// ✅ Tambahkan controller pencarian jika perlu
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ Panggil event awal dengan parameter statusId + searchText
    Future.delayed(Duration.zero, () {
      context.read<AsetHealthCariBloc>().add(
        RefreshAsetHealthCariEvent(
          statusId: '10001', // 🟡 Status default misalnya "aktif"
          searchText: _searchController.text,
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsetHealthCariBloc, AsetHealthCariState>(
      builder: (context, state) {
        if (state.status == ListStatus.success) {
          if (_originalItems.isEmpty) {
            _originalItems = state.items.map((e) => _mapToJson(e)).toList();
            _filteredItems = List.from(_originalItems);

            debugPrint('✅ Data berhasil dimuat: ${_originalItems.length} item');
            for (var item in _originalItems) {
              debugPrint(item.toString());
            }
          }

          return Column(
            children: [
              ActionButtonSection(
                constraints: widget.constraints,
                selectedCategory: CategoryType.kesehatan,
                tableData: _originalItems,
                onDataFiltered: (filtered) {
                  setState(() {
                    _filteredItems = filtered;
                  });

                  _stateManager!
                    ..removeAllRows()
                    ..appendRows(_buildRows(filtered))
                    ..setPage(1, notify: true);
                },
                onAddAsset: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('➕ Tambah Aset Kesehatan dijalankan')),
                  );
                },
                onExportSelected: (format) async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
                    await ExportHelper.export(format, _filteredItems, CategoryType.kesehatan);
                    messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh')));
                  } else {
                    await MobileDownloadHelper.download(
                      context: context,
                      fileName: 'laporan_kesehatan.$format',
                      data: _filteredItems,
                      format: format,
                    );
                  }
                },
                onRefresh: (searchText, statusId) {
                  context.read<AsetHealthCariBloc>().add(
                    RefreshAsetHealthCariEvent(
                      searchText: searchText,
                      statusId: statusId,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: _filteredItems.isEmpty
                    ? const Center(
                  child: Text(
                    'Data tidak tersedia',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                    : TrinaGrid(
                  columns: _buildColumns(),
                  rows: _buildRows(_filteredItems),
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
              ),
            ],
          );
        } else if (state.status == ListStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No Data Available!!'));
        }
      },
    );
  }

  Map<String, dynamic> _mapToJson(AsetHealthCariModel item) {
    return {
      'no': item.nomor.toString(),
      'nama': item.nama,
      'tgl_lahir': item.dob.toIso8601String(),
      'jnskel': item.jnskel,
      'posisi': item.posisi,
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
      _textCol('No', 'no', 50),
      _textCol('Nama', 'nama', maxW * 0.2),
      _textCol('Tanggal Lahir', 'tgl_lahir', maxW * 0.18, isDate: true),
      _textCol('Jenis Kelamin', 'jnskel', maxW * 0.15),
      _textCol('Posisi', 'posisi', maxW * 0.15),
      _textCol('Status', 'status', maxW * 0.12, isStatus: true),
    ];
  }

  TrinaColumn _textCol(String title, String field, double width, {bool isDate = false, bool isStatus = false}) {
    return TrinaColumn(
      title: title,
      field: field,
      type: TrinaColumnType.text(),
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

        if (isDate) {
          final parsed = DateTime.tryParse(value);
          final formatted = parsed != null ? dateFormat.format(parsed) : '-';
          return Text(formatted);
        }

        return Text(value);
      },
    );
  }

  List<TrinaRow> _buildRows(List<Map<String, dynamic>> items) {
    return items.map((item) {
      return TrinaRow(cells: {
        'checkbox': TrinaCell(value: ''),
        'no': TrinaCell(value: item['no']),
        'nama': TrinaCell(value: item['nama']),
        'tgl_lahir': TrinaCell(value: item['tgl_lahir']),
        'jnskel': TrinaCell(value: item['jnskel']),
        'posisi': TrinaCell(value: item['posisi']),
        'status': TrinaCell(value: item['status']),
      });
    }).toList();
  }
}
