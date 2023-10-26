import 'package:flutter/material.dart';

class PresentImage extends StatelessWidget {
  final ImageProvider path;
  final Alignment alignment;
  final BoxFit fit;

  const PresentImage({
    super.key,
    required this.path,
    this.alignment = Alignment.center,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      image: path,
      alignment: alignment,
      fit: fit,
    );
  }
}
