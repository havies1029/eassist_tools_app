import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trina_grid/trina_grid.dart';
import 'package:flutter_svg/flutter_svg.dart';

// MODELS
import 'package:eassist_tools_app/models/gen_aset_par/asetparcari_model.dart';
import 'package:eassist_tools_app/models/gen_aset_ringkasan/asetringkasancari_model.dart';
import 'package:eassist_tools_app/models/gen_aset_mv/asetmvcari_model.dart';
import 'package:eassist_tools_app/models/gen_aset_health/asethealthcari_model.dart';

typedef TrinaCellBuilder = Widget Function(dynamic ctx);

class ColumnMeta {
  final String title;
  final String field;
  final double widthFactor;
  final bool isCurrency;
  final bool isStatus;
  final double minWidth;
  final bool useMinWidth;
  final bool isFrozen;
  final Widget Function(dynamic ctx)? cellBuilder;

  const ColumnMeta({
    required this.title,
    required this.field,
    this.widthFactor = 1.0,
    this.isCurrency = false,
    this.isStatus = false,
    this.minWidth = 100,
    this.useMinWidth = true,
    this.isFrozen = false,
    this.cellBuilder,
  });
}

// ========================== 🎨 TABLE CONFIG ==========================
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

  static final gridConfig = TrinaGridConfiguration(
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

  static TextStyle get normalText => textStyle;
  static TextStyle get currencyText =>
      textStyle.copyWith(fontWeight: FontWeight.w500);
}

// ========================== 🧱 COLUMN BUILDER ==========================
class TrinaColumnBuilder {
  static List<TrinaColumn> build({
    required List<ColumnMeta> columns,
    NumberFormat? currencyFormat,
    bool showActionColumn = true,
  }) {
    final format = currencyFormat ??
        NumberFormat.currency(
            locale: 'id_ID', symbol: 'IDR ', decimalDigits: 0);
    final result = <TrinaColumn>[];

    result.add(_baseColumn('', 'checkbox', 65, 36,
        enableRowChecked: true, isFrozen: true));
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

    for (final col in columns) {
      result.add(
        _baseColumn(
          col.title,
          col.field,
          col.minWidth * col.widthFactor,
          col.useMinWidth ? col.minWidth : 0,
          renderer: col.cellBuilder != null
              ? (ctx) => col.cellBuilder!(ctx)
              : (ctx) =>
                  _buildCell(ctx.cell.value?.toString() ?? '', col, format),
          titleRenderer: (_) => _buildTitle(col.title),
        ),
      );
    }

    if (showActionColumn) {
      result.add(actionColumn());
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
      type: TrinaColumnType.text(),
      enableRowChecked: enableRowChecked,
      enableContextMenu: false,
      enableEditingMode: false,
      enableDropToResize: false,
      enableColumnDrag: false,
      renderer: renderer,
      titleRenderer: titleRenderer,
    );
  }

  static TrinaColumn actionColumn({
    String title = 'Aksi',
    String field = 'aksi',
    double minWidth = 120,
    double width = 120,
    void Function(Map<String, dynamic> rowData)?,
  }) {
    return _baseColumn(
      title,
      field,
      width,
      minWidth,
      titleRenderer: (_) => _buildTitle(title),
      renderer: (ctx) => _buildActionCell(ctx),
    );
  }

  static Widget _buildActionCell(dynamic ctx) {
    final rowData = extractRowData(ctx);
    final idx = int.tryParse('${rowData['no'] ?? ''}') ?? 0;

    Widget buildButton({
      required String iconAsset,
      required Color color,
      required VoidCallback onTap,
    }) {
      final button = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 45,
          padding: const EdgeInsets.all(9.71),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(9.71),
          ),
          child: SvgPicture.asset(iconAsset, width: 25, height: 25),
        ),
      );

      return button;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildButton(
            iconAsset: 'assets/icons/lacak.svg',
            color: const Color(0xFF2EDCFF),
            onTap: () {
              ScaffoldMessenger.of(ctx.stateManager.gridKey.currentContext!)
                  .showSnackBar(
                      SnackBar(content: Text('Search ditekan (index: $idx)')));
            },
          ),
          const SizedBox(width: 8),
          buildButton(
            iconAsset: 'assets/icons/catatan.svg',
            color: const Color(0xFF92DE3F),
            onTap: () {
              final rowData = extractRowData(ctx);
              final context = ctx.stateManager.gridKey.currentContext!;

              final allFieldsText =
                  rowData.entries.map((e) => '${e.key}: ${e.value}').join('\n');

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Detail Row'),
                  content: Text(allFieldsText),
                ),
              );
            },
          ),
        ],
      ),
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

  static Widget _buildCell(
      String value, ColumnMeta col, NumberFormat currencyFormat) {
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
          style: TextStyle(
              color: colors[1], fontWeight: FontWeight.w500, fontSize: 15.35),
        ),
      );
    }

    final text = col.isCurrency
        ? currencyFormat.format(double.tryParse(value) ?? 0)
        : value;
    final style = col.isCurrency
        ? TrinaTableConfig.currencyText
        : TrinaTableConfig.normalText;

    return Padding(
      padding: TrinaTableConfig.cellPadding,
      child: Text(text, style: style, textAlign: TextAlign.left),
    );
  }
}

// ========================== 🧱 ROW BUILDER ==========================
class TrinaRowBuilder {
  static List<TrinaRow> build(
    List<Map<String, dynamic>> items,
    List<String> fields, {
    bool showActionColumn = true,
  }) {
    return items.asMap().entries.map((entry) {
      final i = entry.key;
      final item = entry.value;

      final cells = {
        'checkbox': TrinaCell(value: ''),
        'no': TrinaCell(value: (i + 1).toString()),
        ...{
          for (final field in fields)
            field: TrinaCell(value: item[field]?.toString() ?? '')
        },
        if (showActionColumn) 'aksi': TrinaCell(value: 'lacak'),
      };

      return TrinaRow(cells: cells);
    }).toList();
  }
}

Map<String, dynamic> extractRowData(dynamic ctx) {
  final Map<String, TrinaCell> cells =
      (ctx.row?.cells ?? <String, TrinaCell>{});
  return cells.map((k, v) => MapEntry(k, v.value));
}

// ========================== 🔁 DATA MAPPER ==========================
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

// ========================== 🧩 GENERIC TABLE ==========================
class GenericTrinaTable extends StatelessWidget {
  final List<TrinaColumn> columns;
  final List<TrinaRow> rows;
  final void Function(TrinaGridStateManager)? onGridLoaded;
  final double height;
  final bool isAddMode;

  const GenericTrinaTable({
    super.key,
    required this.columns,
    required this.rows,
    this.onGridLoaded,
    this.height = 500,
    this.isAddMode = false, // Default false
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
        createFooter: (stateManager) =>
            TrinaPagination(stateManager, pageSizeToMove: 1),
        onLoaded: (event) {
          onGridLoaded?.call(event.stateManager);
          event.stateManager.setPageSize(10, notify: true);
          event.stateManager.setPage(1);
        },
      ),
    );
  }
}
