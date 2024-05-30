import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<String>> _events = {};

  List<String> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _addEventDialog() {
    final TextEditingController eventController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('일정 추가'),
        content: TextField(
          controller: eventController,
          decoration: InputDecoration(
            hintText: '일정을 입력하세요',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              // @Todo 캘린더 일정 Api 구현 필요
              if (eventController.text.isEmpty) return;
              setState(() {
                if (_events[_selectedDay] == null) {
                  _events[_selectedDay!] = [];
                }
                _events[_selectedDay]!.add(eventController.text);
              });
              Navigator.pop(context);
            },
            child: Text('저장'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            headerStyle: const HeaderStyle(formatButtonVisible:  false),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          if (_selectedDay != null)
            ..._getEventsForDay(_selectedDay!).map((event) => ListTile(
              title: Text(event),
            )),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () => _addEventDialog(),
            child: Text('일정 추가'),
          ),
        ],
      ),
    );
  }
}
