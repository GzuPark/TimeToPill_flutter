import 'package:flutter/material.dart';
import 'package:time_to_pill/components/project_constants.dart';

/// Main purpose of this Widget that apply same padding & alignment etc.
class AddPageBody extends StatelessWidget {
  const AddPageBody({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      // This gesture to hide the keyboard if click the Column area without TextFormField
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}

/// Common used clickable button located in the bottom
/// Clickable action, which is `onPressed` is required
/// Visible text is also required
class BottomSubmitButton extends StatelessWidget {
  const BottomSubmitButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: submitButtonBoxPadding,
      child: SafeArea(
        child: SizedBox(
          height: submitButtonHeight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(textStyle: Theme.of(context).textTheme.subtitle1),
            child: Text(text),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
