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
import 'dart:io' as io;

class TableProperti extends StatefulWidget {
  final BoxConstraints constraints;
  const TableProperti({super.key, required this.constraints});

  @override
  State<TableProperti> createState() => _TablePropertiState();
}

class _TablePropertiState extends State<TableProperti> {
  final GlobalKey<ActionButtonSectionState> _actionKey = GlobalKey();
  List<Map<String, dynamic>> _originalItems = [];
  TrinaGridStateManager? _stateManager;
  ActionButtonSection? _actionButton;
  bool _isAddMode = false;

  bool get isMobile => widget.constraints.maxWidth < 768;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      context.read<AsetParCariBloc>().add(
        RefreshAsetParCariEvent(statusId: '10001', searchText: ''),
      );
    });
  }

  void _rebuildTable() {
    if (_stateManager != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_actionButton != null) _actionButton!,
        const SizedBox(height: 16),
        BlocBuilder<AsetParCariBloc, AsetParCariState>(
          builder: (context, state) {
            if (state.status == ListStatus.success) {
              _originalItems = state.items.map(TrinaTableMapper.fromProperti).toList();

              return GenericTrinaTable(
                  columns: TrinaColumnBuilder.build(
                  columns: [
                    ColumnMeta(title: 'Alamat', field: 'alamat', widthFactor: 2.2),
                    ColumnMeta(title: 'Harga Pertanggungan', field: 'tsi', widthFactor: 2.0, isCurrency: true),
                    ColumnMeta(title: 'Premi', field: 'premi', widthFactor: 1.5, isCurrency: true),
                    ColumnMeta(title: 'Klausa Bank', field: 'klausa', widthFactor: 2.0),
                    ColumnMeta(title: 'Status', field: 'status', widthFactor: 1.4, isStatus: true),
                  ],
                  showActionColumn: !_isAddMode,
                ),
                rows: TrinaRowBuilder.build(_originalItems, ['alamat', 'tsi', 'premi', 'klausa', 'status'], showActionColumn: !_isAddMode,),
                  onGridLoaded: (manager) {
                    _stateManager = manager;

                    setState(() {
                      _actionButton = ActionButtonSection(
                        key: _actionKey,
                        constraints: widget.constraints,
                        stateManager: _stateManager,
                        selectedCategory: CategoryType.properti,
                        onEnterAddMode: () {
                          setState(() {
                            _isAddMode = true;
                          });
                          _rebuildTable();
                        },
                        onExitAddMode: () {
                          setState(() {
                            _isAddMode = false;
                          });
                          _rebuildTable();
                        },
                        tableData: _originalItems,
                        onExportSelected: (format) async {
                          final messenger = ScaffoldMessenger.of(context);
                          if (kIsWeb || io.Platform.isWindows || io.Platform.isMacOS || io.Platform.isLinux) {
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
                            RefreshAsetParCariEvent(searchText: searchText, statusId: statusId),
                          );
                        },
                      );
                    });
                  }
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
