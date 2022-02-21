import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_page_route.dart';
import 'package:time_to_pill/pages/detail/image_detail_page.dart';

class BottomSheetBody extends StatelessWidget {
  const BottomSheetBody({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: pagePadding,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

void showPermissionDenied(
  BuildContext context, {
  required String permission,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$permission 권한이 없습니다.',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const TextButton(
            child: Text('설정창으로 이동'),
            onPressed: openAppSettings,
          ),
        ],
      ),
    ),
  );
}

/// Check the image path is null or not in the CircleAvatar (foregroundImage method)
/// This action occurs to when the save the pill information without any image from the gallery or camera
/// The pill's image is not required in this application, so we allow to save the pill without the image
/// Show fitted size of the original image if the imagePath is not null
/// Otherwise, the Button cannot activate if the imagePath is null
class PillImageButton extends StatelessWidget {
  const PillImageButton({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: CircleAvatar(
        radius: radiusCircleAvatar,
        foregroundImage: imagePath == null ? null : FileImage(File(imagePath!)),
        child: imagePath == null
            ? const Icon(
                Icons.medical_services_outlined,
                size: radiusCircleAvatar * 0.8,
                color: Colors.grey,
              )
            : null,
      ),
      onPressed: imagePath == null
          ? null
          : () => Navigator.push(context, FadePageRoute(page: ImageDetailPage(imagePath: imagePath!))),
    );
  }
}
