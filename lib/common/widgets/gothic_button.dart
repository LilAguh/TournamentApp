import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GothicButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final IconData? icon;

  const GothicButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 48, // Reducido de 56
    this.icon,
  });

  @override
  State<GothicButton> createState() => _GothicButtonState();
}

class _GothicButtonState extends State<GothicButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final Color frameColor =
        _isPressed ? const Color(0xFF9575CD) : const Color(0xFFD6C8B0);

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed != null ? widget.onPressed : null,
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: SvgPicture.asset(
                'assets/borders/frame.svg',
                key: ValueKey<Color>(frameColor),
                width: widget.width,
                height: widget.height,
                colorFilter: ColorFilter.mode(frameColor, BlendMode.srcIn),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              width: widget.width,
              height: widget.height,
              color: const Color.fromARGB(0, 30, 30, 30),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: const Color(0xFFCBB4D4),
                      size: 20,
                    ), // Reducido de 24
                    const SizedBox(width: 6), // Reducido de 8
                  ],
                  Text(
                    widget.text,
                    style: const TextStyle(
                      fontFamily: 'Minion',
                      fontSize: 18, // Reducido de 22
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0, // Reducido de 1.2
                      color: Color(0xFFCBB4D4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
