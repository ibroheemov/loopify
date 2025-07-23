import 'package:flutter/material.dart';

class SlideFadePageRoute extends PageRouteBuilder {
  final Widget page;
  final Offset begin;

  SlideFadePageRoute({required this.page, this.begin = const Offset(1, 0)})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end)
                .chain(CurveTween(curve: Curves.easeInOut));

            final fadeTween = Tween<double>(begin: 0.0, end: 1.0);

            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(
                  opacity: animation.drive(fadeTween), child: child),
            );
          },
        );
}
