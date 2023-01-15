import 'package:flutter/material.dart';

class ChairPainter extends StatelessWidget {
  final double width;
  final double height;
  final Color colour;
  final bool isPadding;
  const ChairPainter({
    Key? key,
    this.width = 12,
    this.height = 12,
    required this.colour,
    this.isPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isPadding ? EdgeInsets.only(left: 12) : EdgeInsets.only(left: 0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: CustomPaint(
        painter: ChairPaint(
          color: colour,
        ),
      ),
    );
  }
}

class ChairPaint extends CustomPainter {
  final Color color;
  const ChairPaint({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final paintx = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final a = Offset(size.width * 1 / 6, size.height * 1 / 4);
    final b = Offset(size.width * 5 / 6, size.height * 3 / 4);
    final rect = Rect.fromPoints(a, b);
    const radius = Radius.circular(2);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), paintx);

    final c = Offset(size.width * 1.8 / 6, size.height * 3.5 / 4);
    final d = Offset(size.width * 4.3 / 6, size.height * 3.5 / 4);
    canvas.drawLine(c, d, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
