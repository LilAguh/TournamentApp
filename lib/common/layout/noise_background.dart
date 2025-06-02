import 'package:flutter/material.dart';

class NoiseBackground extends StatelessWidget {
  final double opacity;

  const NoiseBackground({super.key, this.opacity = 0.1});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Image.asset('assets/images/noise.png', fit: BoxFit.cover),
    );
  }
}
