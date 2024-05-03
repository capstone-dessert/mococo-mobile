import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AlertModal {
  static void show(BuildContext context, bool isMultiSelect, int selectedItemCount) {
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
          child: const Text(
            isMultiSelect ? "$selectedItemCount개의 의류를 삭제하시겠습니까?" : "해당 의류를 삭제하시겠습니까?",
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
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xffF6747E),
                    minimumSize: (const Size(110, 40)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    "삭제",
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