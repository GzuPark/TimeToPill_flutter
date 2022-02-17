import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:time_to_pill/components/project_constants.dart';

class TodayPage extends StatelessWidget {
  TodayPage({Key? key}) : super(key: key);

  final list = [
    '약',
    '약 이름',
    '약을먹자약을먹자약을먹자약을먹자약을먹자',
  ];

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
          child: ListView.separated(
            padding: pillListTilePadding,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return PillListTile(
                name: list[index],
                time: '08:00',
                imagePath: '',
              );
            },
            separatorBuilder: (context, _) {
              return const Divider(height: regularSpace);
            },
          ),
        ),
        const Divider(height: sectionDividerHeight, thickness: sectionDividerThickness),
      ],
    );
  }
}

class PillListTile extends StatelessWidget {
  const PillListTile({
    Key? key,
    required this.name,
    required this.time,
    required this.imagePath,
  }) : super(key: key);

  final String name;
  final String time;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText2;

    return Row(
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: const CircleAvatar(
            radius: radiusCircleAvatar,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: smallSpace),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: textStyle),
              const SizedBox(height: tinySpace),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(name, style: textStyle),
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
