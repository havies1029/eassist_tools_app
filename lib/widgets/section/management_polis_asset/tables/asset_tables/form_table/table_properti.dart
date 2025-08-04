import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_aset_par/asetparcari_bloc.dart';
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

class TableProperti extends StatefulWidget {
  final BoxConstraints constraints;
  const TableProperti({super.key, required this.constraints});

  @override
  State<TableProperti> createState() => _TablePropertiState();
}

class _TablePropertiState extends State<TableProperti> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  late final ActionButtonSection _actionButton;
  List<Map<String, dynamic>> _originalItems = [];
  TrinaGridStateManager? _stateManager;

  bool get isMobile => widget.constraints.maxWidth < 768;

  @override
  void initState() {
    super.initState();

    _actionButton = ActionButtonSection(
      key: _actionKey,
      constraints: widget.constraints,
      selectedCategory: CategoryType.properti,
      tableData: _originalItems,
      onAddAsset: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('🏡 Tambah Aset Properti dijalankan')),
        );
      },
      onExportSelected: (format) async {
        final messenger = ScaffoldMessenger.of(context);
        if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
          await ExportHelper.export(format, _originalItems, CategoryType.properti);
          messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh ke perangkat Web/Desktop')));
        } else {
          final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
          final fileName = 'laporan_properti.$extension';
          await MobileDownloadHelper.download(
            context: context,
            fileName: fileName,
            data: _originalItems,
            format: format,
          );
        }
      },
      onRefresh: (searchText, statusId) {
        context.read<AsetParCariBloc>().add(
          RefreshAsetParCariEvent(statusId: statusId, searchText: searchText),
        );
      },
    );

    Future.delayed(Duration.zero, () {
      context.read<AsetParCariBloc>().add(
        RefreshAsetParCariEvent(statusId: '10001', searchText: ''),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionButton,
        const SizedBox(height: 16),
        BlocBuilder<AsetParCariBloc, AsetParCariState>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(TrinaTableMapper.fromProperti).toList();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _actionKey.currentState?.updateTableData(_originalItems);
              });

              return GenericTrinaTable(
                columns: TrinaColumnBuilder.build(
                  columns: [
                    ColumnMeta(title: 'Alamat', field: 'alamat', widthFactor: 2.2),
                    ColumnMeta(title: 'Harga Pertanggungan', field: 'tsi', widthFactor: 2.0, isCurrency: true),
                    ColumnMeta(title: 'Premi', field: 'premi', widthFactor: 1.5, isCurrency: true),
                    ColumnMeta(title: 'Klausa Bank', field: 'klausa', widthFactor: 2.0),
                    ColumnMeta(title: 'Status', field: 'status', widthFactor: 1.4, isStatus: true),
                  ],
                ),
                rows: TrinaRowBuilder.build(_originalItems, ['alamat', 'tsi', 'premi', 'klausa', 'status']),
                onGridLoaded: (manager) => _stateManager = manager,
              );
            } else if (state.status == ListStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
