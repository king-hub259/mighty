import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class DashboardCalenderSection extends StatelessWidget {
  const DashboardCalenderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.week,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeIntervalHeight: 60,
        timeFormat: 'hh:mm a',
      ),
      dataSource: MeetingDataSource(getAppointments()),
    );
  }

  List<Appointment> getAppointments() {
    return [
      Appointment(
        startTime: DateTime(2025, 5, 21, 10, 0),
        endTime: DateTime(2025, 5, 21, 11, 30),
        subject: 'Weekly Test class & Grade 1',
        color: Colors.purple.withValues(alpha: 0.3),
      ),
      Appointment(
        startTime: DateTime(2025, 5, 21, 12, 0),
        endTime: DateTime(2025, 5, 21, 1, 30),
        subject: 'Parents Meeting',
        color: Colors.blue.withValues(alpha: 0.3),
      ),
      Appointment(
        startTime: DateTime(2025, 5, 21, 15, 0),
        endTime: DateTime(2025, 5, 21, 16, 30),
        subject: 'Annual Program Rehearsal',
        color: Colors.green.withValues(alpha: 0.3),
      ),
    ];
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
