import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

class RingkasanAsetTable extends StatefulWidget {
  final BoxConstraints constraints;

  const RingkasanAsetTable({super.key, required this.constraints});

  @override
  State<RingkasanAsetTable> createState() => _RingkasanAsetTableState();
}

class _RingkasanAsetTableState extends State<RingkasanAsetTable> {
  late List<TrinaColumn> columns;
  late List<TrinaRow> rows;

  bool get isMobile => widget.constraints.maxWidth < 768;

  @override
  void initState() {
    super.initState();
    columns = _buildColumns();
    rows = _buildRows();
  }

  List<TrinaColumn> _buildColumns() {
    return [
      TrinaColumn(
        title: 'No',
        field: 'no',
        type: TrinaColumnType.text(),
        width: 75,
        minWidth: 75,
      ),
      TrinaColumn(
        title: 'Aset',
        field: 'aset',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Jumlah aset',
        field: 'jumlahaset',
        type: TrinaColumnType.number(),
      ),
      TrinaColumn(
        title: 'Harga Pasar',
        field: 'hargapasar',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Harga Pertanggungan',
        field: 'hargapertanggungan',
        type: TrinaColumnType.text(),
      ),
    ];
  }

  List<TrinaRow> _buildRows() {
    final data = [
      {
        'no': '1',
        'aset': 'Properti',
        'jumlahaset': 3,
        'hargapasar': 'Rp 200.000.000',
        'hargapertanggungan': 'Rp 1.500.000',
      },
      {
        'no': '2',
        'aset': 'Kendaraan',
        'jumlahaset': 5,
        'hargapasar': 'Rp 500.000.000',
        'hargapertanggungan': 'Rp 2.500.000',
      },
      {
        'no': '3',
        'aset': 'Kesehatan',
        'jumlahaset': 2,
        'hargapasar': 'Rp 100.000.000',
        'hargapertanggungan': 'Rp 800.000',
      },
      {
        'no': '4',
        'aset': 'Marine Kargo',
        'jumlahaset': 1,
        'hargapasar': 'Rp 75.000.000',
        'hargapertanggungan': 'Rp 500.000',
      },
      {
        'no': '5',
        'aset': 'SDM',
        'jumlahaset': 4,
        'hargapasar': 'Rp 120.000.000',
        'hargapertanggungan': 'Rp 1.000.000',
      },
    ];

    return data.map((row) {
      return TrinaRow(
        cells: row.map((key, value) => MapEntry(key, TrinaCell(value: value))),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 360,
        child: TrinaGrid(
          columns: columns,
          rows: rows,
          mode: TrinaGridMode.readOnly,
          configuration: TrinaGridConfiguration(
            columnSize: TrinaGridColumnSizeConfig(
              autoSizeMode: TrinaAutoSizeMode.equal,
              resizeMode: TrinaResizeMode.none,
            ),
            style: TrinaGridStyleConfig(
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
          onLoaded: (event) => event.stateManager.setShowColumnFilter(false),
        ),
      ),
    );
  }
}