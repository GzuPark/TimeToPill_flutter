import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_page_route.dart';
import 'package:time_to_pill/components/project_widgets.dart';
import 'package:time_to_pill/pages/add/add_alarm_page.dart';

import 'components/add_page_widget.dart';

class AddPillPage extends StatefulWidget {
  const AddPillPage({Key? key}) : super(key: key);

  @override
  State<AddPillPage> createState() => _AddPillPageState();
}

class _AddPillPageState extends State<AddPillPage> {
  // Control to input the pill's name
  final TextEditingController _pillNameController = TextEditingController();
  File? _pillImage;

  @override
  void dispose() {
    _pillNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: SingleChildScrollView(
        child: AddPageBody(
          children: [
            Text(
              '어떤 약이에요?',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: regularSpace),
            Center(
              child: PillImageButton(
                changedImageFile: (File? value) => _pillImage = value,
              ),
            ),
            const SizedBox(height: largeSpace),
            Text(
              '약 이름',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            TextFormField(
              controller: _pillNameController,
              onChanged: (_) => setState(() {}),
              maxLength: 20,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                hintText: '복용할 약 이름을 입력해주세요.',
                hintStyle: Theme.of(context).textTheme.bodyText2,
                contentPadding: textFiledContentPadding,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomSubmitButton(
        onPressed: _pillNameController.text.isEmpty ? null : _routeAddAlarmPage,
        text: '다음',
      ),
    );
  }

  void _routeAddAlarmPage() {
    Navigator.push(
      context,
      FadePageRoute(
        page: AddAlarmPage(
          pillImage: _pillImage,
          pillName: _pillNameController.text,
        ),
      ),
    );
  }
}

/// This widget from the CircleAvatar which located in the center of the HomePage
class PillImageButton extends StatefulWidget {
  const PillImageButton({
    Key? key,
    required this.changedImageFile,
  }) : super(key: key);

  /// Connect a variable with the upper layer state
  final ValueChanged<File?> changedImageFile;

  @override
  State<PillImageButton> createState() => _PillImageButtonState();
}

class _PillImageButtonState extends State<PillImageButton> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40.0,
      child: CupertinoButton(
        onPressed: _buildShowModalBottomSheet,
        padding: _pickedImage == null ? null : EdgeInsets.zero,
        child: _pickedImage == null
            ? const Icon(
                CupertinoIcons.photo_camera_solid,
                size: 30.0,
                color: Colors.white,
              )
            : CircleAvatar(
                radius: 40.0,
                foregroundImage: FileImage(_pickedImage!),
              ),
      ),
    );
  }

  /// You can select 2 choices
  /// 1. Take a shot with the camera
  /// 2. Read a shot from the gallery
  void _buildShowModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PickImageBottomSheet(
          onPressedCamera: () => _onPressed(ImageSource.camera),
          onPressedGallery: () => _onPressed(ImageSource.gallery),
        );
      },
    );
  }

  /// Using image_picker package to call the image source from the camera or image gallery
  void _onPressed(ImageSource source) {
    ImagePicker().pickImage(source: source).then((xFile) {
      if (xFile != null) {
        setState(() {
          _pickedImage = File(xFile.path);
          widget.changedImageFile(_pickedImage);
        });
      }
      Navigator.maybePop(context);
    });
  }
}

class PickImageBottomSheet extends StatelessWidget {
  const PickImageBottomSheet({
    Key? key,
    required this.onPressedCamera,
    required this.onPressedGallery,
  }) : super(key: key);

  final VoidCallback onPressedCamera;
  final VoidCallback onPressedGallery;

  @override
  Widget build(BuildContext context) {
    return BottomSheetBody(
      children: [
        TextButton(
          onPressed: onPressedCamera,
          child: const Text('카메라로 촬영'),
        ),
        TextButton(
          onPressed: onPressedGallery,
          child: const Text('앨범에서 가져오기'),
        ),
      ],
    );
  }
}
