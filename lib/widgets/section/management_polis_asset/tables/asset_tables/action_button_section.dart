import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../common/constants.dart';
import '../../../../dialog/popup/donwload_popup.dart';
import '../../category_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eassist_tools_app/blocs/gen_status_aset/statusasetcari_bloc.dart';

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
      return '10001'; // Semua
  }
}

enum ActionButtonType {
  tambahAset,
  refresh,
  unduh,
  share,
  hapus,
}

class ActionButtonSection extends StatefulWidget {
  final BoxConstraints constraints;
  final CategoryType? selectedCategory;
  final List<Map<String, dynamic>>? tableData; // Data dari TableMain
  final Function(List<Map<String, dynamic>>)? onDataFiltered; // Callback untuk mengirim data yang sudah difilter
  final List<ActionButtonType> visibleButtons;
  final bool showSearchBox;
  final bool showStatusFilter;
  final VoidCallback? onAddAsset;
  final void Function(String format)? onExportSelected;
  final void Function(String searchText, String statusId)? onRefresh;

  const ActionButtonSection({
    super.key,
    required this.constraints,
    this.selectedCategory,
    this.tableData,
    this.onDataFiltered,
    this.visibleButtons = ActionButtonType.values, // ✅ semua tombol default aktif
    this.showSearchBox = true,
    this.showStatusFilter = true,
    this.onAddAsset,
    this.onExportSelected,
    this.onRefresh,
  });


  @override
  State<ActionButtonSection> createState() => ActionButtonSectionState();
}

class ActionButtonSectionState extends State<ActionButtonSection> {
  // Consolidated responsive breakpoints
  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 992;
  // bool get shouldShowFilter => widget.selectedCategory != null && widget.selectedCategory != CategoryType.ringkasan;
  bool get shouldShowFilter =>
      widget.showStatusFilter &&
          widget.selectedCategory != null &&
          widget.selectedCategory != CategoryType.ringkasan;

  // Consolidated layout dimensions
  double get horizontalPadding {
    if (widget.constraints.maxWidth > 1200) return 15.0;
    if (widget.constraints.maxWidth > 992) return 12.0;
    return isTablet ? 10.0 : 7.0;
  }

  double get maxWidth {
    if (widget.constraints.maxWidth > 1200) return 1200.0;
    return isTablet
        ? widget.constraints.maxWidth * 0.95
        : widget.constraints.maxWidth * 0.9;
  }

  // Consolidated button configuration
  static const Map<ActionButtonType, Map<String, dynamic>> _buttonConfig = {
    ActionButtonType.tambahAset: {
      'icon': 'assets/icons/tambah_polis.svg',
      'label': 'Tambah Aset',
      'color': Color(0xFF007AFF),
    },
    ActionButtonType.refresh: {
      'icon': 'assets/icons/refresh.png',
      'label': 'Perbarui',
      'color': Color(0xFF00BFEF),
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
  //
  // static const List<String> _statusFilters = [
  //   'Semua', 'Aktif', 'Non Aktif', 'Diproses', 'Berakhir'
  // ];

  String _activeStatusFilter = 'Semua';
  String _searchText = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final bloc = context.read<StatusAsetCariBloc>();
    if (bloc.state.items.isEmpty) {
      bloc.add(RefreshStatusAsetCariEvent());
    }
    debugPrint('🔥 Category in ActionButtonSection: ${widget.selectedCategory}');
  }

  @override
  void didUpdateWidget(ActionButtonSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Jika kategori berubah, reset filter dan search
    // Hindari reset jika tableData tetap sama
    if (oldWidget.selectedCategory != widget.selectedCategory &&
        widget.tableData!.isEmpty) {
      debugPrint('[🔁 RESET FILTER karena kategori beneran berubah]');
      _resetFilters();
    }
    // Jika table data berubah, apply filter ulang
    if (oldWidget.tableData != widget.tableData) {
      _applyFilters();
    }
  }

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

    // Apply search filter
    if (_searchText.isNotEmpty) {
      filteredData = filteredData.where((item) {
        String searchableText = _buildSearchableText(item);
        return searchableText.toLowerCase().contains(_searchText.toLowerCase());
      }).toList();
    }

    // Apply status filter
    if (widget.showStatusFilter && _activeStatusFilter != 'Semua') {
      filteredData = filteredData.where((item) {
        String status = item['status']?.toString() ?? '';
        return _mapStatusFilter(status) == _activeStatusFilter;
      }).toList();
    }

    // Send filtered data back to parent
    widget.onDataFiltered?.call(filteredData);
  }

  // String _buildSearchableText(Map<String, dynamic> item) {
  //   List<String> searchFields = [];
  //
  //   // Common fields
  //   if (item.containsKey('nama')) searchFields.add(item['nama'].toString());
  //   if (item.containsKey('noPolis')) searchFields.add(item['noPolis'].toString());
  //   if (item.containsKey('tipe')) searchFields.add(item['tipe'].toString());
  //   if (item.containsKey('lokasi')) searchFields.add(item['lokasi'].toString());
  //
  //   // Category-specific fields
  //   if (widget.selectedCategory == CategoryType.kendaraan) {
  //     if (item.containsKey('nomorPolisi')) searchFields.add(item['nomorPolisi'].toString());
  //     if (item.containsKey('merkModel')) searchFields.add(item['merkModel'].toString());
  //   } else if (widget.selectedCategory == CategoryType.properti) {
  //     if (item.containsKey('alamat')) searchFields.add(item['alamat'].toString());
  //     if (item.containsKey('jenisProperti')) searchFields.add(item['jenisProperti'].toString());
  //   }
  //
  //   return searchFields.join(' ').toLowerCase();
  // }

  String _buildSearchableText(Map<String, dynamic> item) {
    return item.entries
        .where((e) => e.value != null)
        .map((e) => e.value.toString())
        .join(' ')
        .toLowerCase();
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
        return 'Sedang Diproses';
      case 'expired':
      case 'berakhir':
        return 'Berakhir';
      default:
        return status;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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

  void updateTableData(List<Map<String, dynamic>> newData) {
    setState(() {
      // Optional: kalau kamu ingin menyimpan lokal
      // _internalTableData = newData;
    });
    _applyFilters();
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


  Widget _buildButton(ActionButtonType type) {
    if (!widget.visibleButtons.contains(type)) return const SizedBox.shrink(); // ✅
    final config = _buttonConfig[type]!;
    return _ActionButton(
      imageAsset: config['icon'],
      label: config['label'],
      color: config['color'],
      isMobile: isMobile,
      onPressed: () => _handleButtonAction(type),
    );
  }

  void _handleButtonAction(ActionButtonType type) {
    final currentData = widget.tableData ?? [];
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
      case ActionButtonType.tambahAset:
        _handleAddAsset();
        break;
    }
  }

  void _handleRefresh() {
    debugPrint('🔄 Tombol Refresh ditekan');

    _resetFilters();

    if (widget.onRefresh != null) {
      widget.onRefresh!(
        _searchController.text,
        _mapStatusToId(_activeStatusFilter), // 🔁 status ke ID
      );
    } else {
      debugPrint('⚠️ onRefresh belum di-assign di parent!');
    }
  }


  void _handleDownload(List<Map<String, dynamic>> data) {
    debugPrint('Downloading ${data.length} items');

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
    debugPrint('Sharing ${data.length} items');
    debugPrint('Data to share: ${data.map((e) => e['noPolis']).join(', ')}');
    // Implement share logic here
  }

  void _handleDelete(List<Map<String, dynamic>> data) {
    debugPrint('Deleting ${data.length} items');
    debugPrint('Data to delete: ${data.map((e) => e['noPolis']).join(', ')}');
    // Implement delete logic here
  }

  void _handleAddAsset() {
    debugPrint('Adding new asset for category: ${widget.selectedCategory}');

    if (widget.onAddAsset != null) {
      widget.onAddAsset!();
      return;
    }

    // Default fallback jika tidak ada callback
    final isRingkasan = widget.selectedCategory == CategoryType.ringkasan;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isRingkasan
              ? '✅ Tambah Aset (Ringkasan) dijalankan'
              : '📦 Tambah Aset (Kategori lain) dijalankan',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
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

  Widget _buildButtonsGroup(List<ActionButtonType> types) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map(_buildButton).toList(),
    );
  }

  Widget _buildStatusChipsIfNeeded() {
    if (!shouldShowFilter) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child:
      BlocBuilder<StatusAsetCariBloc, StatusAsetCariState>(
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

  @override
  Widget build(BuildContext context) {
    final tableData = widget.tableData ?? [];
    final filteredData = _getFilteredData();

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
                // Debug info
                if (tableData.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Table data: ${tableData.length} items | Filtered: ${filteredData.length} items | Search: "$_searchText" | Filter: $_activeStatusFilter',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),

                // Main content
                isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildButtonsGroup([
              ActionButtonType.tambahAset,
              ActionButtonType.refresh,
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
            _buildButton(ActionButtonType.hapus),
            if (shouldShowFilter)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child:
                  BlocBuilder<StatusAsetCariBloc, StatusAsetCariState>(
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
      ],
    );
  }

  Widget _buildMobileLayout() {
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
              ActionButtonType.tambahAset,
              ActionButtonType.refresh
            ]),
            _buildButtonsGroup([
              ActionButtonType.unduh,
              ActionButtonType.share
            ]),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: _buildButton(ActionButtonType.hapus),
        ),
      ],
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
  double get _width => widget.isMobile ? double.infinity : 500.0;
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
          label: Text(status),
          selected: isSelected,
          onSelected: (_) => onChanged(status),
          selectedColor: Colors.blue,
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.w500,
          ),
          shape: const StadiumBorder(side: BorderSide(color: Colors.blue)),
          backgroundColor: Colors.transparent,
        );
      }).toList(),
    );
  }
}