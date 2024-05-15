import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/models/codi_list.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_codi_detail.dart';
import 'package:mococo_mobile/src/jsons.dart';

class CodiGridView extends StatefulWidget {
  const CodiGridView({super.key});

  // final Function(BuildContext context, int codiIndex) navigateToCodiDetail;

  @override
  State<CodiGridView> createState() => _CodiGridViewState();
}

class _CodiGridViewState extends State<CodiGridView> {
  @override
  Widget build(BuildContext context) {
    CodiList codiList = CodiList.fromJson(codiJson);
    return GridView.builder(
      itemCount: codiList.list!.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (BuildContext context, int index) {
        Codi codiItem = codiList.list![index];
        DateTime date = codiItem.date;
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CodiDetail(id: index,)));
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
                  child: Image.asset(codiItem.image)
              ),
            ],
          ),
        );
      },
    );
  }
}
