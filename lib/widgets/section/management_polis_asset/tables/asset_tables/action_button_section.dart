import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../common/constants.dart';
import '../../../../../blocs/gen_status_aset/statusasetcari_bloc.dart';
import '../../../../dialog/popup/donwload_popup.dart';
import '../../category_type.dart';

enum ActionButtonType {
  tambahAset,
  refresh,
  unduh,
  share,
  hapus,
  perbarui
}

const Map<ActionButtonType, Map<String, dynamic>> _buttonConfig = {
  ActionButtonType.tambahAset: {
    'icon': 'assets/icons/tambah_polis.svg',
    'label': 'Tambah Aset',
    'color': Color(0xFF007AFF),
  },
  ActionButtonType.refresh: {
    'icon': 'assets/icons/refresh.svg',
    'label': 'Refresh',
    'color': Color(0xFF00BFEF),
  },
  ActionButtonType.perbarui: {
    'icon': 'assets/icons/edit.svg',
    'label': 'Perbarui',
    'color': Color(0xFFFFC728),
  },
  ActionButtonType.unduh: {
    'icon': 'assets/icons/unduh.svg',
    'label': 'Unduh data',
    'color': Color(0xFF00CC4B),
  },
  ActionButtonType.share: {
    'icon': 'assets/icons/share.svg',
    'label': '',
    'color': Color(0xFF5C5FFF),
  },
  ActionButtonType.hapus: {
    'icon': 'assets/icons/hapus.svg',
    'label': '',
    'color': Color(0xFFFF0000),
  },
};

String _mapStatusToId(String statusLabel) {
  switch (statusLabel.toLowerCase()) {
    case 'aktif':
      return '10002';
    case 'non aktif':
      return '10003';
    case 'diproses':
      return '10004';
    case 'berakhir':
      return '10005';
    default:
      return '10001';
  }
}

class ActionButtonSection extends StatefulWidget {
  final BoxConstraints constraints;
  final CategoryType? selectedCategory;
  final List<Map<String, dynamic>>? tableData;
  final List<ActionButtonType> visibleButtons;
  final bool showSearchBox;
  final bool showStatusFilter;
  final VoidCallback? onAddAsset;
  final void Function(String format)? onExportSelected;
  final void Function(String searchText, String statusId)? onRefresh;
  final TrinaGridStateManager? stateManager;
  final Function(List<Map<String, dynamic>>)? onDataFiltered;
  final VoidCallback? onEnterAddMode;
  final VoidCallback? onExitAddMode;

  const ActionButtonSection({
    super.key,
    required this.constraints,
    this.selectedCategory,
    this.tableData,
    this.visibleButtons = ActionButtonType.values,
    this.showSearchBox = true,
    this.showStatusFilter = true,
    this.onAddAsset,
    this.onExportSelected,
    this.onRefresh,
    this.stateManager,
    this.onDataFiltered,
    this.onEnterAddMode,
    this.onExitAddMode,
  });

  @override
  State<ActionButtonSection> createState() => ActionButtonSectionState();
}

class ActionButtonSectionState extends State<ActionButtonSection> {
  /// Responsives Layout Helper
  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 992;
  double get maxWidth {
    if (widget.constraints.maxWidth > 1200) return 1200.0;
    return isTablet
        ? widget.constraints.maxWidth * 0.95
        : widget.constraints.maxWidth * 0.9;
  }
  double get horizontalPadding {
    final w = widget.constraints.maxWidth;
    if (w > 1200) return 15;
    if (w > 992) return 12;
    if (w > 768) return 10;
    return 7;
  }
  bool get shouldShowFilter =>
      widget.showStatusFilter &&
          widget.selectedCategory != null &&
          widget.selectedCategory != CategoryType.ringkasan;

  /// Controller, State Variables, Row Tracking
  final TextEditingController _catatanController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  bool _isAddMode = false;
  List<TrinaRow> _rowsBackup = [];
  TrinaRow? _draftRow;
  Set<String> _selectedRowIds = {};
  String _searchText = '';
  String _activeStatusFilter = 'Semua';

  List<TrinaRow> get _checkedRows => widget.stateManager?.checkedRows ?? [];
  final Set<String> _blockedFields = {'checkbox', 'no', 'status', 'aksi'};
  int get _selectedCount => _checkedRows.length;

  /// Lifecycle Methods
  @override
  void initState() {
    super.initState();

    final bloc = context.read<StatusAsetCariBloc>();
    if (bloc.state.items.isEmpty) {
      bloc.add(RefreshStatusAsetCariEvent());
    }
    widget.stateManager?.addListener(_onSelectionChanged);
  }

  @override
  void didUpdateWidget(ActionButtonSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.stateManager != widget.stateManager) {
      oldWidget.stateManager?.removeListener(_onSelectionChanged);
      widget.stateManager?.addListener(_onSelectionChanged);
      _restoreSelection();
    }

    if (oldWidget.tableData != widget.tableData && widget.tableData!.isEmpty) {
      _resetFilters();
    }

    if (oldWidget.tableData != widget.tableData) {
      _applyFilters();
      _restoreSelection();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _catatanController.dispose();
    widget.stateManager?.removeListener(_onSelectionChanged);
    super.dispose();
  }

  /// Listener Functions
  void _onSelectionChanged() {
    final checked = widget.stateManager?.checkedRows ?? [];
    _selectedRowIds
      ..clear()
      ..addAll(
        checked
            .map((row) => row.cells['id']?.value)
            .where((id) => id != null)
            .map((id) => id.toString()),
      );

    if (mounted) setState(() {});
  }

  void _restoreSelection() {
    final manager = widget.stateManager;
    if (manager == null) return;

    for (final row in manager.refRows) {
      final id = row.cells['id']?.value.toString();
      if (id != null && _selectedRowIds.contains(id)) {
        row.setChecked(true);
      }
    }

    _onSelectionChanged();
  }

  /// Filtering Helpers
  void _resetFilters() {
    setState(() {
      _activeStatusFilter = 'Semua';
      _searchText = '';
      _searchController.clear();
    });
  }

  void _applyFilters() {
    if (widget.tableData == null) return;

    List<Map<String, dynamic>> filteredData = List.from(widget.tableData!);

    if (_searchText.isNotEmpty) {
      filteredData = filteredData.where((item) {
        String searchableText = _buildSearchableText(item);
        return searchableText.toLowerCase().contains(_searchText.toLowerCase());
      }).toList();
    }

    if (widget.showStatusFilter && _activeStatusFilter != 'Semua') {
      filteredData = filteredData.where((item) {
        String status = item['status']?.toString() ?? '';
        return _mapStatusFilter(status) == _activeStatusFilter;
      }).toList();
    }

    widget.onDataFiltered?.call(filteredData);
  }

  void _filterAndSend() {
    final raw = widget.tableData ?? [];
    List<Map<String, dynamic>> result = List.from(raw);

    if (_searchText.isNotEmpty) {
      result = result.where((item) {
        return item.entries.any((e) =>
            e.value.toString().toLowerCase().contains(_searchText.toLowerCase()));
      }).toList();
    }

    if (_activeStatusFilter != 'Semua') {
      result = result.where((item) {
        final status = item['status']?.toString().toLowerCase() ?? '';
        return status.contains(_activeStatusFilter.toLowerCase());
      }).toList();
    }

    widget.onDataFiltered?.call(result);
  }

  List<Map<String, dynamic>> _getFilteredData() {
    if (widget.tableData == null) return [];

    List<Map<String, dynamic>> filteredData = List.from(widget.tableData!);

    if (_searchText.isNotEmpty) {
      filteredData = filteredData.where((item) {
        String searchableText = _buildSearchableText(item);
        return searchableText.contains(_searchText.toLowerCase());
      }).toList();
    }

    if (_activeStatusFilter != 'Semua') {
      filteredData = filteredData.where((item) {
        String status = item['status']?.toString() ?? '';
        return _mapStatusFilter(status) == _activeStatusFilter;
      }).toList();
    }

    return filteredData;
  }

  String _mapStatusFilter(String status) {
    // Map your API status to filter options
    switch (status.toLowerCase()) {
      case 'active':
      case 'aktif':
        return 'Aktif';
      case 'inactive':
      case 'non aktif':
        return 'Non Aktif';
      case 'processing':
      case 'sedang diproses':
      case 'diproses':
        return 'Diproses';
      case 'expired':
      case 'berakhir':
        return 'Berakhir';
      default:
        return status;
    }
  }

  String _buildSearchableText(Map<String, dynamic> item) {
    return item.entries
        .where((e) => e.value != null)
        .map((e) => e.value.toString())
        .join(' ')
        .toLowerCase();
  }

  /// UI Interaction Helpers
  void _onSearchChanged(String value) {
    setState(() {
      _searchText = value;
    });
    _filterAndSend();
    widget.onRefresh?.call(
      _searchText,
      _mapStatusToId(_activeStatusFilter),
    );
  }

  void _onFilterChanged(String value) {
    setState(() {
      _activeStatusFilter = value;
    });
    _filterAndSend();
    widget.onRefresh?.call(
      _searchText,
      _mapStatusToId(_activeStatusFilter),
    );
  }

  void _setAddModeEditing(bool enabled) {
    final mgr = widget.stateManager;
    if (mgr == null) return;

    for (final col in mgr.refColumns) {
      col.enableEditingMode = !_blockedFields.contains(col.field) && enabled;
    }
    mgr.notifyListeners();
  }

  String? _firstEditableField() {
    final mgr = widget.stateManager;
    if (mgr == null) return null;

    for (final col in mgr.refColumns) {
      if (!_blockedFields.contains(col.field)) {
        return col.field;
      }
    }
    return null;
  }

  /// Button Handlers (Add, Refresh, Delete, etc)
  void _handleButtonAction(ActionButtonType type) {
    final filteredData = _getFilteredData();

    switch (type) {
      case ActionButtonType.refresh:
        _handleRefresh();
        break;
      case ActionButtonType.unduh:
        _handleDownload(filteredData);
        break;
      case ActionButtonType.share:
        _handleShare(filteredData);
        break;
      case ActionButtonType.hapus:
        _handleDelete(filteredData);
        break;
      case ActionButtonType.perbarui:
        _handlePerbarui(filteredData);
        break;
      case ActionButtonType.tambahAset:
        _handleAddAsset();
        break;
    }
  }

  void _handleRefresh() {
    _resetFilters();

    if (widget.onRefresh != null) {
      widget.onRefresh!(
        _searchController.text,
        _mapStatusToId(_activeStatusFilter),
      );
    }
  }

  void _handleDownload(List<Map<String, dynamic>> data) {
    showDialog(
      context: context,
      builder: (context) => DownloadPopup(
        onExportSelected: (format) {
          widget.onExportSelected?.call(format);
        },
      ),
    );
  }

  void _handleShare(List<Map<String, dynamic>> data) {
    final manager = widget.stateManager;
    final checked = manager?.checkedRows ?? [];

    if (checked.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Pilih data dulu untuk dibagikan')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('📤 ${checked.length} aset berhasil dibagikan')),
    );
  }

  void _handleDelete(List<Map<String, dynamic>> data) {
    final manager = widget.stateManager;
    if (manager == null) return;

    final checkedRows = manager.checkedRows;

    if (checkedRows.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Pilih data dulu sebelum hapus')),
      );
      return;
    }

    for (var row in checkedRows) {
      manager.removeRows([row]);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ ${checkedRows.length} data berhasil dihapus')),
    );
  }

  void _handlePerbarui(List<Map<String, dynamic>> data) {
    final manager = widget.stateManager;
    final checked = manager?.checkedRows ?? [];

    if (checked.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ Pilih data dulu untuk diperbarui')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('📤 ${checked.length} aset berhasil diperbarui')),
    );
  }

  void _handleAddAsset() {
    if (widget.onAddAsset != null) {
      widget.onAddAsset!();
      return;
    }

    final manager = widget.stateManager;
    if (manager == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('StateManager tidak ada')),
      );
      return;
    }

    // backup
    _rowsBackup = List<TrinaRow>.from(manager.refRows);

    // clear dan buat draft
    manager.removeAllRows();
    final row = manager.getNewRows(count: 1).first;

    final nextNo = _rowsBackup.length + 1;
    row.cells['no']?.value = nextNo.toString();
    row.cells['status']?.value = 'Diproses';

    manager.appendRows([row]);

    // aktifkan edit utk semua kolom selain blocked
    _setAddModeEditing(true);

    // fokus ke kolom editable pertama
    final field = _firstEditableField();
    if (field != null && row.cells.containsKey(field)) {
      manager.setCurrentCell(row.cells[field], 0);
    }
    manager.setEditing(true);
    manager.setKeepFocus(true);

    setState(() {
      _isAddMode = true;
      _draftRow = row;
    });

    widget.onEnterAddMode?.call();
  }

  void _cancelAddMode() {
    final manager = widget.stateManager;
    if (manager == null) return;

    manager.setEditing(false);
    _setAddModeEditing(false);

    manager.removeAllRows();
    if (_rowsBackup.isNotEmpty) manager.appendRows(_rowsBackup);

    setState(() {
      _isAddMode = false;
      _draftRow = null;
      _rowsBackup = [];
    });
    widget.onExitAddMode?.call();
  }

  void _saveAddMode() {
    final manager = widget.stateManager;
    if (manager == null || _draftRow == null) return;

    manager.setEditing(false);
    _setAddModeEditing(false);

    final restored = List<TrinaRow>.from(_rowsBackup)..add(_draftRow!);
    manager.removeAllRows();
    _draftRow?.cells['catatan']?.value = _catatanController.text;
    manager.appendRows(restored);

    manager.setCurrentCell(_draftRow!.cells.entries.first.value, restored.length - 1);
    manager.setKeepFocus(true);

    setState(() {
      _isAddMode = false;
      _draftRow = null;
      _rowsBackup = [];
    });
    widget.onExitAddMode?.call();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Data berhasil disimpan')),
    );
  }

  /// Build UI Fragments

  Widget _buildButton(ActionButtonType type) {
    if (!widget.visibleButtons.contains(type)) return const SizedBox.shrink();
    final config = _buttonConfig[type]!;
    return _ActionButton(
      imageAsset: config['icon'],
      label: config['label'],
      color: config['color'],
      isMobile: isMobile,
      onPressed: () => _handleButtonAction(type),
    );
  }

  Widget _buildButtonsGroup(List<ActionButtonType> types) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map(_buildButton).toList(),
    );
  }

  Widget _buildSelectedBanner() {
    if (_selectedCount == 0) return const SizedBox.shrink();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: double.infinity,
        key: ValueKey('selected_$_selectedCount'),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0x80007AFF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Dipilih: $_selectedCount Aset',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChipsIfNeeded() {
    if (!shouldShowFilter) return const SizedBox.shrink();
    return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: BlocBuilder<StatusAsetCariBloc, StatusAsetCariState>(
          builder: (context, state) {
            if (state.status == ListStatus.loading || state.items.isEmpty) {
              return const SizedBox.shrink();
            }

            final rawOptions = state.items.map((e) => e.statusNama).toSet().toList();
            final statusOptions = ['Semua', ...rawOptions.where((e) => e.toLowerCase() != 'semua')];

            return _StatusFilterChips(
              active: _activeStatusFilter,
              options: statusOptions,
              onChanged: _onFilterChanged,
            );
          },
        )
    );
  }

  Widget _buildDesktopLayout() {
    if (_isAddMode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 8,
            children: [
              ElevatedButton(onPressed: _saveAddMode, child: const Text('Simpan')),
              OutlinedButton(onPressed: _cancelAddMode, child: const Text('Batal')),
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButtonsGroup([
              ActionButtonType.hapus,
              ActionButtonType.tambahAset,
              ActionButtonType.perbarui,
            ]),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _buildButton(ActionButtonType.unduh),
                _buildButton(ActionButtonType.share),
                if (widget.showSearchBox)
                  _SearchBox(
                    isMobile: isMobile,
                    hintText: 'Cari Aset',
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildButton(ActionButtonType.refresh),
            if (shouldShowFilter)
              Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: BlocBuilder<StatusAsetCariBloc, StatusAsetCariState>(
                      builder: (context, state) {
                        if (state.status == ListStatus.loading || state.items.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        final rawOptions = state.items.map((e) => e.statusNama).toSet().toList();
                        final statusOptions = ['Semua', ...rawOptions.where((e) => e.toLowerCase() != 'semua')];

                        return _StatusFilterChips(
                          active: _activeStatusFilter,
                          options: statusOptions,
                          onChanged: _onFilterChanged,
                        );
                      },
                    )
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        _buildSelectedBanner(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    if (_isAddMode) {
      return Row(
        children: [
          Expanded(
            child: ElevatedButton(onPressed: _saveAddMode, child: const Text('Simpan')),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(onPressed: _cancelAddMode, child: const Text('Batal')),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showSearchBox)
          _SearchBox(
            isMobile: isMobile,
            hintText: 'Cari Aset',
            controller: _searchController,
            onChanged: _onSearchChanged,
          ),
        const SizedBox(height: 12),
        if (shouldShowFilter) ...[
          _buildStatusChipsIfNeeded(),
          const SizedBox(height: 12),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButtonsGroup([
              ActionButtonType.hapus,
              ActionButtonType.tambahAset,
              ActionButtonType.perbarui
            ]),
            _buildButtonsGroup([
              ActionButtonType.unduh,
              ActionButtonType.share,
            ]),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildButton(ActionButtonType.refresh),
        ),
        const SizedBox(height: 12),
        _buildSelectedBanner(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 15
            ),
            child: Column(
              children: [
                // Main content
                isMobile ? _buildMobileLayout() : _buildDesktopLayout(),

                if (_isAddMode)
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/catatan.svg',
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Catatan Tambahan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _catatanController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Contoh: "Menambah Aset Baru"',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String imageAsset;
  final String label;
  final Color color;
  final bool isMobile;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.imageAsset,
    required this.label,
    required this.color,
    required this.isMobile,
    this.onPressed,
  });

  // Consolidated button styles
  Size get _buttonSize => isMobile ? const Size(40, 36) : const Size.fromHeight(40);
  Size? get _minimumSize => isMobile ? const Size(40, 36) : null;
  EdgeInsets get _padding => isMobile ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 8);
  double get _borderRadius => isMobile ? 4.0 : 6.0;
  double get _iconSize => isMobile ? 19.0 : 18.0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: _padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_borderRadius),
        ),
        elevation: 0,
        fixedSize: _buttonSize,
        visualDensity: VisualDensity.compact,
        minimumSize: _minimumSize,
      ),
      child: isMobile
          ? SvgPicture.asset(
        imageAsset,
        width: _iconSize,
        height: _iconSize,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            imageAsset,
            width: _iconSize,
            height: _iconSize,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Satoshi',
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchBox extends StatefulWidget {
  final bool isMobile;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const _SearchBox({
    required this.isMobile,
    required this.hintText,
    required this.controller,
    this.onChanged,
  });

  @override
  State<_SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<_SearchBox> {
  final FocusNode _focusNode = FocusNode();

  // Consolidated search box dimensions
  double get _width => widget.isMobile ? double.infinity : 300;
  double get _height => widget.isMobile ? 32.0 : 40.0;
  double get _padding => widget.isMobile ? 5.0 : 8.0;
  double get _borderRadius => widget.isMobile ? 8.0 : 10.0;
  double get _iconSize => widget.isMobile ? 23.0 : 24.0;
  double get _fontSize => widget.isMobile ? 15.0 : 16.0;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: _width,
      height: _height,
      padding: EdgeInsets.symmetric(horizontal: _padding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF79AB43), width: 1),
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.black, size: _iconSize),
          const SizedBox(width: 8),
          Flexible(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: _fontSize),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusFilterChips extends StatelessWidget {
  final String active;
  final List<String> options;
  final void Function(String) onChanged;

  const _StatusFilterChips({
    required this.active,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((status) {
        final isSelected = active == status;
        return ChoiceChip(
          label: Text(
            status,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 15
            ),
          ),
          selected: isSelected,
          onSelected: (_) => onChanged(status),
          selectedColor: Colors.blue,
          backgroundColor: Colors.white,
          shape: StadiumBorder(
            side: BorderSide(
              color: Colors.blue,
            ),
          ),
          showCheckmark: false,
        );
      }).toList(),
    );
  }
}