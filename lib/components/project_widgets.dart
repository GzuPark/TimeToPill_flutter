import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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

void showPermissionDenied(
  BuildContext context, {
  required String permission,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$permission 권한이 없습니다.',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const TextButton(
            child: Text('설정창으로 이동'),
            onPressed: openAppSettings,
          ),
        ],
      ),
    ),
  );
}
