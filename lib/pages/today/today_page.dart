import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_page_route.dart';
import 'package:time_to_pill/main.dart';
import 'package:time_to_pill/models/pill.dart';
import 'package:time_to_pill/models/pill_alarm.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '오늘 복용할 약은?',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(height: regularSpace),
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
        Expanded(
          /// Automatically check to change in the Hive box
          child: ValueListenableBuilder(
            valueListenable: pillRepository.pillBox.listenable(),
            builder: _buildPillListView,
          ),
        ),
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
      ],
    );
  }

  ListView _buildPillListView(BuildContext context, Box<Pill> box, _) {
    final pills = box.values.toList();
    final pillAlarms = <PillAlarm>[];

    /// Each pill has several alarms, in other words that Pill class has more than one alarm time in the list
    /// Therefore, create a new list for ListView: total length = each pill * number of its alarm list
    /// Add to the pillAlarms list as PillAlarm structure
    for (var pill in pills) {
      for (var alarm in pill.alarms) {
        pillAlarms.add(
          PillAlarm(
            key: pill.key, // get the integer using by inheriting the HiveObject class
            id: pill.id,
            name: pill.name,
            imagePath: pill.imagePath,
            alarm: alarm,
          ),
        );
      }
    }

    return ListView.separated(
      padding: pillListTilePadding,
      itemCount: pillAlarms.length,
      itemBuilder: (BuildContext context, int index) => PillListTile(pillAlarm: pillAlarms[index]),
      separatorBuilder: (BuildContext context, _) => const Divider(height: regularSpace),
    );
  }
}

class PillListTile extends StatelessWidget {
  const PillListTile({
    Key? key,
    required this.pillAlarm,
  }) : super(key: key);

  final PillAlarm pillAlarm;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        /// Check the image path is null or not in the CircleAvatar (foregroundImage method)
        /// This action occurs to when the save the pill information without any image from the gallery or camera
        /// The pill's image is not required in this application, so we allow to save the pill without the image
        /// Show fitted size of the original image if the imagePath is not null
        /// Otherwise, the Button cannot activate if the imagePath is null
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: CircleAvatar(
            radius: radiusCircleAvatar,
            foregroundImage: pillAlarm.imagePath == null ? null : FileImage(File(pillAlarm.imagePath!)),
          ),
          onPressed: pillAlarm.imagePath == null
              ? null
              : () => Navigator.push(context, FadePageRoute(page: ImageDetailPage(imagePath: pillAlarm.imagePath!))),
        ),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('🕑 ${pillAlarm.alarm}', style: textStyle),
              const SizedBox(height: tinySpace),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(pillAlarm.name, style: textStyle),
                  TileActionButton(
                    title: '지금',
                    onTap: () {},
                  ),
                  Text('|', style: textStyle),
                  TileActionButton(
                    title: '아까',
                    onTap: () {},
                  ),
                  Text('먹었어요!', style: textStyle),
                ],
              ),
            ],
          ),
        ),
        CupertinoButton(
          child: const Icon(CupertinoIcons.ellipsis_vertical),
          onPressed: () {},
        ),
      ],
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

/// Show magnified Pill's image if the imagePath is not null
class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: Center(
        child: Image.file(
          File(imagePath),
        ),
      ),
    );
  }
}
