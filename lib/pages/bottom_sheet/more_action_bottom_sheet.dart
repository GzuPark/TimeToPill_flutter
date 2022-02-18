import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_widgets.dart';

class MoreActionBottomSheet extends StatelessWidget {
  const MoreActionBottomSheet({
    Key? key,
    required this.onPressedModify,
    required this.onPressedRemoveOnlyInfo,
    required this.onPressedRemoveAll,
  }) : super(key: key);

  final VoidCallback onPressedModify;
  final VoidCallback onPressedRemoveOnlyInfo;
  final VoidCallback onPressedRemoveAll;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressedModify,
          child: Text(
            '약 정보 수정',
            style: Theme.of(context).textTheme.button!.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        TextButton(
          onPressed: onPressedRemoveOnlyInfo,
          style: TextButton.styleFrom(primary: Colors.red),
          child: const Text('약 정보 삭제'),
        ),
        TextButton(
          onPressed: onPressedRemoveAll,
          style: TextButton.styleFrom(primary: Colors.red),
          child: const Text('약 기록 및 정보 삭제'),
        ),
      ],
    );
  }
}
