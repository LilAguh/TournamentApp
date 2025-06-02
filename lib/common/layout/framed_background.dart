import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tournament_app/common/layout/noise_background.dart';

class FramedBackground extends StatelessWidget {
  final Widget child;

  const FramedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          // Ruido detrás del SafeArea (cubre TODO el viewport)

          // Todo lo demás dentro del SafeArea
          SafeArea(
            child: Stack(
              children: [
                // Marco SVG dentro del área segura
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SvgPicture.asset(
                      'assets/borders/ornamental-frame-2.svg',
                      fit: BoxFit.fill,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFD6C8B0),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                // Contenido con scroll
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: IntrinsicHeight(child: child),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const Positioned.fill(child: NoiseBackground(opacity: 1)),
          const Positioned.fill(
            child: IgnorePointer(child: NoiseBackground(opacity: 1)),
          ),
        ],
      ),
    );
  }
}
