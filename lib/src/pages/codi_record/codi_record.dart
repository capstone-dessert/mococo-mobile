import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:postgres/postgres.dart';

class CodiRecord extends StatefulWidget {
  const CodiRecord({super.key});

  @override
  State<CodiRecord> createState() => _CodiRecordState();
}

class _CodiRecordState extends State<CodiRecord> {

  List<bool> _selectedView = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeftLogoAppBar(onAddButtonPressed: _onAddButtonPressed,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
             Row(
               children: [
                 const Spacer(),
                 Stack(
                  children: [
                    Container(
                      width: 112,
                      height: 38,
                      decoration: BoxDecoration(
                          color: const Color(0xffF9F9F9),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all( color: const Color(0xffCACACA) )
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: -5,
                      child: ChoiceChip(
                        showCheckmark: false,
                        backgroundColor: Colors.transparent,
                        selectedColor: const Color(0xffFFF0F0),
                        label: Text("전체"),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: _selectedView[0]
                              ? const Color(0xffF6747E)
                              : Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: _selectedView[0]
                                ? const Color(0xffF6747E)
                                : Colors.transparent,
                          ),
                        ),
                        selected: _selectedView[0],
                        onSelected: (selected) {
                          setState(() {
                            _selectedView[0] = true;
                            _selectedView[1] = false;
                          });
                        },
                      ),
                    ),
                    Positioned(
                      left: 52,
                      top: -5,
                      child: ChoiceChip(
                        showCheckmark: false,
                        // backgroundColor: Colors.transparent,
                        selectedColor: const Color(0xffFFF0F0),
                        label: Text("달력"),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: _selectedView[1]
                              ? const Color(0xffF6747E)
                              : Colors.black,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: _selectedView[1]
                                ? const Color(0xffF6747E)
                                : Colors.transparent,
                          ),
                        ),
                        selected: _selectedView[1],
                        onSelected: (selected) {
                          setState(() {
                            _selectedView[0] = false;
                            _selectedView[1] = true;
                          });
                        },
                      ),
                    )
                  ],
                             ),
               ],
             ),
          ],
        ),
      )
    );
  }

  void _onAddButtonPressed(BuildContext context) {

  }
}
