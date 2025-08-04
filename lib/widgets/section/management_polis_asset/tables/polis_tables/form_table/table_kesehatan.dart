import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:eassist_tools_app/blocs/gen_aset_health/asethealthcari_bloc.dart';
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

class TableKesehatan extends StatefulWidget {
  final BoxConstraints constraints;
  const TableKesehatan({super.key, required this.constraints});

  @override
  State<TableKesehatan> createState() => _TableKesehatanState();
}

class _TableKesehatanState extends State<TableKesehatan> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  List<Map<String, dynamic>> _originalItems = [];
  TrinaGridStateManager? _stateManager;
  ActionButtonSection? _actionButton;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AsetHealthCariBloc>().add(
        RefreshAsetHealthCariEvent(statusId: '10001', searchText: ''),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_actionButton != null) _actionButton!,
        const SizedBox(height: 16),
        BlocBuilder<AsetHealthCariBloc, AsetHealthCariState>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(TrinaTableMapper.fromKesehatan).toList();

              WidgetsBinding.instance.addPostFrameCallback((_) {
                _actionKey.currentState?.updateTableData(_originalItems);
              });

              return GenericTrinaTable(
                columns: TrinaColumnBuilder.build(
                  columns: [
                    ColumnMeta(title: 'Nama', field: 'nama', widthFactor: 2.0),
                    ColumnMeta(title: 'Tanggal Lahir', field: 'tgl_lahir', widthFactor: 2.0),
                    ColumnMeta(title: 'Jenis Kelamin', field: 'jnskel', widthFactor: 1.5),
                    ColumnMeta(title: 'Posisi', field: 'posisi', widthFactor: 1.5),
                    ColumnMeta(title: 'Status', field: 'status', widthFactor: 1.2, isStatus: true),
                  ],
                ),
                rows: TrinaRowBuilder.build(
                  _originalItems,
                  ['nama', 'tgl_lahir', 'jnskel', 'posisi', 'status'],
                ),
                onGridLoaded: (manager) {
                  _stateManager = manager;

                  setState(() {
                    _actionButton = ActionButtonSection(
                      key: _actionKey,
                      constraints: widget.constraints,
                      stateManager: _stateManager,
                      selectedCategory: CategoryType.kesehatan,
                      tableData: _originalItems,
                      onExportSelected: (format) async {
                        final messenger = ScaffoldMessenger.of(context);
                        if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
                          await ExportHelper.export(format, _originalItems, CategoryType.kesehatan);
                          messenger.showSnackBar(const SnackBar(content: Text('✅ File berhasil diunduh ke perangkat Web/Desktop')));
                        } else {
                          final extension = format.toLowerCase() == 'pdf' ? 'pdf' : 'xlsx';
                          final fileName = 'laporan_kesehatan.$extension';
                          await MobileDownloadHelper.download(
                            context: context,
                            fileName: fileName,
                            data: _originalItems,
                            format: format,
                          );
                        }
                      },
                      onRefresh: (searchText, statusId) {
                        context.read<AsetHealthCariBloc>().add(
                          RefreshAsetHealthCariEvent(searchText: searchText, statusId: statusId),
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