import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:homesloc/core/colors/colors.dart';

class AppLoader extends StatefulWidget {
  final double size;
  final Color? color;
  const AppLoader({super.key, this.size = 60, this.color});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            width: widget.size.w,
            height: widget.size.w,
            child: CustomPaint(
              painter: _LoaderPainter(
                progress: _controller.value,
                color: widget.color ?? yellow,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final double progress;
  final Color color;

  _LoaderPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Outer faint ring
    final bgPaint = Paint()
      ..color = color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.w;
    canvas.drawCircle(center, radius, bgPaint);

    // Rotating arc
    final arcPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.w;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      progress * 2 * math.pi,
      math.pi / 2,
      false,
      arcPaint,
    );

    // Inner reverse rotating arc
    final innerArcPaint = Paint()
      ..color = blue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.w;

    double innerRadius = radius * 0.6;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: innerRadius),
      -progress * 4 * math.pi,
      math.pi / 3,
      false,
      innerArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _LoaderPainter oldDelegate) => true;
}
