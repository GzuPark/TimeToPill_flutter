import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_constants.dart';

class HistoryEmpty extends StatelessWidget {
  const HistoryEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text('복약 기록이 없습니다.')),
        const SizedBox(height: smallSpace),
        Text('복용 후 기록해주세요!', style: Theme.of(context).textTheme.subtitle1),
      ],
    );
  }
}
