import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pill/components/project_constants.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
      ),
      body: Padding(
        padding: pagePadding,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '어떤 약이에요?',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: regularSpace),
              Center(
                child: CircleAvatar(
                  radius: 40.0,
                  child: CupertinoButton(
                    onPressed: () {},
                    child: const Icon(
                      CupertinoIcons.photo_camera_solid,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: largeSpace),
              Text(
                '약 이름',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextFormField(
                controller: _textController,
                maxLength: 20,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: '약 이름 입력',
                  hintStyle: Theme.of(context).textTheme.bodyText2,
                  contentPadding: textFiledContentPadding,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: submitButtonBoxPadding,
        child: SafeArea(
          child: SizedBox(
            height: submitButtonHeight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(textStyle: Theme.of(context).textTheme.subtitle1),
              child: const Text('다음'),
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
