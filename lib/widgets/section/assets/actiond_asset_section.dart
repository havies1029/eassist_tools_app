import 'package:flutter/material.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ActionSection({super.key, required this.constraints});

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _tableController;
  late AnimationController _itemController;

  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideInAnimation;
  late Animation<double> _scaleAnimation;

  String _activeTab = 'Summary';
  String _searchQuery = '';

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  double get maxWidth =>
      widget.constraints.maxWidth > 1300 ? 1200 : widget.constraints.maxWidth * 0.9;
  double get contentPadding => 0;

  final List<String> _tabs = ['Summary', 'Properti', 'Kendaraan', 'Kapal Laut', 'Lainnya'];

  final List<Map<String, dynamic>> _assetData = [
    {
      'no': 1,
      'icon': Icons.business,
      'name': 'Office Building',
      'category': 'Properti',
      'address': 'Jl. Jendral Sudirman No. 21, Jakarta',
      'value': 'Rp 5 Miliar',
      'expiry': 'Berlaku s.d. 31 Des 2025',
      'status': 'Aktif',
      'color': Colors.blue,
    },
    {
      'no': 2,
      'icon': Icons.directions_car,
      'name': 'Mobil Sedan',
      'category': 'Kendaraan',
      'address': 'Jl. Melati No. 10, Bandung',
      'value': 'Rp 200 Juta',
      'expiry': 'Berlaku s.d. 15 Apr 2026',
      'status': 'Aktif',
      'color': Colors.green,
    },
    {
      'no': 3,
      'icon': Icons.directions_boat,
      'name': 'Kapal Kargo',
      'category': 'Kapal Laut',
      'address': 'Pelabuhan Tanjung Perak, Surabaya',
      'value': 'Rp 2,5 Miliar',
      'expiry': 'Berlaku s.d. 8 Jan 2026',
      'status': 'Aktif',
      'color': Colors.teal,
    },
    {
      'no': 4,
      'icon': Icons.warehouse,
      'name': 'Warehouse',
      'category': 'Properti',
      'address': 'Jl. Raya Merdeka No. 123, Medan',
      'value': 'Rp 3 Miliar',
      'expiry': 'Berlaku s.d. 22 Agu 2024',
      'status': 'Aktif',
      'color': Colors.orange,
    },
    {
      'no': 5,
      'icon': Icons.build,
      'name': 'Excavator',
      'category': 'Lainnya',
      'address': 'Kawasan Industri Cikarang, Bekasi',
      'value': 'Rp 700 Juta',
      'expiry': 'Berlaku s.d. 2 Mar 2024',
      'status': 'Aktif',
      'color': Colors.amber,
    },
    {
      'no': 6,
      'icon': Icons.directions_car,
      'name': 'Mobil Sedan',
      'category': 'Kendaraan',
      'address': 'Jl. Kenanga No. 7, Malang',
      'value': 'Rp 175 Juta',
      'expiry': 'Berlaku s.d. 4 Okt 2023',
      'status': 'Aktif',
      'color': Colors.green,
    },
    {
      'no': 7,
      'icon': Icons.home,
      'name': 'Residential Properti',
      'category': 'Properti',
      'address': 'Jl. Mahogany No. 22, Yogyakarta',
      'value': 'Rp 1,4 Miliar',
      'expiry': 'Berlaku s.d. 18 Sep 2023',
      'status': 'Aktif',
      'color': Colors.blue,
    },
    {
      'no': 8,
      'icon': Icons.local_shipping,
      'name': 'Truk',
      'category': 'Kendaraan',
      'address': 'Jl. Surya No. 230, Tangerang',
      'value': 'Rp 250 Juta',
      'expiry': 'Berlaku s.d. 5 Jul 2023',
      'status': 'Aktif',
      'color': Colors.purple,
    },
    {
      'no': 9,
      'icon': Icons.directions_boat,
      'name': 'Kapal Wisata',
      'category': 'Kapal Laut',
      'address': 'Pelabuhan Benoa, Bali',
      'value': 'Rp 1 Miliar',
      'expiry': 'Berlaku s.d. 18 Jun 2023',
      'status': 'Aktif',
      'color': Colors.teal,
    },
    {
      'no': 10,
      'icon': Icons.motorcycle,
      'name': 'Motor Listrik',
      'category': 'Kendaraan',
      'address': 'Jl. Diponegoro No. 450, Bandung',
      'value': 'Rp 25 Juta',
      'expiry': 'Berlaku s.d. 15 Jan 2024',
      'status': 'Aktif',
      'color': Colors.indigo,
    },
  ];

  List<Map<String, dynamic>> get _filteredAssets {
    if (_searchQuery.isEmpty) return _assetData;
    return _assetData.where((asset) {
      return asset['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          asset['category'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          asset['address'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _tableController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _itemController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic),
    ));

    _slideInAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _tableController,
      curve: Curves.elasticOut,
    ));

    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _mainController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _tableController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _itemController.forward();
  }

  @override
  void dispose() {
    _mainController.dispose();
    _tableController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _mainController,
      builder: (context, child) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          padding: EdgeInsets.only(
            bottom: isMobile ? 20.0 : 30.0,
          ),
          child: FadeTransition(
            opacity: _fadeInAnimation,
            child: SlideTransition(
              position: _slideInAnimation,
              child: Center(
                child: Container(
                  width: maxWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: contentPadding),
                    child: Column(
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 24),
                        _buildAssetTable(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      child: Column(
        children: [
          _buildTabBar(),
          _buildHeaderContent(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((tab) {
            final isActive = _activeTab == tab;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _activeTab = tab;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isActive ? const Color(0xFF10B981) : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  color: isActive ? const Color(0xFF10B981).withOpacity(0.05) : Colors.transparent,
                ),
                child: AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: isActive ? const Color(0xFF10B981) : const Color(0xFF6B7280),
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(tab),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Padding(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF111827),
                ),
                child: const Text('Asset Aktif'),
              ),
              if (!isMobile) _buildAddButton(),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildSearchField()),
              if (isMobile) ...[
                const SizedBox(width: 12),
                _buildAddButton(),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD1D5DB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
        decoration: const InputDecoration(
          hintText: 'Cari asset...',
          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
          prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: 1.0,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add, size: 18),
        label: Text(isMobile ? '' : 'Tambah Asset'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981),
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: const Color(0xFF10B981).withOpacity(0.3),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 20,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildAssetTable() {
    return AnimatedBuilder(
      animation: _tableController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _tableController.value)),
            child: Opacity(
              opacity: _tableController.value,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    if (isMobile) _buildMobileTable() else _buildDesktopTable(),
                    if (_filteredAssets.isEmpty) _buildEmptyState(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDesktopTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        // width: widget.constraints.maxWidth,
        width: widget.constraints.maxWidth > 1200 ? null : 1200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
            headingRowHeight: 60,
            dataRowHeight: 76,
            columnSpacing: 24,
            horizontalMargin: 24,
            showCheckboxColumn: false,
            columns: const [
              DataColumn(
                label: Text(
                  'No',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Jenis Aset',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Kategori Aset',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Alamat',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Nilai TSI',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Masa Berlaku',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ],
            rows: _filteredAssets.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> asset = entry.value;

              return DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return const Color(0xFFF8FAFC);
                    }
                    return null;
                  },
                ),
                cells: [
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 300 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B7280).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  '${asset['no']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 400 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-30 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: _buildAssetNameCell(asset),
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 500 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: _buildCategoryChip(asset['category']),
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 600 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: SizedBox(
                              width: 220,
                              child: Text(
                                asset['address'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 700 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: Text(
                              asset['value'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF059669),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 800 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(-20 * (1 - value), 0),
                          child: Opacity(
                            opacity: value,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: const Color(0xFF6B7280),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    asset['expiry'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6B7280),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(
                    TweenAnimationBuilder<double>(
                      duration: Duration(milliseconds: 900 + (index * 50)),
                      tween: Tween(begin: 0.0, end: 1.0),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Opacity(
                            opacity: value,
                            child: _buildStatusChip(asset['status']),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileTable() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _filteredAssets.length,
      itemBuilder: (context, index) {
        final asset = _filteredAssets[index];
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 600 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 30 * (1 - value)),
              child: Transform.scale(
                scale: 0.8 + (0.2 * value),
                child: Opacity(
                  opacity: value,
                  child: _buildMobileAssetCard(asset),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMobileAssetCard(Map<String, dynamic> asset) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: asset['color'].withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  asset['icon'],
                  color: asset['color'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _buildCategoryChip(asset['category']),
                        const SizedBox(width: 8),
                        _buildStatusChip(asset['status']),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Color(0xFF6B7280)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        asset['address'],
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      asset['value'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFF059669),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14, color: Color(0xFF6B7280)),
                    const SizedBox(width: 4),
                    Text(
                      asset['expiry'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssetNameCell(Map<String, dynamic> asset) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: asset['color'].withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            asset['icon'],
            color: asset['color'],
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            asset['name'],
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF111827),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String category) {
    Color chipColor;
    switch (category) {
      case 'Properti':
        chipColor = const Color(0xFF3B82F6);
        break;
      case 'Kendaraan':
        chipColor = const Color(0xFF8B5CF6);
        break;
      case 'Kapal Laut':
        chipColor = const Color(0xFF06B6D4);
        break;
      case 'Lainnya':
        chipColor = const Color(0xFFF59E0B);
        break;
      default:
        chipColor = const Color(0xFF6B7280);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: chipColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: chipColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            category,
            style: TextStyle(
              color: chipColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            status,
            style: const TextStyle(
              color: Color(0xFF10B981),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildActionButton(Icons.visibility, const Color(0xFF3B82F6)),
        const SizedBox(width: 4),
        _buildActionButton(Icons.edit, const Color(0xFF10B981)),
        const SizedBox(width: 4),
        _buildActionButton(Icons.delete, const Color(0xFFEF4444)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 32,
      height: 32,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Icon(
              icon,
              size: 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 64),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_off,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Tidak ada asset ditemukan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Coba ubah kata kunci pencarian Anda',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset Pencarian'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}