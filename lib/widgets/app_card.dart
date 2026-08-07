import 'package:betterloop/theme/spacing.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius = true,
    this.onTap,
    this.boxShadow = true,
    this.disabled = false,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final bool boxShadow;
  final bool borderRadius;
  final bool disabled;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
          margin: margin,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            boxShadow: !boxShadow
                ? null
                : [
                    BoxShadow(
                      color: const Color.fromRGBO(23, 42, 5, 0.059).withValues(
                          alpha:
                              0.02), // #0F172A08 = 3% opacity = 0x08, but Flutter uses AARRGGBB so it's 0x0D for ~5% approximation
                      offset: const Offset(0, 4), // x: 0, y: 4
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: const Color.fromRGBO(23, 42, 8, 0.059)
                          .withValues(alpha: 0.03), // #0F172A14 = 8% opacity
                      offset: const Offset(0, 12), // x: 0, y: 12
                      blurRadius: 16,
                      spreadRadius: 4,
                    ),
                  ],
            color: color ?? colorScheme.surface,
            borderRadius:
                borderRadius ? BorderRadius.all(Radius.circular(24)) : null,
          ),
          // child: child,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              onTap: onTap,
              child: Padding(
                padding: padding ?? EdgeInsets.all(AppSpacing.mdLg),
                child: child,
              ),
            ),
          )),
    );
  }
}
