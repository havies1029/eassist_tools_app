import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/blocs/gen_aset_ringkasan/asetringkasancari_bloc.dart';
import 'package:trina_grid/trina_grid.dart';
import '../../../../../../common/constants.dart';
import '../../../../../../helper/export_helper.dart';
import '../../../../../../helper/mobile_expert_helper.dart';
import '../../../category_type.dart';
import '../action_button_section.dart';

//TABLE
import '../table.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class TableRingkasan extends StatefulWidget {
  final BoxConstraints constraints;
  const TableRingkasan({super.key, required this.constraints});

  @override
  State<TableRingkasan> createState() => _TableRingkasanState();
}

class _TableRingkasanState extends State<TableRingkasan> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  List<Map<String, dynamic>> _originalItems = [];
  late final ActionButtonSection _actionButton;

  TrinaGridStateManager? _stateManager;

  bool get isMobile => widget.constraints.maxWidth < 768;

  @override
  void initState() {
    super.initState();
    _actionButton = ActionButtonSection(
      constraints: widget.constraints,
      selectedCategory: CategoryType.ringkasan,
      tableData: _originalItems,
      onDataFiltered: (filteredData) {
        setState(() {
          _originalItems = filteredData;
        });
      },
      visibleButtons: const [
        ActionButtonType.refresh,
        ActionButtonType.unduh,
        ActionButtonType.share,
      ],
      showSearchBox: true,
      onExportSelected: (format) async {
        final messenger = ScaffoldMessenger.of(context);
        if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          await ExportHelper.export(format, _originalItems, CategoryType.ringkasan);
          messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh ke perangkat Web/Desktop')));
        } else {
          final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
          final fileName = 'laporan_ringkasan.$extension';
          await MobileDownloadHelper.download(
            context: context,
            fileName: fileName,
            data: _originalItems,
            format: format,
          );
        }
      },
      onRefresh: (searchText, statusId) {
        context.read<AsetRingkasanCariBloc>().add(
          RefreshAsetRingkasanCariEvent(searchText: searchText, statusId: '10001'),
        );
      },
    );

    // Initial data load
    Future.delayed(Duration.zero, () {
      context.read<AsetRingkasanCariBloc>().add(
        RefreshAsetRingkasanCariEvent(searchText: '', statusId: '10001'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionButton,
        const SizedBox(height: 16),
        BlocBuilder<AsetRingkasanCariBloc, AsetRingkasanCariState>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(TrinaTableMapper.fromRingkasan).toList();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _actionKey.currentState?.updateTableData(_originalItems);
              });

              return GenericTrinaTable(
                columns: TrinaColumnBuilder.build(
                  columns: [
                    ColumnMeta(title: 'Aset', field: 'aset', widthFactor: 2.0),
                    ColumnMeta(title: 'Jumlah Aset', field: 'jumlah', widthFactor: 2.0),
                    ColumnMeta(title: 'Harga Pasar', field: 'hargaPasar', widthFactor: 2.5, isCurrency: true),
                    ColumnMeta(title: 'Harga Pertanggungan', field: 'hargaPertanggungan', widthFactor: 2.5, isCurrency: true),
                  ],
                ),
                rows: TrinaRowBuilder.build(_originalItems, ['aset', 'jumlah', 'hargaPasar', 'hargaPertanggungan']),
                onGridLoaded: (manager) => _stateManager = manager,
              );
            } else if (state.status == ListStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]
    );
  }
}