import 'package:flutter/material.dart';
import '../components/image_data.dart';

class Date extends StatefulWidget {
  const Date({super.key, required this.isCenter, required this.isEditable, this.date});

  final bool isCenter;
  final bool isEditable;
  final DateTime? date;

  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    if (widget.date != null) {
      date = widget.date!;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isCenter)
          const SizedBox(width: 25)
        else
          const SizedBox(width: 6),

        if (widget.isEditable)
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
        else
          Text(
            "${date.year.toString()}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}",
            style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}