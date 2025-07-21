import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:eassist_tools_app/blocs/gen_aset_ringkasan/asetringkasancari_bloc.dart';
import 'package:eassist_tools_app/models/gen_aset_ringkasan/asetringkasancari_model.dart';
import '../../../../../../common/constants.dart';
import '../../../../../../helper/export_helper.dart';
import '../../../../../../helper/mobile_expert_helper.dart';
import '../../../category_type.dart';
import '../../asset_tables/action_button_section.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class TableRingkasan extends StatefulWidget {
  final BoxConstraints constraints;
  const TableRingkasan({super.key, required this.constraints});

  @override
  State<TableRingkasan> createState() => _TableRingkasanState();
}

class _TableRingkasanState extends State<TableRingkasan> {
  List<Map<String, dynamic>> _originalItems = [];
  List<Map<String, dynamic>> _filteredItems = [];
  TrinaGridStateManager? _stateManager;
  bool _isFirstLoad = true;
  bool get isMobile => widget.constraints.maxWidth < 768;
  double get maxW => widget.constraints.maxWidth;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      context.read<AsetRingkasanCariBloc>().add(
        RefreshAsetRingkasanCariEvent(
          searchText: _searchController.text,
          statusId: '10001', // Default status aktif
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsetRingkasanCariBloc, AsetRingkasanCariState>(
      builder: (context, state) {
        if (state.status == ListStatus.success) {
          if (_isFirstLoad) {
            _originalItems = state.items.map(_mapToJson).toList();
            _filteredItems = List.from(_originalItems);
            _isFirstLoad = false;
          }
          return Column(
            children: [
              ActionButtonSection(
                constraints: widget.constraints,
                selectedCategory: CategoryType.ringkasan,
                tableData: _originalItems,
                onDataFiltered: (filtered) {
                  setState(() => _filteredItems = filtered);
                  _stateManager!
                    ..removeAllRows()
                    ..appendRows(_buildRows(filtered))
                    ..setPage(1, notify: true);
                },
                visibleButtons: const [
                  ActionButtonType.tambahAset,
                  ActionButtonType.refresh,
                  ActionButtonType.unduh,
                  ActionButtonType.share,
                ],
                showStatusFilter: false,
                showSearchBox: true,

                onAddAsset: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎯 Tambah Aset KHUSUS untuk Tabel Ringkasan'),
                    ),
                  );
                },

                // ✅ Tambahkan ini untuk menghubungkan tombol "Unduh"
                onExportSelected: (format) async {
                  final messenger = ScaffoldMessenger.of(context);
                  try {
                    if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
                      // 💻 Web/Desktop
                      await ExportHelper.export(
                        format,
                        _filteredItems,
                        CategoryType.ringkasan,
                      );

                      // messenger.showSnackBar(
                      //   SnackBar(content: Text('✅ Berhasil mengunduh $format di web')),
                      // );
                    } else {
                      // 📱 Mobile
                      final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
                      final fileName = 'laporan_ringkasan.$extension';

                      await MobileDownloadHelper.download(
                        context: context,
                        fileName: fileName,
                        data: _filteredItems,
                        format: format,
                      );

                      messenger.showSnackBar(
                        SnackBar(content: Text('✅ Berhasil mengunduh $fileName di perangkat kamu')),
                      );
                    }
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(content: Text('❌ Gagal mengunduh file: $e')),
                    );
                  }
                },

                onRefresh: (searchText, statusId) {
                  context.read<AsetRingkasanCariBloc>().add(
                    RefreshAsetRingkasanCariEvent(
                      searchText: searchText,
                      statusId: statusId,
                    ),
                  );
                },
              ),

              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: TrinaGrid(
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

  Map<String, dynamic> _mapToJson(AsetRingkasanCariModel item) {
    return {
      'aset': item.asetNama,
      'jumlah': '${item.jmlAset} ${item.satuan}',
      'hargaPasar': item.nilaiAset,
      'hargaPertanggungan': item.nilaiPremi,
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
      _textCol('Aset', 'aset', maxW * 0.2),
      _textCol('Jumlah Aset', 'jumlah', maxW * 0.2),
      _textCol('Harga Pasar', 'hargaPasar', maxW * 0.2, isCurrency: true),
      _textCol('Harga Pertanggungan', 'hargaPertanggungan', maxW * 0.2, isCurrency: true),
    ];
  }

  TrinaColumn _textCol(String title, String field, double width, {bool isCurrency = false}) {
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
        final display = isCurrency
            ? currencyFormat.format(double.tryParse(value) ?? 0)
            : value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            display,
            style: TextStyle(
              fontFamily: 'Satoshi',
              fontSize: isMobile ? 10 : 14,
              fontWeight: isCurrency ? FontWeight.w500 : FontWeight.normal,
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
        'aset': TrinaCell(value: item['aset']),
        'jumlah': TrinaCell(value: item['jumlah']),
        'hargaPasar': TrinaCell(value: item['hargaPasar'].toString()),
        'hargaPertanggungan': TrinaCell(value: item['hargaPertanggungan'].toString()),
      });
    }).toList();
  }
}
