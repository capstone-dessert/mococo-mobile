import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AlertModal {
  static void show(BuildContext context, bool isMultiSelect, int selectedItemCount) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: Column(
          children: [
            Text(
              isMultiSelect ? "$selectedItemCount개의 의류를 삭제하시겠습니까?" : "해당 의류를 삭제하시겠습니까?",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CupertinoDialogAction(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        minimumSize: MaterialStateProperty.all<Size>(Size(110, 40)),
                      ),
                      child: const Text(
                        "취소",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CupertinoDialogAction(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xffF6747E)),
                        minimumSize: MaterialStateProperty.all<Size>(Size(110, 40)),
                      ),
                      child: const Text(
                        "삭제",
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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