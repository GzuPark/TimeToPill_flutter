import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_widgets.dart';
import 'package:time_to_pill/main.dart';
import 'package:time_to_pill/models/pill.dart';
import 'package:time_to_pill/pages/bottom_sheet/time_setting_bottom_sheet.dart';
import 'package:time_to_pill/services/add_pill_service.dart';
import 'package:time_to_pill/services/file_service.dart';

import 'components/add_page_widget.dart';

class AddAlarmPage extends StatelessWidget {
  AddAlarmPage({
    Key? key,
    required this.pillImage,
    required this.pillName,
  }) : super(key: key);

  final File? pillImage;
  final String pillName;
  final _service = AddPillService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AddPageBody(
        children: [
          Text(
            '매일 복약 잊지 말아요!',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: largeSpace),
          Expanded(
            child: AnimatedBuilder(
              animation: _service,
              builder: (BuildContext context, _) {
                return ListView(
                  children: alarmWidgets,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomSubmitButton(
        text: '완료',
        onPressed: () async {
          /// Add Notifications
          bool permitNotification = false;

          for (var alarm in _service.alarms) {
            permitNotification = await notification.addNotification(
              pillId: pillRepository.newId,
              alarmTimeStr: alarm,
              title: '$alarm 약 먹을 시간이에요',
              body: '$pillName 복약했다고 알려주세요',
            );
          }

          /// Stop the process if the notification is not permitted
          if (!permitNotification) return showPermissionDenied(context, permission: '알람');

          /// Save the image to local device
          String? imageFilePath;

          if (pillImage != null) {
            imageFilePath = await saveImageToLocalDirectory(pillImage!);
          }

          /// Create new Pill instance with the information
          final pill = Pill(
            id: pillRepository.newId,
            name: pillName,
            imagePath: imageFilePath,
            alarms: _service.alarms.toList(),
          );

          /// Save the Pill instance to the Hive
          pillRepository.addPill(pill);

          /// Pop the pages until the HomePage (root or starting page)
          Navigator.popUntil(context, (route) => route.isFirst);
        },
      ),
    );
  }

  List<Widget> get alarmWidgets {
    final children = <Widget>[];

    /// Add lines for AlarmBox with - icon
    children.addAll(
      _service.alarms.map(
        (alarmTime) => AlarmBox(
          time: alarmTime,
          service: _service,
        ),
      ),
    );

    /// Add last line for AddAlarmButton with + icon
    children.add(
      AddAlarmButton(
        service: _service,
      ),
    );

    return children;
  }
}

/// Create time typed alarm widget with - icon
/// This widget is part of showed alarm list: each line
class AlarmBox extends StatelessWidget {
  const AlarmBox({
    Key? key,
    required this.time,
    required this.service,
  }) : super(key: key);

  final String time;
  final AddPillService service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(CupertinoIcons.minus_circle),
            onPressed: () => service.removeAlarm(time),
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            child: Text(time),
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.subtitle2,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => TimeSettingBottomSheet(initTime: time),
              ).then((setTime) {
                /// Initial value of the setTime is same as initTime
                /// Therefore, this value always has the value and its type is DateTime
                /// Do not need to check about setTime data and its type
                service.setAlarm(prevTime: time, setTime: setTime);
              });
            },
          ),
        ),
      ],
    );
  }
}

/// To add new alarm time widget with + icon
/// It will add present time (a.k.a. Now()) automatically
class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({
    Key? key,
    required this.service,
  }) : super(key: key);

  final AddPillService service;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: addAlarmButtonPadding,
        textStyle: Theme.of(context).textTheme.subtitle1,
      ),
      child: Row(
        children: const [
          Expanded(
            flex: 1,
            child: Icon(CupertinoIcons.plus_circle_fill),
          ),
          Expanded(
            flex: 5,
            child: Center(child: Text("복용 알람 시간 추가")),
          ),
        ],
      ),
      onPressed: service.addNowAlarm,
    );
  }
}
