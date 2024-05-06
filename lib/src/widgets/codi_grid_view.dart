import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/image_data.dart';

List<Map<String, Object>> codiItems = [
  {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 5)},
  {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 4)},
  {"image": "assets/images/topSample.png", "date": DateTime(2024, 5, 3)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 2)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
  {"image": "assets/images/tmp.png", "date": DateTime(2024, 5, 1)},
];

class CodiGridView extends StatefulWidget {
  const CodiGridView({super.key});

  @override
  State<CodiGridView> createState() => _CodiGridViewState();
}

class _CodiGridViewState extends State<CodiGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: codiItems.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        DateTime date = codiItems[index]["date"] as DateTime;
        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: Image.asset(codiItems[index]["image"].toString(),)
            ),
          ],
        );
      },

    );
  }

  // void _navigateToCodiDetail(BuildContext context, int index) {
  //   if (!widget.selectedClothesIndices.contains(index)) {
  //     widget.onClothesDetail(
  //         context, Clothes(index: index, name: 'Cloth $index'));
  //   }
  // }
}
