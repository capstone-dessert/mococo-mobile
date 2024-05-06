import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/closet/p_register_clothes.dart';

class GetImageModal {
  static Future<void> show(BuildContext context) async {
    final picker = ImagePicker();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              final pickedImage = await picker.getImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterCloth(imagePath: pickedImage.path)));
              }
            },
            child: const Text('갤러리'),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              final pickedImage = await picker.getImage(source: ImageSource.camera);
              if (pickedImage != null) {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterCloth(imagePath: pickedImage.path)));
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

class AlertModal {
  static void show(BuildContext context, {
    required String message,
    String cancelText = '취소',
    String confirmText = '확인',
    Function? onCancel,
    Function? onConfirm,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog (
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        contentPadding: const EdgeInsets.only(top: 40, bottom: 30),
        actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            message,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (onCancel != null) onCancel();
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xffCACACA),),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    cancelText,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (onConfirm != null) onConfirm();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xffF6747E),
                    minimumSize: const Size(110, 40),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(confirmText,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
