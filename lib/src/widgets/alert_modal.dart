import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// round 버튼 (구분선 X)
class AlertModal {
  static void show(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text(
          "의류를 삭제하시겠습니까?",
          style: TextStyle(
            fontSize: 17,
          ),
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


// full
// class AlertModal {
//   static void show(BuildContext context) {
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         content: const Text(
//           '의류를 삭제하시겠습니까?',
//           style: TextStyle(
//             fontSize: 17,
//           ),
//         ),
//         actions: <Widget>[
//           CupertinoDialogAction(
//             child: const Text(
//               "취소",
//               style: TextStyle(
//                 fontSize: 17,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           SizedBox(
//             width: double.infinity,
//             child: Container(
//               color: Theme.of(context).primaryColor,
//               child: CupertinoDialogAction(
//                 child: const Text(
//                   "삭제",
//                   style: TextStyle(
//                     fontSize: 17,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
