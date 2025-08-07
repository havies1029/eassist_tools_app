import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/blocs/gen_aset_mv/asetmvcari_bloc.dart';
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

class TableMv extends StatefulWidget {
  final BoxConstraints constraints;
  const TableMv({super.key, required this.constraints});

  @override
  State<TableMv> createState() => _TableMvState();
}

class _TableMvState extends State<TableMv> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  List<Map<String, dynamic>> _originalItems = [];
  TrinaGridStateManager? _stateManager;
  ActionButtonSection? _actionButton;
  bool _isAddMode = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AsetMvCariBloc>().add(
        RefreshAsetMvCariEvent(searchText: '', statusId: '10001'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final double colFactor = widget.constraints.maxWidth / 100;

    return Column(
      children: [
        if (_actionButton != null) _actionButton!,
        const SizedBox(height: 16),
        BlocBuilder<AsetMvCariBloc, AsetMvCariState>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(TrinaTableMapper.fromMv).toList();

              return GenericTrinaTable(
                columns: TrinaColumnBuilder.build(
                    columns: [
                      ColumnMeta(title: 'Jenis Kendaraan', field: 'jenis', widthFactor: 2.0),
                      ColumnMeta(title: 'Merk', field: 'merk', widthFactor: 1.5),
                      ColumnMeta(title: 'Type', field: 'type', widthFactor: 1.5),
                      ColumnMeta(title: 'Tahun', field: 'tahun', widthFactor: 1.2),
                      ColumnMeta(title: 'No Polisi', field: 'nopol', widthFactor: 1.8),
                      ColumnMeta(title: 'Harga Pertanggungan', field: 'tsi', widthFactor: 2.0, isCurrency: true),
                      ColumnMeta(title: 'Premi', field: 'premi', widthFactor: 1.8, isCurrency: true),
                      ColumnMeta(title: 'Status', field: 'status', widthFactor: 1.5, isStatus: true),
                    ],
                    showActionColumn: _isAddMode,
                  ),
                rows: TrinaRowBuilder.build(
                  _originalItems,
                  ['jenis', 'merk', 'type', 'tahun', 'nopol', 'tsi', 'premi', 'status'],
                ),
                onGridLoaded: (manager) {
                  _stateManager = manager;

                  setState(() {
                    _actionButton = ActionButtonSection(
                      key: _actionKey,
                      constraints: widget.constraints,
                      stateManager: _stateManager,
                      selectedCategory: CategoryType.kendaraan,
                      onEnterAddMode: () {
                        setState(() => _isAddMode = true);
                      },
                      onExitAddMode: () {
                        setState(() => _isAddMode = false);
                      },
                      tableData: _originalItems,
                      onExportSelected: (format) async {
                        final messenger = ScaffoldMessenger.of(context);
                        if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
                          await ExportHelper.export(format, _originalItems, CategoryType.kendaraan);
                          messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh ke perangkat Web/Desktop')));
                        } else {
                          final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
                          final fileName = 'laporan_kendaraan.$extension';
                          await MobileDownloadHelper.download(
                            context: context,
                            fileName: fileName,
                            data: _originalItems,
                            format: format,
                          );
                        }
                      },
                      onRefresh: (searchText, statusId) {
                        context.read<AsetMvCariBloc>().add(
                          RefreshAsetMvCariEvent(searchText: searchText, statusId: statusId),
                        );
                      },
                    );
                  });
                },
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