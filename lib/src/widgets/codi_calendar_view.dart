import 'package:flutter/material.dart';
import 'package:mococo_mobile/src/models/codi.dart';
import 'package:mococo_mobile/src/pages/codi_record/p_codi_detail.dart';
import 'package:mococo_mobile/src/jsons.dart';
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
  static Map<DateTime, List<int>> events = getCodiEvents();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
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
              defaultTextStyle: TextStyle(fontSize: 16),
              holidayTextStyle: TextStyle(fontSize: 16),
              weekendTextStyle: TextStyle(fontSize: 16),
              todayTextStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0xffF6747E),
                  fontWeight: FontWeight.w500
              ),
              todayDecoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(
                  fontSize: 16,
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
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: _getEventsForDay(selectedDay).length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                Codi codiItem = Codi.fromJson(getCodiJsonById(_getEventsForDay(selectedDay)[index])!);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CodiDetail(id: codiItem.id,)));
                  },
                  child: Column(
                    children: [
                      Expanded(
                          child: Image.asset(codiItem.image, )
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<int> _getEventsForDay(DateTime day) {
    return events[DateTime(day.year, day.month, day.day)] ?? [];
  }
}
