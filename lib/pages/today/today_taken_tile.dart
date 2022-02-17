import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_page_route.dart';
import 'package:time_to_pill/main.dart';
import 'package:time_to_pill/models/pill_alarm.dart';
import 'package:time_to_pill/models/pill_history.dart';
import 'package:time_to_pill/pages/bottom_sheet/time_setting_bottom_sheet.dart';
import 'package:time_to_pill/pages/today/image_detail_page.dart';

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
        PillImageButton(pillAlarm: pillAlarm),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTileBody(context, textStyle),
          ),
        ),
        const MoreButton(),
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
                  alarmTime: pillAlarm.alarmTime,
                  takenTime: DateTime.now(),
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
          alarmTime: pillAlarm.alarmTime,
          takenTime: takenTime,
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
            PillImageButton(pillAlarm: pillAlarm),
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
        const MoreButton(),
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
          alarmTime: pillAlarm.alarmTime,
          takenTime: takenTime,
        ),
      );
    });
  }

  String get takenTimeStr => DateFormat('HH:mm').format(history.takenTime);
}

/// Check the image path is null or not in the CircleAvatar (foregroundImage method)
/// This action occurs to when the save the pill information without any image from the gallery or camera
/// The pill's image is not required in this application, so we allow to save the pill without the image
/// Show fitted size of the original image if the imagePath is not null
/// Otherwise, the Button cannot activate if the imagePath is null
class PillImageButton extends StatelessWidget {
  const PillImageButton({
    Key? key,
    required this.pillAlarm,
  }) : super(key: key);

  final PillAlarm pillAlarm;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: CircleAvatar(
        radius: radiusCircleAvatar,
        foregroundImage: pillAlarm.imagePath == null ? null : FileImage(File(pillAlarm.imagePath!)),
      ),
      onPressed: pillAlarm.imagePath == null
          ? null
          : () => Navigator.push(context, FadePageRoute(page: ImageDetailPage(imagePath: pillAlarm.imagePath!))),
    );
  }
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

class MoreButton extends StatelessWidget {
  const MoreButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: const Icon(CupertinoIcons.ellipsis_vertical),
      onPressed: () {},
    );
  }
}
