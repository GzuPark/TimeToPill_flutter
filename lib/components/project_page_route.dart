import 'package:flutter/cupertino.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({
    required this.page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
