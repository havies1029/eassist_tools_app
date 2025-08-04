import 'package:eassist_tools_app/widgets/section/management_polis_asset/tables/polis_tables/form_table/table_ringkasan.dart';
import 'package:flutter/material.dart';
import 'table_kategori.dart';
import '../../category_type.dart';

class TableMain extends StatelessWidget {
  final BoxConstraints constraints;
  final CategoryType selectedCategory;

  const TableMain({
    super.key,
    required this.constraints,
    required this.selectedCategory,
  });

  bool get isMobile => constraints.maxWidth < 768;
  bool get isTablet => constraints.maxWidth >= 768 && constraints.maxWidth < 992;

  double get horizontalPadding => constraints.maxWidth > 1200
      ? 14
      : constraints.maxWidth > 992
      ? 12
      : isTablet
      ? 10
      : 7;

  double get maxWidth => constraints.maxWidth > 1200
      ? 1200
      : isTablet
      ? constraints.maxWidth * 0.95
      : constraints.maxWidth * 0.9;

  @override
  Widget build(BuildContext context) {
    // debugPrint('Selected Category: $selectedCategory');

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 15),
            child: _buildTableWidget(),
          ),
        ),
      ),
    );
  }

  Widget _buildTableWidget() {
    return KategoriPolisTable(
      key: ValueKey('table_${selectedCategory.name}'),
      constraints: constraints,
      category: selectedCategory,
    );
  }
}