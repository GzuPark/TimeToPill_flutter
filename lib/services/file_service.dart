import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<String> saveImageToLocalDirectory(File image) async {
  final documentDirectory = await getApplicationDocumentsDirectory();
  final dirPath = documentDirectory.path + '/pill/images';
  final filePath = dirPath + '/${DateTime.now().millisecondsSinceEpoch}.png';

  await Directory(dirPath).create(recursive: true);

  final newFile = File(filePath);
  newFile.writeAsBytesSync(image.readAsBytesSync());

  return filePath;
}
