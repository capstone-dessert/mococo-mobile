import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/widgets/app_bar.dart';
import 'package:mococo_mobile/src/widgets/codi_calendar_view.dart';
import 'package:mococo_mobile/src/widgets/codi_grid_view.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_add_codi_record.dart';

class CodiRecord extends StatefulWidget {
  const CodiRecord({super.key});

  @override
  State<CodiRecord> createState() => _CodiRecordState();
}

class _CodiRecordState extends State<CodiRecord> {

  final List<bool> _selectedView = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LeftLogoAppBar(onAddButtonPressed: _onAddButtonPressed,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                _viewToggleButton(),
              ],
            ),
            const SizedBox(height: 8),
            if (_selectedView[0])
              const Expanded(child: CodiGridView()),
            if (_selectedView[1])
              const Expanded(child: CodiCalendarView()),
          ],
        ),
      )
    );
  }

  void _onAddButtonPressed(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCodiRecord()));
  }

  Widget _viewToggleButton() {
    return Stack(
      children: [
        Container(
          width: 102,
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
            selectedColor: const Color(0xffFFF0F0),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            label: const Text("전체"),
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
          left: 48,
          top: -5,
          child: ChoiceChip(
            showCheckmark: false,
            selectedColor: const Color(0xffFFF0F0),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            label: const Text("달력"),
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
    );
  }
}
