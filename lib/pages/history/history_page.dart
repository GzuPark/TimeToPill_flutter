import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_widgets.dart';
import 'package:time_to_pill/main.dart';
import 'package:time_to_pill/models/pill.dart';
import 'package:time_to_pill/models/pill_history.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('잘 복용했어요 👏', style: Theme.of(context).textTheme.headline4),
        const SizedBox(height: regularSpace),
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: historyRepository.historyBox.listenable(),
            builder: _buildHistoryListView,
          ),
        ),
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
      ],
    );
  }

  Widget _buildHistoryListView(BuildContext context, Box<PillHistory> historyBox, _) {
    final histories = historyBox.values.toList().reversed.toList();
    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];
        return HistoryTimeTile(history: history);
      },
    );
  }
}

/// Draw the history of taken pills with timeline design
/// Show the taken date & time and pill's image
class HistoryTimeTile extends StatelessWidget {
  const HistoryTimeTile({
    Key? key,
    required this.history,
  }) : super(key: key);

  final PillHistory history;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            DateFormat('yyyy\nMM.dd E', 'ko_KR').format(history.takenTime),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  height: historyDateTextHeight,
                  leadingDistribution: TextLeadingDistribution.even,
                ),
          ),
        ),
        const SizedBox(width: smallSpace),
        Stack(
          alignment: historyPointAlignment,
          children: const [
            SizedBox(
              height: sectionDividerLength,
              child: VerticalDivider(
                width: sectionDividerWidth,
                thickness: sectionDividerThickness,
              ),
            ),
            CircleAvatar(
              radius: tinyRadiusCircleAvatar,
              child: CircleAvatar(
                radius: tinyRadiusCircleAvatar * 0.9,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        Expanded(
          flex: 3,
          child: Row(
            children: [
              const SizedBox(width: regularSpace),
              Visibility(
                visible: pill.imagePath != null,
                child: PillImageButton(imagePath: pill.imagePath),
              ),
              const SizedBox(width: smallSpace),
              Text(
                '${DateFormat('a hh:mm', 'ko_KR').format(history.takenTime)}\n${pill.name}',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      height: historyDateTextHeight,
                      leadingDistribution: TextLeadingDistribution.even,
                    ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Pill get pill => pillRepository.pillBox.values.singleWhere(
        (elem) => elem.id == history.pillId && elem.key == history.pillKey,
        orElse: () => Pill(id: -1, name: history.name, imagePath: null, alarms: []),
      );
}
