import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pill/components/project_colors.dart';
import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_widgets.dart';

import 'components/add_page_widget.dart';

class AddAlarmPage extends StatelessWidget {
  const AddAlarmPage({
    Key? key,
    required this.pillImage,
    required this.pillName,
  }) : super(key: key);

  final File? pillImage;
  final String pillName;

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
            child: ListView(
              children: const [
                AlarmBox(),
                AlarmBox(),
                AlarmBox(),
                AddAlarmButton(),
              ],
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
}

class AlarmBox extends StatelessWidget {
  const AlarmBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: const Icon(CupertinoIcons.minus),
            onPressed: () {},
          ),
        ),
        Expanded(
          flex: 5,
          child: TextButton(
            child: const Text("18:00"),
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.subtitle2,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheetBody(
                    children: [
                      SizedBox(
                        height: timePickerBoxHeight,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.time,
                          onDateTimeChanged: (dateTime) {},
                        ),
                      ),
                      const SizedBox(height: regularSpace),
                      Row(
                        children: const [
                          SelectButton(
                            text: '취소',
                            isPriority: false,
                          ),
                          SizedBox(width: smallSpace),
                          SelectButton(
                            text: '선택',
                            isPriority: true,
                          ),
                        ],
                      ),
                    ],
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

class AddAlarmButton extends StatelessWidget {
  const AddAlarmButton({Key? key}) : super(key: key);

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
      onPressed: () {},
    );
  }
}

/// Choice between 'Cancel' and 'Confirm' below TimePicker components
class SelectButton extends StatelessWidget {
  const SelectButton({
    Key? key,
    required this.text,
    required this.isPriority,
  }) : super(key: key);

  final String text;
  final bool isPriority;

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
        onPressed: () {},
      ),
    );
  }
}
