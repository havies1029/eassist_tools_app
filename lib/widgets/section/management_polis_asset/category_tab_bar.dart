import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/gen_aset_dashboard/asetdashboardcari_bloc.dart';
import '../../../models/combobox/combocoblist_model.dart';
import '../../../repositories/combobox/combocoblist_repository.dart';
import 'category_type.dart';

class CategoryTabBar extends StatefulWidget {
  final BoxConstraints constraints;
  final CategoryType selectedCategory;
  final void Function(CategoryType) onCategorySelected;

  const CategoryTabBar({
    super.key,
    required this.constraints,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  State<CategoryTabBar> createState() => _CategoryTabBarState();
}

class _CategoryTabBarState extends State<CategoryTabBar> {
  late Future<List<ComboCobListModel>> cobFuture;
  bool hasInitialized = false;

  bool get isMobile => widget.constraints.maxWidth < 768;
  bool get isTablet => widget.constraints.maxWidth >= 768 && widget.constraints.maxWidth < 992;

  double get horizontalPadding => widget.constraints.maxWidth > 1200
      ? 95
      : widget.constraints.maxWidth > 992
      ? 64
      : isTablet
      ? 40
      : 24;

  @override
  void initState() {
    super.initState();
    cobFuture = ComboCobListRepository().getComboCobList();
  }

  void _retryFetch() {
    setState(() {
      cobFuture = ComboCobListRepository().getComboCobList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ComboCobListModel>>(
      future: cobFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Gagal memuat kategori COB.",
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _retryFetch,
                  child: const Text("Coba Lagi"),
                ),
              ],
            ),
          );
        }

        final List<ComboCobListModel> cobList = snapshot.data!;
        cobList.sort((a, b) {
          if (a.mCobApp1Id == '10001') return -1;
          if (b.mCobApp1Id == '10001') return 1;
          return 0;
        });

        // ⬇️ Otomatis trigger Ringkasan saat pertama kali loaded
        if (!hasInitialized) {
          final defaultItem = cobList.firstWhere(
                (e) => e.mCobApp1Id == '10001',
            orElse: () => cobList.first,
          );

          final defaultCategory = CategoryTypeExtension.fromCobKode(defaultItem.mCobApp1Id);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onCategorySelected(defaultCategory);
            context.read<AsetDashboardCariBloc>().add(
              RefreshAsetDashboardCariEvent(cobAppId: defaultCategory.cobKode),
            );
          });

          hasInitialized = true;
        }

        return Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: isMobile ? 10 : 24,
          ),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              width: isMobile ? 332.2 : 882,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 5 : 12,
                vertical: isMobile ? 5 : 12,
              ),
              child: ScrollConfiguration(
                behavior: const _DragScrollBehavior(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: cobList.map((item) {
                      final category = CategoryTypeExtension.fromCobKode(item.mCobApp1Id);
                      final isSelected = widget.selectedCategory == category;

                      debugPrint('[DEBUG] Mapping COB "${item.mCobApp1Id}" ("${item.cobNama}") → CategoryType: $category');

                      return InkWell(
                        onTap: () {
                          widget.onCategorySelected(category);
                          debugPrint('[TAB SELECTED] Category: $category, COB Kode: ${category.cobKode}, Nama: ${item.cobNama}');
                          context.read<AsetDashboardCariBloc>().add(
                            RefreshAsetDashboardCariEvent(cobAppId: category.cobKode),
                          );
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 8 : 12,
                            vertical: isMobile ? 4 : 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFDDEAD0) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                getIconForCobKode(item.mCobApp1Id),
                                size: isMobile ? 16.8 : 20,
                                color: isSelected ? const Color(0xFF79AB43) : Colors.black87,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.cobNama,
                                style: TextStyle(
                                  fontFamily: 'Satoshi',
                                  fontSize: isMobile ? 15 : 16,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected ? const Color(0xFF79AB43) : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
class _DragScrollBehavior extends MaterialScrollBehavior {
  const _DragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

IconData getIconForCobKode(String? kode) {
  switch (kode) {
    case '10001':
      return Icons.dashboard_outlined;
    case '10002':
      return Icons.home_work_outlined;
    case '10003':
      return Icons.directions_car_outlined;
    case '10004':
      return Icons.local_shipping_outlined;
    case '10005':
      return Icons.favorite_border;
    case '10006':
      return Icons.people_alt_outlined;
    case '10007':
      return Icons.more_horiz;
    default:
      return Icons.category_outlined;
  }
}

extension CategoryTypeExtension on CategoryType {
  static CategoryType fromCobKode(String? kode) {
    switch (kode) {
      case '10001':
        return CategoryType.ringkasan;
      case '10002':
        return CategoryType.properti;
      case '10003':
        return CategoryType.kendaraan;
      case '10004':
        return CategoryType.marineKargo; // misalnya "Angkutan"
      case '10005':
        return CategoryType.kesehatan;
    // tambahkan jika ada '10006' → sdm, dst.
      default:
        return CategoryType.lain_lain;
    }
  }


  String get cobKode {
    switch (this) {
      case CategoryType.kendaraan:
        return '10003';
      case CategoryType.kesehatan:
        return '10005';
      case CategoryType.properti:
        return '10002';
      case CategoryType.ringkasan:
        return '10001';
      case CategoryType.marineKargo:
        return '10004';
      case CategoryType.sdm:
        return '10006';
      case CategoryType.lain_lain:
        return '10007';
    }
  }
}


