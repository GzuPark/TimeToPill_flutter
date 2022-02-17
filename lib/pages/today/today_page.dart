import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/main.dart';
import 'package:time_to_pill/models/pill.dart';
import 'package:time_to_pill/models/pill_alarm.dart';
import 'package:time_to_pill/models/pill_history.dart';
import 'package:time_to_pill/pages/today/today_empty_widget.dart';
import 'package:time_to_pill/pages/today/today_taken_tile.dart';

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
        Expanded(
          /// Automatically check to change in the Hive box
          child: ValueListenableBuilder(
            valueListenable: pillRepository.pillBox.listenable(),
            builder: _buildPillListView,
          ),
        ),
      ],
    );
  }

  Widget _buildPillListView(BuildContext context, Box<Pill> box, _) {
    final pills = box.values.toList();
    final pillAlarms = <PillAlarm>[];

    /// Check emptiness
    if (pills.isEmpty) return const TodayEmpty();

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
            alarmTime: alarm,
          ),
        );
      }
    }

    return Column(
      children: [
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
        Expanded(
          child: ListView.separated(
            padding: pillListTilePadding,
            itemCount: pillAlarms.length,
            itemBuilder: (BuildContext context, int index) {
              return _buildListTile(pillAlarms[index]);
            },
            separatorBuilder: (BuildContext context, _) => const Divider(height: regularSpace),
          ),
        ),
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
      ],
    );
  }

  /// Choice the [Before||After]TakenTile style
  /// Return BeforeTakenTile if today's history is empty or do not check to take pills
  ///   List.singleWhere must return any result, so return dummy value if the history do not have appropriate data in the list
  /// Return AfterTakenTile if all conditions match
  Widget _buildListTile(PillAlarm pillAlarm) {
    return ValueListenableBuilder(
      valueListenable: historyRepository.historyBox.listenable(),
      builder: (BuildContext context, Box<PillHistory> historyBox, _) {
        if (historyBox.values.isEmpty) {
          return BeforeTakenTile(pillAlarm: pillAlarm);
        }

        final todayTakenHistory = historyBox.values.singleWhere(
          (history) =>
              history.pillId == pillAlarm.id &&
              history.alarmTime == pillAlarm.alarmTime &&
              isToday(history.takenTime, DateTime.now()),
          orElse: () => PillHistory(
            pillId: -1,
            alarmTime: '',
            takenTime: DateTime.now(),
          ),
        );

        /// Check dummy data
        if (todayTakenHistory.pillId == -1 && todayTakenHistory.alarmTime == '') {
          return BeforeTakenTile(pillAlarm: pillAlarm);
        }

        return AfterTakenTile(
          pillAlarm: pillAlarm,
          history: todayTakenHistory,
        );
      },
    );
  }

  bool isToday(DateTime source, DateTime destination) {
    return source.year == destination.year && source.month == destination.month && source.day == destination.day;
  }
}
