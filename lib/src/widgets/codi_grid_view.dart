import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/codi.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_codi_detail.dart';

import '../components/image_data.dart';

class CodiGridView extends StatefulWidget {
  const CodiGridView({super.key});

  // final Function(BuildContext context, int codiIndex) navigateToCodiDetail;

  @override
  State<CodiGridView> createState() => _CodiGridViewState();
}

class _CodiGridViewState extends State<CodiGridView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: Codi.getLengthCodiItems(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        Map codiItem = Codi.getCodiItemByIndex(index);
        DateTime date = codiItem["date"] as DateTime;
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CodiDetail(index: index,)));

          },
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                  child: Image.asset(codiItem["image"].toString(),)
              ),
            ],
          ),
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
