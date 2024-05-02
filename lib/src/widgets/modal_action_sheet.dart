import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ActionSheet {
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
                  // 갤러리에서 이미지 선택
                  final pickedImage = await picker.getImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    // 이미지가 선택되었을 때의 처리
                    print('갤러리에서 이미지를 선택했습니다: ${pickedImage.path}');
                  }
                  Navigator.pop(context);
                },
                child: const Text('갤러리'),
              ),
              CupertinoActionSheetAction(
                onPressed: () async {
                  // 카메라에서 이미지 촬영
                  final pickedImage = await picker.getImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    // 이미지가 촬영되었을 때의 처리
                    print('카메라에서 이미지를 촬영했습니다: ${pickedImage.path}');
                  }
                  Navigator.pop(context);
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
