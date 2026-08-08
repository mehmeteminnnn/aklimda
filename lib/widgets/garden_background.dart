import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils/theme.dart';

class GardenBackground extends StatelessWidget {
  final Widget child;
  final bool blurOverlay;

  const GardenBackground({
    super.key,
    required this.child,
    this.blurOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Katman 1: Gökyüzü → çimen gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFCAF0F8),
                Color(0xFFB7E4C7),
                Color(0xFF95D5B2),
                Color(0xFF74C69D),
              ],
              stops: [0.0, 0.35, 0.7, 1.0],
            ),
          ),
        ),
        // Katman 2: Güneş ışığı
        Positioned(
          top: -60,
          right: -40,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.sun.withValues(alpha: 0.45),
                  AppColors.sun.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Katman 3: Bulut / yaprak siluetleri
        Positioned(
          top: 80,
          left: -30,
          child: _LeafBlob(
            size: 160,
            color: AppColors.meadow.withValues(alpha: 0.5),
          ),
        ),
        Positioned(
          bottom: 120,
          right: -20,
          child: _LeafBlob(
            size: 200,
            color: AppColors.leaf.withValues(alpha: 0.25),
          ),
        ),
        Positioned(
          bottom: -40,
          left: 40,
          child: _LeafBlob(
            size: 140,
            color: AppColors.moss.withValues(alpha: 0.2),
          ),
        ),
        // Katman 4: Hafif bulanıklaştırma
        if (blurOverlay)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(color: Colors.transparent),
          ),
        // İçerik
        child,
      ],
    );
  }
}

class _LeafBlob extends StatelessWidget {
  final double size;
  final Color color;

  const _LeafBlob({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
