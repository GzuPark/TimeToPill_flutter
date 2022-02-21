import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:time_to_pill/components/project_colors.dart';
import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_widgets.dart';
import 'package:time_to_pill/main.dart';

class TimeSettingBottomSheet extends StatelessWidget {
  const TimeSettingBottomSheet({
    Key? key,
    required this.initTime,
    this.bottomWidget,
    this.submitTitle = '선택',
  }) : super(key: key);

  final String initTime;
  final Widget? bottomWidget;
  final String submitTitle;

  @override
  Widget build(BuildContext context) {
    final initialTimeData = DateFormat('HH:mm').parse(initTime);
    final now = DateTime.now();
    final initDateTime = DateTime(now.year, now.month, now.day, initialTimeData.hour, initialTimeData.minute);
    DateTime setTime = initDateTime;

    return BottomSheetBody(
      children: [
        SizedBox(
          height: timePickerBoxHeight,
          child: CupertinoTheme(
            data: CupertinoThemeData(
              brightness: configRepository.isDark ? Brightness.dark : Brightness.light,
            ),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: initDateTime,
              onDateTimeChanged: (dateTime) => setTime = dateTime,
            ),
          ),
        ),
        const SizedBox(height: smallSpace),
        if (bottomWidget != null) bottomWidget!,
        const SizedBox(width: smallSpace),
        Row(
          children: [
            SelectButton(
              text: '취소',
              isPriority: false,
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: smallSpace),
            SelectButton(
              text: submitTitle,
              isPriority: true,
              onPressed: () => Navigator.pop(context, setTime), // send the setTime value to the BottomSheet
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
          primary: isPriority
              ? null
              : configRepository.isDark
                  ? ProjectColors.primaryLightColor
                  : Colors.white,
          onPrimary: isPriority
              ? null
              : configRepository.isDark
                  ? ProjectColors.primaryDarkColor
                  : ProjectColors.primaryLightColor,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
