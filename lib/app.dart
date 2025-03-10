import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:task_management/presentation/views/add_task_screen.dart';
import 'package:task_management/presentation/views/calendar_screen.dart';
import 'package:task_management/presentation/views/home_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // Default selected index
  DateTime _selectedDate = DateTime.now();

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar( 
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        index: _selectedIndex,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: _selectedIndex == 0 ? Colors.purple : Colors.grey),
          Icon(Icons.list_alt, size: 30, color: _selectedIndex == 1 ? Colors.purple : Colors.grey),
          Icon(Icons.calendar_today, size: 30, color: _selectedIndex == 2 ? Colors.purple : Colors.grey),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: [
          HomePage(),
          AddTaskScreen(),
          CalendarScreen(),
        ][_selectedIndex],
      
      //  Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     SizedBox(height: 50),
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Text(
      //         "Select a Date",
      //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       ),
      //     ),
      //     // DatePickerWidget(
      //     //   selectedDate: _selectedDate,
      //     //   onDateSelected: _onDateSelected,
      //     // ),
      //   ],
      // ),
    );
  }
}