import 'package:flutter/material.dart';
import 'package:time_to_pill/components/project_constants.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}
