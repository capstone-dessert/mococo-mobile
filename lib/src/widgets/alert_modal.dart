import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertModal {
  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text(
          '의류를 삭제하시겠습니까?',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text(
              "취소",
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              color: Color(0xffF6747E),
              child: CupertinoDialogAction(
                child: const Text(
                  "삭제",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
