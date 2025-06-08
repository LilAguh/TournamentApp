import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tournament_app/common/layout/noise_background.dart';

class FramedBackground extends StatelessWidget {
  final Widget child;

  const FramedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0D),
        body: Stack(
          children: [
            SafeArea(
              child: Stack(
                children: [
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 44.0,
                    ), // Reducido de 50.0
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: IntrinsicHeight(child: child),
                    ),
                  ),
                ],
              ),
            ),
            const Positioned.fill(
              child: IgnorePointer(child: NoiseBackground(opacity: 1)),
            ),
          ],
        ),
      ),
    );
  }
}
