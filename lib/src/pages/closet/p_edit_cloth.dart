import 'package:flutter/material.dart';
import '../../components/image_data.dart';
import '../../widgets/app_bar.dart';
import '../../cloth.dart';

class EditCloth extends StatelessWidget {
  const EditCloth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TextTitleAppBar(
        title: "상세 정보 수정",
        buttonNum: 3,
        onSaveButtonPressed: _onSaveButtonPressed,
      ),
      body: Stack(
        children: [
          const SizedBox(
            height: 30,
          ),
          // 사진
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset(IconPath.topSample),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _onSaveButtonPressed() {
    print("save");
  }

}
