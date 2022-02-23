import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_widgets.dart';
import 'package:time_to_pill/main.dart';

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
          child: Text(
            '약 정보 삭제',
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: configRepository.isDark ? Colors.redAccent.shade100 : Colors.red,
                ),
          ),
        ),
        TextButton(
          onPressed: onPressedRemoveAll,
          child: Text(
            '약 기록 및 정보 삭제',
            style: Theme.of(context).textTheme.button!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: configRepository.isDark ? Colors.redAccent.shade100 : Colors.red,
                ),
          ),
        ),
      ],
    );
  }
}
