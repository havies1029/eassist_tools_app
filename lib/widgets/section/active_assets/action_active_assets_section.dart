import 'package:eassist_tools_app/widgets/section/active_assets/property/properti_breakdown.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/property/properti_table.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/property/properti_table_header.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/property/properti_table_row.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/search_filter_row.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/summary/asset_table.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/summary/asset_table_row.dart';
import 'package:eassist_tools_app/widgets/section/active_assets/tab_navigation.dart';
import 'package:flutter/material.dart';

import 'filter_dropdown.dart';

class ActionSection extends StatefulWidget {
  final BoxConstraints constraints;

  const ActionSection({super.key, required this.constraints});

  @override
  State<ActionSection> createState() => _ActionSectionState();
}

class _ActionSectionState extends State<ActionSection>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  int _selectedTab = 0;
  final List<String> _tabs = ['Ringkasan', 'Properti', 'Kendaraan'];
  String _searchQuery = '';
  String _selectedFilter = 'Semua Jenis Aset';
  final List<String> _filterOptions = [
    'Semua Jenis Aset',
    'Properti',
    'Kendaraan',
    'Kapal Laut',
    'SDM'
  ];
  bool _showFilterDropdown = false;
  Set<int> _expandedRows = <int>{};

  // Data aset
  final List<Map<String, dynamic>> _assetData = [
    {
      'no': 1,
      'name': 'Properti',
      'icon': Icons.home,
      'iconColor': Colors.orange,
      'jumlahPolis': 5,
      'tsi': 'Rp. 15.000.000.000,00',
      'totalPremi': 'Rp. 50.000.000,00',
    },
    {
      'no': 2,
      'name': 'Kendaraan',
      'icon': Icons.directions_car,
      'iconColor': Colors.blue,
      'jumlahPolis': 2,
      'tsi': 'Rp. 500.000.000,00',
      'totalPremi': 'Rp. 7.500.000,00',
    },
    {
      'no': 3,
      'name': 'Kapal Laut',
      'icon': Icons.directions_boat,
      'iconColor': Colors.teal,
      'jumlahPolis': 1,
      'tsi': 'Rp. 25.000.000.000,00',
      'totalPremi': 'Rp. 120.000.000,00',
    },
    {
      'no': 4,
      'name': 'SDM',
      'icon': Icons.people,
      'iconColor': Colors.purple,
      'jumlahPolis': 1,
      'tsi': '-',
      'totalPremi': '-',
    },
  ];

  // Data properti detail
  final List<Map<String, dynamic>> _propertiData = [
    {
      'no': 1,
      'noSppa': 'SPPA-22-007086',
      'riskLocation': 'Kantor Gedung Sentra Kosambi Blok B5 Nomor 1 Sepatan Timu - Tangerang',
      'occupancy': 'Pabrik Warehousing, tempat kerja kantor yang digunakan sebagai: 1. Tempat sirkulasi pada fasilitas umum, 2. Ruang kerja, Kami mennyetakan setiap polis yang kami terbitkan terjawab dan orang yang dilindungi dijamin: 1. Risiko yang disebabkan dari kerusakan mesin-mesin, alat-alat yang digunakan untuk kelancaran kerja, 2. Kemanan yang berfluktunsi dan dan nama surat yang diperlukan karena terganggunya aturan karena pandangan, 3. Pengamanan atau layanan yang disabut dalam penyebutan, yang manusia-manusia lain yang disauat diperluasan tahuna: 1. Penyampaian akan dikenai biaya oleh semua yang diperlukan dan akan dijamin dalam biayanya untuk menjalankan pencarian yang terjadi untuk penyelamatan sampel surat, 2. Penggunaan ada dikeluarkan mengisi upaya ini adalah difokuskan dan terdapat risiko yang akan menjadi suatu pandangan, 3. Perlengkapa dan kejadian serebel yang bisa, 4. Setiap orang yang menerima kepercayaan pandangan kecil di tempat kejadian, 5. Penjualan ke daerng dan tindalam rugi ini adalah ditempatkan dalam dari berbagai tinggal kuat pernyataan.',
      'interest': 'STOCK',
      'sumInsured': 'IDR 30.000.000.000,00',
      'totalInterest': 'IDR 16.500.000.000,00',
      'cover': 'FLEXAS',
      'rate': '0.1172%',
      'premium': 'IDR 4.893.202,27',
      'totalPremium': 'IDR 6.743.780,82',
      'breakdown': {
        'discount': {'percentage': '15%', 'amount': 'IDR -733.790,45'},
        'policyCost': 'IDR 5.400.000',
        'premiLainnya': 'IDR 1.677.835,56',
        'totalPremiumPar': 'IDR 6.687.248,56'
      }
    },
  ];

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 1024;

  double get maxWidth =>
      widget.constraints.maxWidth > 1300 ? 1200 : widget.constraints.maxWidth * 0.9;

  double get horizontalPadding => isMobile ? 16.0 : 0;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    Future.delayed(const Duration(milliseconds: 100), () {
      _slideController.forward();
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Center(
        child: Container(
          width: maxWidth,
          padding: EdgeInsets.symmetric(
            vertical: 36,
            horizontal: horizontalPadding,
          ),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabNavigationWidget(
                    tabs: _tabs,
                    selectedIndex: _selectedTab,
                    isMobile: isMobile,
                    onTabSelected: (index) {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                  ),
                  const SizedBox(height: 32),
                  Stack(
                    children: [
                      SearchAndFilterWidget(
                        searchQuery: _searchQuery,
                        onSearchChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        onSearchPressed: () {
                          print('Search: $_searchQuery');
                        },
                        selectedFilter: _selectedFilter,
                        onToggleFilter: () {
                          setState(() {
                            _showFilterDropdown = !_showFilterDropdown;
                          });
                        },
                        showFilterDropdown: _showFilterDropdown,
                        isMobile: isMobile,
                      ),
                      FilterDropdownWidget(
                        show: _showFilterDropdown,
                        options: _filterOptions,
                        selectedOption: _selectedFilter,
                        onOptionSelected: (option) {
                          setState(() {
                            _selectedFilter = option;
                            _showFilterDropdown = false;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildAssetActiveTitle(),
                  const SizedBox(height: 20),
                  _selectedTab == 0
                      ? AssetTableWidget(
                    assetData: _assetData,
                    isMobile: isMobile,
                    buildRow: (asset, index) => AssetTableRowWidget(
                      asset: asset,
                      index: index,
                      isMobile: isMobile,
                      mobileRowBuilder: _buildMobileRow,
                      desktopRowBuilder: _buildDesktopRow,
                    ),
                  )
                      : PropertiTableWidget(
                    propertiData: _propertiData,
                    expandedRows: _expandedRows,
                    isMobile: isMobile,
                    buildRow: (properti, index) =>  PropertiTableRowWidget(
                      properti: properti,
                      index: index,
                      isExpanded: _expandedRows.contains(index),
                      isMobile: isMobile,
                      onToggleExpand: () {
                        setState(() {
                          if (_expandedRows.contains(index)) {
                            _expandedRows.remove(index);
                          } else {
                            _expandedRows.add(index);
                          }
                        });
                      },
                    ),
                    buildBreakdown: (properti, index) => PropertiBreakdownWidget(
                      breakdown: properti['breakdown'],
                      isMobile: isMobile,
                    ),
                    tableHeader: PropertiTableHeaderWidget(isMobile: isMobile,),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssetActiveTitle() {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'Aset Aktif',
          style: TextStyle(
            color: Colors.green,
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildMobileRow(Map<String, dynamic> asset) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                '${asset['no']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: asset['iconColor'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      asset['icon'],
                      color: asset['iconColor'],
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      asset['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                '${asset['jumlahPolis']}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TSI: ${asset['tsi']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Premi: ${asset['totalPremi']}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopRow(Map<String, dynamic> asset) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            '${asset['no']}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: asset['iconColor'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  asset['icon'],
                  color: asset['iconColor'],
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                asset['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${asset['jumlahPolis']}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            asset['tsi'],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            asset['totalPremi'],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}