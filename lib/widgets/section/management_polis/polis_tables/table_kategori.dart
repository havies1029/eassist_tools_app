import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'polis_category_type.dart';

class KategoriPolisTable extends StatefulWidget {
  final BoxConstraints constraints;
  final CategoryType category;

  const KategoriPolisTable({
    super.key,
    required this.constraints,
    required this.category,
  });

  @override
  State<KategoriPolisTable> createState() => _KategoriPolisTableState();
}

class _KategoriPolisTableState extends State<KategoriPolisTable> {
  late PlutoGridStateManager stateManager;
  bool get isMobile => widget.constraints.maxWidth < 768;
  Set<int> expandedRows = <int>{};

  @override
  void initState() {
    super.initState();
  }

  // Fungsi untuk toggle expansion
  void _toggleRowExpansion(int rowIndex) {
    setState(() {
      if (expandedRows.contains(rowIndex)) {
        expandedRows.remove(rowIndex);
      } else {
        expandedRows.add(rowIndex);
      }
    });
  }

  // Fungsi untuk mengecek apakah row memiliki content panjang
  bool _hasLongContent(PlutoRow row) {
    final longFields = ['alamat', 'ket', 'nama', 'barang', 'model'];

    for (final field in longFields) {
      if (row.cells.containsKey(field)) {
        final value = row.cells[field]?.value?.toString() ?? '';
        if (value.length > 30) {
          return true;
        }
      }
    }
    return false;
  }

  PlutoColumn _textCol(String title, String field,
      {bool isFixed = false, double width = 100, PlutoColumnType? customType}) {
    return PlutoColumn(
      title: title,
      field: field,
      type: customType ?? PlutoColumnType.text(),
      titleSpan: TextSpan(text: title),
      width: width,
      minWidth: width,
      frozen: isFixed ? PlutoColumnFrozen.start : PlutoColumnFrozen.none,
      renderer: (rendererContext) {
        final value = rendererContext.cell.value.toString();
        final rowIdx = rendererContext.rowIdx;
        final isExpanded = expandedRows.contains(rowIdx);

        // Khusus untuk kolom 'No' - tambahkan icon expand/collapse
        if (field == 'no') {
          final row = stateManager.refRows[rowIdx];
          final hasLongContent = _hasLongContent(row);

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            height: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Satoshi',
                      fontSize: isMobile ? 10 : 14,
                    ),
                  ),
                ),
                if (hasLongContent)
                  GestureDetector(
                    onTap: () => _toggleRowExpansion(rowIdx),
                    child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 18,
                      color: Colors.blue[600],
                    ),
                  ),
              ],
            ),
          );
        }

        // Untuk field lain yang bisa panjang
        final longFields = ['alamat', 'ket', 'nama', 'barang', 'model'];
        bool isLongField = longFields.contains(field);

        if (isLongField && value.length > 30) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: isExpanded
                  ? SingleChildScrollView(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: isMobile ? 10 : 14,
                  ),
                ),
              )
                  : Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'Satoshi',
                  fontSize: isMobile ? 10 : 14,
                ),
              ),
            ),
          );
        }

        // Default renderer untuk field lain
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          height: double.infinity,
          alignment: Alignment.centerLeft,
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

  List<PlutoColumn> _buildColumns(CategoryType type) {
    List<PlutoColumn> base;

    switch (type) {
      case CategoryType.properti:
        base = [
          _textCol('No', 'no', isFixed: false, width: 80),
          _textCol('Alamat', 'alamat', width: 250),
          _textCol('Luas Bangunan', 'luas', width: 120),
          _textCol('Tahun Dibangun', 'tahun', width: 120),
          _textCol('Premi', 'premi', width: 120),
        ];
        break;
      case CategoryType.kendaraan:
        base = [
          _textCol('No', 'no', isFixed: true, width: 80),
          _textCol('No Polisi', 'nopol', width: 120),
          _textCol('Merk', 'merk', width: 100),
          _textCol('Model', 'model', width: 200),
          _textCol('Tahun', 'tahun', width: 100),
          _textCol('Premi', 'premi', width: 120),
        ];
        break;
      case CategoryType.kesehatan:
        base = [
          _textCol('No', 'no', isFixed: true, width: 80),
          _textCol('Nama Peserta', 'nama', width: 200),
          _textCol('Usia', 'usia', width: 80),
          _textCol('Jenis Kelamin', 'jk', width: 120),
          _textCol('Premi', 'premi', width: 120),
        ];
        break;
      case CategoryType.marineKargo:
        base = [
          _textCol('No', 'no', isFixed: true, width: 80),
          _textCol('Asal', 'asal', width: 150),
          _textCol('Tujuan', 'tujuan', width: 150),
          _textCol('Jenis Barang', 'barang', width: 180),
          _textCol('Premi', 'premi', width: 120),
        ];
        break;
      case CategoryType.sdm:
        base = [
          _textCol('No', 'no', isFixed: true, width: 80),
          _textCol('Nama Pegawai', 'nama', width: 200),
          _textCol('Jabatan', 'jabatan', width: 120),
          _textCol('Departemen', 'departemen', width: 120),
          _textCol('Premi', 'premi', width: 120),
        ];
        break;
      case CategoryType.lain_lain:
        base = [
          _textCol('No', 'no', isFixed: true, width: 80),
          _textCol('Nama Polis', 'nama', width: 200),
          _textCol('Keterangan', 'ket', width: 250),
          _textCol('Premi', 'premi', width: 120),
        ];
        break;
      default:
        base = [
          _textCol('No', 'no', isFixed: true, width: 100),
          _textCol('Info', 'info'),
        ];
    }

    return [
      PlutoColumn(
        title: '',
        field: 'checkbox',
        type: PlutoColumnType.select([]),
        enableRowChecked: true,
        width: 75,
        minWidth: 75,
        frozen: PlutoColumnFrozen.start,
      ),
      ...base,
    ];
  }

  List<PlutoRow> _buildRows(CategoryType type) {
    List<List<String>> raw;

    switch (type) {
      case CategoryType.properti:
        raw = List.generate(50, (i) {
          final no = (i + 1).toString();
          return [
            no,
            'Jl. Contoh Alamat Yang Sangat Panjang Sekali No $no, RT 001 RW 002, Kelurahan Contoh Panjang Sekali, Kecamatan Test Yang Sangat Panjang, Jakarta Selatan 12345',
            '${100 + i}m²',
            '${2000 + (i % 20)}',
            '${1000000 + i * 10000}',
          ];
        });
        break;

      case CategoryType.kendaraan:
        raw = List.generate(30, (i) {
          return [
            '${i + 1}',
            'B ${(1000 + i)} ABC',
            'Toyota',
            'Avanza G ${(i % 3) + 1.3} MT Manual Transmission dengan Fitur Lengkap dan Nyaman untuk Keluarga Indonesia',
            '${2010 + (i % 15)}',
            '${2000000 + i * 15000}',
          ];
        });
        break;

      case CategoryType.kesehatan:
        raw = List.generate(20, (i) {
          return [
            '${i + 1}',
            'Peserta Nama Lengkap Yang Sangat Panjang Sekali Untuk Testing ${i + 1}',
            '${25 + (i % 40)}',
            i % 2 == 0 ? 'Laki-laki' : 'Perempuan',
            '${500000 + i * 5000}',
          ];
        });
        break;

      case CategoryType.marineKargo:
        raw = List.generate(10, (i) {
          return [
            '${i + 1}',
            'Pelabuhan A${i + 1}',
            'Pelabuhan B${i + 1}',
            'Barang ${['Elektronik Canggih dan Peralatan Rumah Tangga Modern Berkualitas Tinggi', 'Pakaian Jadi dan Tekstil Berkualitas Tinggi untuk Export', 'Furniture Kayu Jati dan Perabotan Rumah Tangga Mewah'][i % 3]}',
            '${800000 + i * 10000}',
          ];
        });
        break;

      case CategoryType.sdm:
        raw = List.generate(15, (i) {
          return [
            '${i + 1}',
            'Pegawai dengan Nama Lengkap Yang Sangat Panjang Untuk Testing ${i + 1}',
            ['Staf', 'Manajer', 'Direktur'][i % 3],
            ['IT', 'HRD', 'Marketing'][i % 3],
            '${700000 + i * 8000}',
          ];
        });
        break;

      case CategoryType.lain_lain:
        raw = List.generate(8, (i) {
          return [
            '${i + 1}',
            'Polis Tambahan ${i + 1}',
            'Keterangan tambahan no ${i + 1} yang sangat panjang dan berisi informasi detail mengenai polis asuransi ini beserta syarat dan ketentuan yang berlaku serta benefit yang didapatkan',
            '${400000 + i * 6000}',
          ];
        });
        break;

      default:
        raw = [
          ['1', 'Data tidak tersedia']
        ];
    }

    final colFields = _buildColumns(type).map((e) => e.field).toList();
    return raw.map((values) {
      final cells = <String, PlutoCell>{};
      cells['checkbox'] = PlutoCell(value: '');

      for (int i = 0; i < values.length; i++) {
        cells[colFields[i + 1]] = PlutoCell(value: values[i]);
      }

      return PlutoRow(cells: cells);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final columns = _buildColumns(widget.category);
    final rows = _buildRows(widget.category);

    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 505,
        child: PlutoGrid(
          columns: columns,
          rows: rows,
          mode: PlutoGridMode.select,
          onLoaded: (event) {
            stateManager = event.stateManager;
            stateManager.setShowColumnFilter(false);
            stateManager.setPageSize(10, notify: true);
            stateManager.setPage(1);
          },
          configuration: PlutoGridConfiguration(
            columnSize: PlutoGridColumnSizeConfig(
              autoSizeMode: PlutoAutoSizeMode.none,
              resizeMode: PlutoResizeMode.normal,
            ),
            style: PlutoGridStyleConfig(
              // Row height dinamis berdasarkan apakah ada yang di-expand
              rowHeight: expandedRows.isEmpty ? 40 : 100,
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
          createFooter: (stateManager) {
            return PlutoPagination(stateManager);
          },
        ),
      ),
    );
  }
}