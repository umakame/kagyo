import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<Calendar> {
  late DateTime _focusedDay;
  late CalendarFormat _calendarFormat;
  DateTime? _selectedDay;
  List<String> _selectedEvents = [];

  // Map形式で保持　keyが日付　値が文字列
  final Map<DateTime, List<String>> sampleEvents = {
    DateTime.utc(2023, 2, 20): ['firstEvent', 'secondEvent'],
    DateTime.utc(2023, 2, 5): ['thirdEvent', 'fourthEvent'],
  };

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _selectedDay = DateTime.now();
    _selectedEvents = sampleEvents[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ログ"),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          automaticallyImplyLeading:false,
        ),
        // カレンダーUI実装
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2023, 1, 1),
                lastDay: DateTime.utc(2024, 12, 31),
                focusedDay: _focusedDay,
                eventLoader: (date) {
                  // イベントドット処理
                  return sampleEvents[date] ?? [];
                },
                calendarFormat: _calendarFormat,
                // デフォを月表示に設定
                onFormatChanged: (format) {
                  // 「月」「週」変更
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                // 選択日のアニメーション
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                // 日付が選択されたときの処理
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedEvents = sampleEvents[selectedDay] ?? [];
                  });
                },
              ),
            ),
            // タップした時表示するリスト
            Expanded(
              child: ListView.builder(
                itemCount: _selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = _selectedEvents[index];
                  return Card(
                    child: ListTile(
                      title: Text(event),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
