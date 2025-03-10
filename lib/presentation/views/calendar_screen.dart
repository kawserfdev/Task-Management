import 'package:flutter/material.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calendar")),
      body: Center(child: Text("Calendar View Coming Soon")),
    );
  }
}




class DatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  DatePickerWidget({required this.selectedDate, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    List<DateTime> dates = List.generate(7, (index) => today.add(Duration(days: index - 3)));

    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        itemBuilder: (context, index) {
          DateTime date = dates[index];
          bool isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purple : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    //DateFormat.E().format(date), // Day (Mon, Tue) 
                    '',
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}