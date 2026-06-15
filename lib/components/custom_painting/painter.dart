import 'package:flutter/material.dart';

import '../../infrastructure/theme/app_style.dart';

class CembungPainter extends CustomPainter {
  CembungPainter({this.isPrimary = false});
  final bool isPrimary;

  @override
  void paint(Canvas canvas, Size size) {
    Color colors =
        isPrimary ? AppStyle.progressBarTopBlue : AppStyle.kSecondaryColor;
    final gradient = LinearGradient(
      colors: [colors, colors], // Warna gradient biru
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      )
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0) // Titik awal path
      ..lineTo(0, size.height - 60) // Menggambar garis ke bawah
      ..quadraticBezierTo(
        size.width / 2, // Titik kontrol horizontal
        size.height, // Titik kontrol vertikal
        size.width, // Titik akhir horizontal
        size.height - 60, // Titik akhir vertikal
      )
      ..lineTo(size.width, 0) // Menggambar garis ke atas
      ..close(); // Menutup path

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SingleCembungPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black // Warna latar belakang kontainer
      ..style = PaintingStyle.fill;

    const radius = Radius.circular(20.0); // Radius untuk ujung-ujung

    final path = Path()
      ..moveTo(0, 20) // Titik awal path
      ..lineTo(0, size.height - 60) // Menggambar garis ke bawah
      ..quadraticBezierTo(
        size.width / 2, // Titik kontrol horizontal
        size.height, // Titik kontrol vertikal
        size.width, // Titik akhir horizontal
        size.height - 60, // Titik akhir vertikal
      )
      ..lineTo(size.width, 20) // Menggambar garis ke atas
      ..quadraticBezierTo(
        size.width / 2, // Titik kontrol horizontal
        0, // Titik kontrol vertikal
        0, // Titik akhir horizontal
        20, // Titik akhir vertikal
      )
      ..close(); // Menutup path

    final roundedPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ));

    final clippedPath =
        Path.combine(PathOperation.intersect, path, roundedPath);

    canvas.drawPath(clippedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
