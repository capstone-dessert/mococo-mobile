import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/data/codi.dart';
import 'package:table_calendar/table_calendar.dart';

class CodiCalendarView extends StatefulWidget {
  const CodiCalendarView({super.key});

  @override
  State<CodiCalendarView> createState() => _CodiCalendarViewState();
}

class _CodiCalendarViewState extends State<CodiCalendarView> {

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  static Map<DateTime, List<int>> events = Codi.getCodiEvents();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2000),
      lastDay: DateTime.utc(2100),
      locale: 'ko_KR',
      headerStyle: const HeaderStyle(
        titleCentered: true,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          formatButtonVisible: false,
      ),
      calendarStyle: const CalendarStyle(
        todayTextStyle: TextStyle(
          color: Color(0xffF6747E),
          fontWeight: FontWeight.w500
        ),
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: Color(0xffF6747E)
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xffFEEEEF),
          shape: BoxShape.circle,
        ),
        markerDecoration: BoxDecoration(
          color: Color(0xffF6747E),
          shape: BoxShape.circle,
        ),
        markersMaxCount: 3,
        markerSize: 5,
        markerMargin: EdgeInsets.symmetric(horizontal: 1)
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState((){
          this.selectedDay = selectedDay;
          this.focusedDay = focusedDay;
        });
      },
      selectedDayPredicate: (DateTime day) {
        return isSameDay(selectedDay, day);
      },
      eventLoader: _getEventsForDay,
    );
  }

  List<int> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }
}
