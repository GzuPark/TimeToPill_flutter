import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_to_pill/components/project_colors.dart';
import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_widgets.dart';
import 'package:time_to_pill/services/add_pill_service.dart';

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
        onPressed: () {},
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
                builder: (context) {
                  return TimePickerBottomSheet(
                    initTime: time,
                    service: service,
                  );
                },
              );
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

class TimePickerBottomSheet extends StatelessWidget {
  const TimePickerBottomSheet({
    Key? key,
    required this.initTime,
    required this.service,
  }) : super(key: key);

  final String initTime;
  final AddPillService service;

  @override
  Widget build(BuildContext context) {
    final _initTime = DateFormat('HH:mm').parse(initTime);
    late DateTime? _setTime;

    return BottomSheetBody(
      children: [
        SizedBox(
          height: timePickerBoxHeight,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: _initTime,
            onDateTimeChanged: (dateTime) => _setTime = dateTime,
          ),
        ),
        const SizedBox(height: regularSpace),
        Row(
          children: [
            SelectButton(
              text: '취소',
              isPriority: false,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: smallSpace),
            SelectButton(
              text: '선택',
              isPriority: true,
              onPressed: () {
                service.setAlarm(
                  prevTime: initTime,
                  setTime: _setTime ?? _initTime,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}

/// Choice between 'Cancel' and 'Confirm' below TimePicker components
class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.text,
    required this.isPriority,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final bool isPriority;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: Text(text),
        style: ElevatedButton.styleFrom(
          textStyle: Theme.of(context).textTheme.subtitle1,
          primary: isPriority ? null : Colors.white,
          onPrimary: isPriority ? null : ProjectColors.primaryColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
