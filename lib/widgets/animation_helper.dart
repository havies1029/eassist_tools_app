import 'package:flutter/material.dart';

AnimationController createAnimationController({
  required TickerProvider vsync,
  Duration duration = const Duration(seconds: 3),
}) {
  return AnimationController(
    vsync: vsync,
    duration: duration,
  );
}

Animation<double> createScaleAnimation(AnimationController controller) {
  return CurvedAnimation(
    parent: controller,
    curve: Curves.elasticOut,
  );
}

Animation<double> createFadeAnimation(AnimationController controller) {
  return Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ),
  );
}

Animation<double> createProgressAnimation(AnimationController controller) {
  return Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    ),
  );
}
