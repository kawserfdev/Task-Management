import 'package:flutter/material.dart';
import 'package:task_management/presentation/views/add_task_screen.dart';
import 'package:task_management/presentation/views/calendar_screen.dart';
import 'package:task_management/presentation/views/home_screen.dart';

class DashBoardActivity extends StatefulWidget {
  @override
  _DashBoardActivityState createState() => _DashBoardActivityState();
}

class _DashBoardActivityState extends State<DashBoardActivity> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: CreateBottombar(context),
    );
  }

  final _widgetOptions = [HomePage(), AddTaskScreen(), CalendarScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Container CreateBottombar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        child: BottomNavigationBar(
          
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 0
                      ? Image.asset("assets/images/home-active.png")
                      : Image.asset("assets/images/home.png"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 1
                      ? Image.asset("assets/images/clipboard-active.png")
                      : Image.asset("assets/images/clipboard.png"),
              label: "",
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 2
                      ? Image.asset("assets/images/calendar-active.png")
                      : Image.asset("assets/images/calendar.png"),
              label: "",
            ),
          ],
          
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
