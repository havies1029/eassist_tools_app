
import 'package:flutter/material.dart';
import 'article_detail_page.dart';
import 'article_list_page.dart';

class ActionSection2 extends StatelessWidget {
  final BoxConstraints constraints;

  const ActionSection2({super.key, required this.constraints});

  @override
  Widget build(BuildContext context) {
    final double constraintWidth = constraints.maxWidth;
    final bool isMobile = constraintWidth < 768;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40.0 : 60.0,
        horizontal: isMobile ? 16.0 : 20.0,
      ),
      child: ArticleDetailPage(constraints: constraints,),
    );
  }
}
