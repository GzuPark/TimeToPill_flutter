import 'dart:io';

import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          pillImage == null ? Container() : Image.file(pillImage!),
          Text(pillName),
        ],
      ),
    );
  }
}
