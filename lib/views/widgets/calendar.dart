import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  late CalendarController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return 
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(),
                outsideDaysVisible: false,
                  todayColor: Colors.blue,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Helper.whiteColor)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonVisible: false
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events, e) {
                print(date.toUtc());
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(80.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Helper.whiteColor),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(80.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Helper.whiteColor),
                    )),
                outsideWeekendDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //     color: Theme.of(context).primaryColor,
                    //     borderRadius: BorderRadius.circular(80.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.grey),
                    )),
              ),
              calendarController: _controller,
            )
          ],
        ),
      );
  }
}
