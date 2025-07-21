import 'package:flutter/material.dart';
import '../../category_type.dart';
// import 'form_table/table_mv.dart';
// import 'form_table/table_properti.dart';
// import 'form_table/table_kesehatan.dart';
// import 'form_table/table_ringkasan.dart';
// import 'form_table/table_angkutan.dart';

class KategoriPolisTable extends StatelessWidget {
  final BoxConstraints constraints;
  final CategoryType category;

  const KategoriPolisTable({
    super.key,
    required this.constraints,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    switch (category) {
      // case CategoryType.kendaraan:
      //   return TableMv(constraints: constraints);
      // case CategoryType.properti:
      //   return TableProperti(constraints: constraints);
    // case CategoryType.kesehatan:
    //   return TableKesehatan(constraints: constraints);
    // case CategoryType.angkutan:
    //   return TableAngkutan(constraints: constraints);
    // case CategoryType.ringkasan:
    //   return TableRingkasan(constraints: constraints);
      default:
        return const Center(child: Text('Kategori belum tersedia'));
    }
  }
}
