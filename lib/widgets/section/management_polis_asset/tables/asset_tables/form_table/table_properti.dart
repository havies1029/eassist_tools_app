import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
import 'package:eassist_tools_app/models/gen_aset_par/asetparcari_model.dart';
import '../../../../../../common/constants.dart';

class TableProperti extends StatelessWidget {
  final BoxConstraints constraints;
  TableProperti({super.key, required this.constraints});

  bool get isMobile => constraints.maxWidth < 768;
  double get maxW => constraints.maxWidth;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsetParCariBloc, AsetParCariState>(
      builder: (context, state) {
        if (state.status == ListStatus.success) {
          final items = state.items;
          debugPrint('🚀 Properti Loaded: \${items.length}');
          if (items.isNotEmpty) {
            final i = items.first;
            debugPrint('🔥 Sample Properti:\nAlamat: \${i.alamat}, TSI: \${i.sumInsured}');
          }

          final columns = _buildColumns();
          final rows = _buildRows(items);

          return SizedBox(
            height: 500, // ✅ penting agar terlihat
            child: TrinaGrid(
              columns: columns,
              rows: rows,
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
                event.stateManager.setPageSize(10, notify: true);
                event.stateManager.setPage(1);
              },
            ),
          );
        } else if (state.status == ListStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('No Data Available!!'));
        }
      },
    );
  }

  List<TrinaColumn> _buildColumns() {
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
      _textCol('No', 'no', 60),
      _textCol('Alamat', 'alamat', maxW * 0.2),
      _textCol('Harga Pertanggungan', 'tsi', maxW * 0.15, isCurrency: true),
      _textCol('Premi', 'premi', maxW * 0.1, isCurrency: true),
      _textCol('Klausa Bank', 'klausa', maxW * 0.15),
      _textCol('Status', 'status', maxW * 0.11, isStatus: true),
      _actionCol(),
    ];
  }

  TrinaColumn _textCol(String title, String field, double width, {bool isCurrency = false, bool isStatus = false}) {
    return TrinaColumn(
      title: title,
      field: field,
      type: isCurrency
          ? TrinaColumnType.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
          : TrinaColumnType.text(),
      titleSpan: TextSpan(text: title),
      width: width,
      minWidth: width,
      enableSorting: false,
      enableEditingMode: false,
      enableColumnDrag: false,
      enableContextMenu: false,
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

  TrinaColumn _actionCol() {
    return TrinaColumn(
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
                  .showSnackBar(SnackBar(content: Text('Melacak data ke-\${context.rowIdx + 1}')));
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
    );
  }

  List<TrinaRow> _buildRows(List<AsetParCariModel> items) {
    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;
      return TrinaRow(cells: {
        'checkbox': TrinaCell(value: ''),
        'no': TrinaCell(value: (i + 1).toString()),
        'alamat': TrinaCell(value: item.alamat),
        'tsi': TrinaCell(value: item.sumInsured.toString()),
        'premi': TrinaCell(value: item.premi.toString()),
        'klausa': TrinaCell(value: item.klausulaBank),
        'status': TrinaCell(value: item.status),
        'aksi': TrinaCell(value: ''),
      });
    }).toList();
  }
}
