import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_page_route.dart';
import 'package:time_to_pill/main.dart';
import 'package:time_to_pill/models/pill_alarm.dart';
import 'package:time_to_pill/models/pill_history.dart';
import 'package:time_to_pill/pages/add/add_pill_page.dart';
import 'package:time_to_pill/pages/bottom_sheet/more_action_bottom_sheet.dart';
import 'package:time_to_pill/pages/bottom_sheet/time_setting_bottom_sheet.dart';
import 'package:time_to_pill/components/project_widgets.dart';

class BeforeTakenTile extends StatelessWidget {
  const BeforeTakenTile({
    Key? key,
    required this.pillAlarm,
  }) : super(key: key);

  final PillAlarm pillAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        PillImageButton(imagePath: pillAlarm.imagePath),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(context, textStyle),
          ),
        ),
        MoreButton(pillAlarm: pillAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(BuildContext context, TextStyle? textStyle) {
    return [
      Text('🕑 ${pillAlarm.alarmTime}', style: textStyle),
      const SizedBox(height: tinySpace),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('${pillAlarm.name},', style: textStyle),
          TileActionButton(
            title: '지금',
            onTap: () {
              historyRepository.addHistory(
                PillHistory(
                  pillId: pillAlarm.id,
                  pillKey: pillAlarm.key,
                  alarmTime: pillAlarm.alarmTime,
                  takenTime: DateTime.now(),
                  name: pillAlarm.name,
                  imagePath: pillAlarm.imagePath,
                ),
              );
            },
          ),
          Text('|', style: textStyle),
          TileActionButton(
            title: '아까',
            onTap: () => _onTapTakenPast(context),
          ),
          Text('먹었어요!', style: textStyle),
        ],
      ),
    ];
  }

  void _onTapTakenPast(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TimeSettingBottomSheet(initTime: pillAlarm.alarmTime),
    ).then((takenTime) {
      /// Initial value of the takenTime is same as initTime
      /// Therefore, this value always has the value and its type is DateTime
      /// But, it will return null if you choose the '취소' button
      if (takenTime == null) return;

      historyRepository.addHistory(
        PillHistory(
          pillId: pillAlarm.id,
          pillKey: pillAlarm.key,
          alarmTime: pillAlarm.alarmTime,
          takenTime: takenTime,
          name: pillAlarm.name,
          imagePath: pillAlarm.imagePath,
        ),
      );
    });
  }
}

class AfterTakenTile extends StatelessWidget {
  const AfterTakenTile({
    Key? key,
    required this.pillAlarm,
    required this.history,
  }) : super(key: key);

  final PillAlarm pillAlarm;
  final PillHistory history;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        Stack(
          children: [
            PillImageButton(imagePath: pillAlarm.imagePath),
            CircleAvatar(
              radius: radiusCircleAvatar,
              backgroundColor: Colors.green.withOpacity(0.6),
              child: const Icon(
                CupertinoIcons.check_mark,
                size: radiusCircleAvatar * 0.9,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(context, textStyle),
          ),
        ),
        MoreButton(pillAlarm: pillAlarm),
      ],
    );
  }

  List<Widget> _buildTileBody(BuildContext context, TextStyle? textStyle) {
    return [
      Text.rich(
        TextSpan(
          text: '✅ ${pillAlarm.alarmTime} → ',
          style: textStyle,
          children: [
            TextSpan(
              text: takenTimeStr,
              style: textStyle?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      const SizedBox(height: tinySpace),
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('${pillAlarm.name},', style: textStyle),
          TileActionButton(
            title: DateFormat('HH시 mm분에').format(history.takenTime),
            onTap: () => _onTapChange(context),
          ),
          Text('먹었어요!', style: textStyle),
        ],
      ),
    ];
  }

  void _onTapChange(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TimeSettingBottomSheet(
        initTime: takenTimeStr,
        bottomWidget: TextButton(
          child: const Text('복약 시간을 지우고 싶어요.'),
          onPressed: () {
            historyRepository.deleteHistory(history.key);
            Navigator.pop(context);
          },
        ),
        submitTitle: '수정',
      ),
    ).then((takenTime) {
      /// Initial value of the takenTime is same as initTime
      /// Therefore, this value always has the value and its type is DateTime
      /// But, it will return null if you choose the '취소' button
      if (takenTime == null) return;

      historyRepository.updateHistory(
        key: history.key,
        pill: PillHistory(
          pillId: pillAlarm.id,
          pillKey: pillAlarm.key,
          alarmTime: pillAlarm.alarmTime,
          takenTime: takenTime,
          name: pillAlarm.name,
          imagePath: pillAlarm.imagePath,
        ),
      );
    });
  }

  String get takenTimeStr => DateFormat('HH:mm').format(history.takenTime);
}

class TileActionButton extends StatelessWidget {
  const TileActionButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle = Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w500);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: textFiledContentPadding,
        child: Text(title, style: buttonTextStyle),
      ),
    );
  }
}

/// Pop bottom sheet for more actions: modify, remove only information, remove information & history
/// Modify
///   - Route to the AddPillPage with pill's information
/// Remove only information
///   - Remove Pill data in the Pill's hive box
///   - Remove list views in the TodayPage
///   - Possible to see in the HistoryPage forever
/// Remove all (information & history)
///   - Remove Pill & PillHistory data in the hive boxes
///   - Cannot see in the all page view
class MoreButton extends StatelessWidget {
  const MoreButton({
    Key? key,
    required this.pillAlarm,
  }) : super(key: key);

  final PillAlarm pillAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.ellipsis_vertical),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) => MoreActionBottomSheet(
                  onPressedModify: () {
                    Navigator.push(
                      context,
                      FadePageRoute(page: AddPillPage(updatePillId: pillAlarm.id)),
                    ).then((_) => Navigator.maybePop(context));
                  },
                  onPressedRemoveOnlyInfo: () {
                    /// Remove notifications
                    notification.deleteMultipleAlarms(alarmIds);

                    /// Remove Pill in the Hive box
                    pillRepository.deletePill(pillAlarm.key);

                    Navigator.pop(context);
                  },
                  onPressedRemoveAll: () {
                    /// Remove notifications
                    notification.deleteMultipleAlarms(alarmIds);

                    /// Remove PillHistory in the Hive box
                    historyRepository.deleteAllHistories(keys);

                    /// Remove Pill in the Hive box
                    pillRepository.deletePill(pillAlarm.key);

                    Navigator.pop(context);
                  },
                ));
      },
    );
  }

  List<String> get alarmIds {
    final pill = pillRepository.pillBox.values.singleWhere((element) => element.id == pillAlarm.id);
    final alarmIds = pill.alarms.map((alarmStr) => notification.alarmId(pillAlarm.id, alarmStr)).toList();
    return alarmIds;
  }

  Iterable<int> get keys {
    final histories = historyRepository.historyBox.values
        .where((history) => history.pillId == pillAlarm.id && history.pillKey == pillAlarm.key);
    final keys = histories.map((history) => history.key as int);
    return keys;
  }
}
