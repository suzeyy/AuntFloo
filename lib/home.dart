import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCalendar(
          view: CalendarView.month,
          monthViewSettings: const MonthViewSettings(showAgenda: true),
          todayHighlightColor: Colors.pinkAccent.withOpacity(1),
          backgroundColor: Colors.pinkAccent.withAlpha(50),
          cellBorderColor: Colors.pinkAccent.withOpacity(0.7),
          selectionDecoration: BoxDecoration(
            color: Colors.pinkAccent.withAlpha(100),
          ),
          headerStyle: CalendarHeaderStyle(
            textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
    );
  }
}
