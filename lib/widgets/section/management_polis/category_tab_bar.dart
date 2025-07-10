import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'polis_tables/polis_category_type.dart';

class CategoryTabBar extends StatelessWidget {
  final BoxConstraints constraints;
  final CategoryType selectedCategory;
  final void Function(CategoryType) onCategorySelected;

  const CategoryTabBar({
    super.key,
    required this.constraints,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 95
      : constraints.maxWidth > 992
      ? 64
      : isTablet
      ? 40
      : 24;

  @override
  Widget build(BuildContext context) {
    final Map<CategoryType, (IconData, String)> tabs = {
      CategoryType.ringkasan: (Icons.description_outlined, "Ringkasan"),
      CategoryType.properti: (Icons.inventory_2_outlined, "Properti"),
      CategoryType.kendaraan: (Icons.directions_car_outlined, "Kendaraan"),
      CategoryType.kesehatan: (Icons.favorite_border, "Kesehatan"),
      CategoryType.marineKargo: (Icons.directions_boat_outlined, "Marine Kargo"),
      CategoryType.sdm: (Icons.person_outline, "SDM"),
      CategoryType.lain_lain: (Icons.more_horiz_outlined, "Lainnya"),
    };

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: isMobile ? 10 : 24,
      ),
      child: Center(
        child: Container(
          width: isMobile ? 332.2 : 882,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 5 : 12, vertical: isMobile ? 5 : 12),
          child: ScrollConfiguration(
            behavior: const _DragScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: tabs.entries.map((entry) {
                  final isSelected = selectedCategory == entry.key;
                  final (icon, label) = entry.value;

                  return InkWell(
                    onTap: () => onCategorySelected(entry.key),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: isMobile ? 4 : 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFDDEAD0) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            icon,
                            size: isMobile ? 16.8 : 20,
                            color: isSelected ? const Color(0xFF79AB43) : Colors.black87,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            label,
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