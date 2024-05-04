import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/closet/p_closet.dart';


class AlertModal {
  static void show(BuildContext context, String message, bool isDelete) {
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
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xffCACACA),),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  // ButtonStyle(
                  //   backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  //   minimumSize: MaterialStateProperty.all<Size>(Size(110, 40)),
                  // ),
                  child: const Text(
                    "취소",
                    style: TextStyle(
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
                    Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => Closet(),
                        ),
                      );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xffF6747E),
                    minimumSize: (const Size(110, 40)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    isDelete ? "삭제" : "확인", // 의류 삭제, 의류 등록 취소 구분
                    style: TextStyle(
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