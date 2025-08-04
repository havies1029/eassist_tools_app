import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';

// MODELS
import 'package:eassist_tools_app/models/gen_aset_par/asetparcari_model.dart';
import 'package:eassist_tools_app/models/gen_aset_ringkasan/asetringkasancari_model.dart';
import 'package:eassist_tools_app/models/gen_aset_mv/asetmvcari_model.dart';
import 'package:eassist_tools_app/models/gen_aset_health/asethealthcari_model.dart';

/// Column metadata for table definitions
class ColumnMeta {
  final String title;
  final String field;
  final double widthFactor;
  final bool isCurrency;
  final bool isStatus;
  final double minWidth;
  final bool useMinWidth;
  final bool isFrozen;

  ColumnMeta({
    required this.title,
    required this.field,
    this.widthFactor = 1.0,
    this.isCurrency = false,
    this.isStatus = false,
    this.minWidth = 100,
    this.useMinWidth = true,
    this.isFrozen = false,
  });
}

/// Table-wide config (style, grid config, etc)
class TrinaTableConfig {
  static const textStyle = TextStyle(
    fontFamily: 'Satoshi-Regular',
    fontSize: 15.89,
  );

  static const cellPadding = EdgeInsets.symmetric(horizontal: 4, vertical: 4);

  static const statusColors = {
    'aktif': [Color(0x3434C759), Color(0xFF34C759)],
    'akan berakhir': [Color(0x33FF3B30), Color(0xFFFF3B30)],
    'diproses': [Color(0x33FFC728), Color(0xFFFFC728)],
    'non aktif': [Color(0x33A6A6A6), Color(0xFFA6A6A6)],
    'default': [Color(0x33007AFF), Color(0xFF007AFF)],
  };

  static final TrinaGridConfiguration gridConfig = TrinaGridConfiguration(
    enableMoveHorizontalInEditing: false,
    columnSize: TrinaGridColumnSizeConfig(
      autoSizeMode: TrinaAutoSizeMode.none,
      resizeMode: TrinaResizeMode.none,
    ),
    scrollbar: TrinaGridScrollbarConfig(showHorizontal: true),
    style: TrinaGridStyleConfig(
      rowHeight: 100,
      columnHeight: 52.96,
      borderColor: Colors.grey[300]!,
      enableGridBorderShadow: true,
      gridBorderColor: Colors.grey[300]!,
      gridBorderRadius: BorderRadius.circular(20),
      gridPadding: 10,
      enableColumnBorderVertical: false,
      enableCellBorderVertical: false,
    ),
  );

  /// Helpers for text styles
  static TextStyle get normalText => textStyle;
  static TextStyle get currencyText => textStyle.copyWith(fontWeight: FontWeight.w500);
}

/// Column builder
class TrinaColumnBuilder {
  static List<TrinaColumn> build({
    required List<ColumnMeta> columns,
    NumberFormat? currencyFormat,
    bool showCheckbox = true,
    bool showNumber = true,
  }) {
    final format = currencyFormat ??
        NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);

    final result = <TrinaColumn>[];

    if (showCheckbox) {
      result.add(_baseColumn('', 'checkbox', 65, 36, enableRowChecked: true, isFrozen: true,));
    }

    if (showNumber) {
      result.add(
        _baseColumn(
          'No',
          'no',
          65,
          50,
          isFrozen: true,
          titleRenderer: (_) => _buildTitle('No'),
          renderer: (ctx) => Padding(
            padding: TrinaTableConfig.cellPadding,
            child: Text(
              ctx.cell.value?.toString() ?? '',
              style: TrinaTableConfig.normalText,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      );
    }

    for (final col in columns) {
      result.add(
        _baseColumn(
          col.title,
          col.field,
          col.minWidth * col.widthFactor,
          col.useMinWidth ? col.minWidth : 0,
          renderer: (ctx) => _buildCell(ctx.cell.value?.toString() ?? '', col, format),
          titleRenderer: (_) => _buildTitle(col.title),
        ),
      );
    }

    return result;
  }

  static TrinaColumn _baseColumn(
      String title,
      String field,
      double width,
      double minWidth, {
        Widget Function(dynamic)? renderer,
        Widget Function(dynamic)? titleRenderer,
        bool enableRowChecked = false,
        bool isFrozen = false,
      }) {
    return TrinaColumn(
      title: title,
      field: field,
      width: width,
      frozen: isFrozen ? TrinaColumnFrozen.start : TrinaColumnFrozen.none,
      minWidth: minWidth,
      type: TrinaColumnType.text(), // ✅ selalu text, formatting di _buildCell
      enableRowChecked: enableRowChecked,
      enableContextMenu: false,
      enableEditingMode: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      renderer: renderer,
      titleRenderer: titleRenderer,
    );
  }

  static Widget _buildTitle(String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        title.toUpperCase(),
        style: TrinaTableConfig.textStyle.copyWith(
          fontWeight: FontWeight.w500,
          color: const Color(0x661C1C1C),
        ),
      ),
    );
  }

  static Widget _buildCell(String value, ColumnMeta col, NumberFormat currencyFormat) {
    if (col.isStatus) {
      final colors = TrinaTableConfig.statusColors[value.toLowerCase()] ??
          TrinaTableConfig.statusColors['default']!;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: colors[0],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          textAlign: TextAlign.center,
          value,
          style: TextStyle(color: colors[1], fontWeight: FontWeight.w500, fontSize: 15.35),
        ),
      );
    }

    final text = col.isCurrency ? currencyFormat.format(double.tryParse(value) ?? 0) : value;
    final style = col.isCurrency ? TrinaTableConfig.currencyText : TrinaTableConfig.normalText;

    return Padding(
      padding: TrinaTableConfig.cellPadding,
      child: Text(text, style: style, textAlign: TextAlign.left),
    );
  }
}

/// Row builder
class TrinaRowBuilder {
  static List<TrinaRow> build(List<Map<String, dynamic>> items, List<String> fields) {
    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;

      final cells = {
        'checkbox': TrinaCell(value: ''),
        'no': TrinaCell(value: (i + 1).toString()),
      };

      for (final field in fields) {
        cells[field] = TrinaCell(value: item[field]?.toString() ?? '');
      }

      return TrinaRow(cells: cells);
    }).toList();
  }
}

/// Data mapper dari model ke map untuk row
class TrinaTableMapper {
  static final _dateFormat = DateFormat('dd MMM yyyy');

  static Map<String, dynamic> fromProperti(AsetParCariModel item) => {
    'alamat': item.alamat,
    'tsi': item.sumInsured,
    'premi': item.premi,
    'klausa': item.klausulaBank,
    'status': item.status,
  };

  static Map<String, dynamic> fromRingkasan(AsetRingkasanCariModel item) => {
    'aset': item.asetNama,
    'jumlah': '${item.jmlAset} ${item.satuan}',
    'hargaPasar': item.nilaiAset,
    'hargaPertanggungan': item.nilaiPremi,
  };

  static Map<String, dynamic> fromMv(AsetMvCariModel item) => {
    'jenis': item.jenisMv,
    'merk': item.merk,
    'type': item.tipe,
    'tahun': item.tahun,
    'nopol': item.noPolisi,
    'tsi': item.sumInsured,
    'premi': item.premi,
    'status': item.status,
  };

  static Map<String, dynamic> fromKesehatan(AsetHealthCariModel item) => {
    'no': item.nomor.toString(),
    'nama': item.nama,
    'tgl_lahir': item.dob != null ? _dateFormat.format(item.dob) : '',
    'jnskel': item.jnskel,
    'posisi': item.posisi,
    'status': item.status,
  };
}

/// Generic table widget
class GenericTrinaTable extends StatelessWidget {
  final List<TrinaColumn> columns;
  final List<TrinaRow> rows;
  final void Function(TrinaGridStateManager)? onGridLoaded;
  final double height;

  const GenericTrinaTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onGridLoaded,
    this.height = 500,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TrinaGrid(
        columns: columns,
        rows: rows,
        mode: TrinaGridMode.normal,
        configuration: TrinaTableConfig.gridConfig,
        createFooter: (stateManager) => TrinaPagination(stateManager, pageSizeToMove: 1),
        onLoaded: (event) {
          onGridLoaded?.call(event.stateManager);
          event.stateManager.setPageSize(10, notify: true);
          event.stateManager.setPage(1);
        },
      ),
    );
  }
}