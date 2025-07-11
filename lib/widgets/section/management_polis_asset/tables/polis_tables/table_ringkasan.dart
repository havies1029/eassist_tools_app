import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';

class RingkasanPolisTable extends StatefulWidget {
  final BoxConstraints constraints;

  const RingkasanPolisTable({super.key, required this.constraints});

  @override
  State<RingkasanPolisTable> createState() => _RingkasanPolisTableState();
}

class _RingkasanPolisTableState extends State<RingkasanPolisTable> {
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
        title: 'Polis',
        field: 'polis',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Jumlah Polis',
        field: 'jumlah',
        type: TrinaColumnType.number(),
      ),
      TrinaColumn(
        title: 'TSI',
        field: 'tsi',
        type: TrinaColumnType.text(),
      ),
      TrinaColumn(
        title: 'Total Premi',
        field: 'premi',
        type: TrinaColumnType.text(),
      ),
    ];
  }

  List<TrinaRow> _buildRows() {
    final data = [
      {
        'no': '1',
        'polis': 'Properti',
        'jumlah': 3,
        'tsi': 'Rp 200.000.000',
        'premi': 'Rp 1.500.000',
      },
      {
        'no': '2',
        'polis': 'Kendaraan',
        'jumlah': 5,
        'tsi': 'Rp 500.000.000',
        'premi': 'Rp 2.500.000',
      },
      {
        'no': '3',
        'polis': 'Kesehatan',
        'jumlah': 2,
        'tsi': 'Rp 100.000.000',
        'premi': 'Rp 800.000',
      },
      {
        'no': '4',
        'polis': 'Marine Kargo',
        'jumlah': 1,
        'tsi': 'Rp 75.000.000',
        'premi': 'Rp 500.000',
      },
      {
        'no': '5',
        'polis': 'SDM',
        'jumlah': 4,
        'tsi': 'Rp 120.000.000',
        'premi': 'Rp 1.000.000',
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