import 'package:flutter/material.dart';
import '../components/image_data.dart';

class EditableDate extends StatefulWidget {
  const EditableDate({super.key, required this.isCenter});

  final bool isCenter;

  @override
  State<EditableDate> createState() => _EditableDateState();
}

class _EditableDateState extends State<EditableDate> {
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isCenter)
          const SizedBox(width: 25),
        if (widget.isCenter == false)
          const SizedBox(width: 6),
        TextButton(
          onPressed: () async {
            final selectedDate = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100),);
            if (selectedDate != null) {
              setState(() {date = selectedDate;});
            }
          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            children: [
              Text(
                "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
              ),
              const SizedBox(width: 3,),
              SizedBox(width: 22, child: Image.asset(IconPath.editCondition,),)
            ],
          )
        )
      ],
    );
  }
}