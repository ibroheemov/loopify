import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class AppSvg extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;

  const AppSvg({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.contain,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
    );
  }
}
