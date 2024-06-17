import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/codi_list.dart';
import 'package:mococo_mobile/src/models/codi_preview.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_codi_detail.dart';

class CodiGridView extends StatefulWidget {
  const CodiGridView({
    super.key,
    required this.codiList,
    required this.getCodiList,
    required this.reloadCodiListData
  });

  final CodiList codiList;

  final Function getCodiList;
  final Function reloadCodiListData;

  @override
  State<CodiGridView> createState() => _CodiGridViewState();
}

class _CodiGridViewState extends State<CodiGridView> {

  late CodiList codiList;

  @override
  void initState() {
    super.initState();
    codiList = widget.codiList;
  }

  @override
  void didUpdateWidget(covariant CodiGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    codiList = widget.getCodiList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${codiList.list.length}개',
                style: const TextStyle(color: Color(0xff888888)),
              ),
              const Spacer()
            ],
          ),
          const SizedBox(height: 12),
          GridView.builder(
            itemCount: codiList.list.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (BuildContext context, int index) {
              CodiPreview codiItem = codiList.list[index];
              DateTime date = codiItem.date;
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CodiDetail(codiId: codiItem.id, reloadCodiListData: widget.reloadCodiListData)));
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
                      child: Image.memory(codiItem.image)
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
