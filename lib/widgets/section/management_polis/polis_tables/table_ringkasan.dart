import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class RingkasanPolisTable extends StatefulWidget {
  final BoxConstraints constraints;

  const RingkasanPolisTable({super.key, required this.constraints});

  @override
  State<RingkasanPolisTable> createState() => _RingkasanPolisTableState();
}

class _RingkasanPolisTableState extends State<RingkasanPolisTable> {
  late List<PlutoColumn> columns;
  late List<PlutoRow> rows;

  bool get isMobile => widget.constraints.maxWidth < 768;

  @override
  void initState() {
    super.initState();
    columns = _buildColumns();
    rows = _buildRows();
  }

  List<PlutoColumn> _buildColumns() {
    return [
      PlutoColumn(
        title: 'No',
        field: 'no',
        type: PlutoColumnType.text(),
        width: 75,
        minWidth: 75,
      ),
      PlutoColumn(
        title: 'Polis',
        field: 'polis',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Jumlah Polis',
        field: 'jumlah',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'TSI',
        field: 'tsi',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Total Premi',
        field: 'premi',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  List<PlutoRow> _buildRows() {
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
      return PlutoRow(
        cells: row.map((key, value) => MapEntry(key, PlutoCell(value: value))),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 360,
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          mode: PlutoGridMode.readOnly,
          configuration: PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
              autoSizeMode: PlutoAutoSizeMode.equal,
              resizeMode: PlutoResizeMode.none,
            ),
            style: PlutoGridStyleConfig(
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