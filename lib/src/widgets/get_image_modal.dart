import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/closet/p_register_clothes.dart';

class GetImageModal {
  static Future<void> show(BuildContext context) async {
    final picker = ImagePicker();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) =>
          CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () async {
                  final pickedImage = await picker.getImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    // Navigator.pop(context); // 모달창 닫기
                    // Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterCloth(imagePath: pickedImage.path)));
                    // Get.to(() => RegisterCloth(imagePath: pickedImage.path));
                    // Get.off(() => RegisterCloth(imagePath: pickedImage.path));
                    // Get.back(); // 모달창 닫기
                    // Get.to(() => RegisterCloth(imagePath: pickedImage.path));
                  }
                },
                child: const Text('갤러리'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  final pickedImage = await picker.getImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    Navigator.pop(context); // 모달창 닫기
                    Get.to(() => RegisterCloth(imagePath: pickedImage.path));
                  }
                },
                child: const Text('카메라'),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }
}