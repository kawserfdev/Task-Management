import 'package:flutter/material.dart';
import 'package:task_management/presentation/views/add_task_screen.dart';
import 'package:task_management/presentation/views/calendar_screen.dart';
import 'package:task_management/presentation/views/home_screen.dart';

class DashBoardActivity extends StatefulWidget {
  final int initialIndex;
  const DashBoardActivity({super.key, this.initialIndex = 0});
  @override
  // ignore: library_private_types_in_public_api
  _DashBoardActivityState createState() => _DashBoardActivityState();
}

class _DashBoardActivityState extends State<DashBoardActivity> {
  late int _selectedIndex;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  List<String> navIconActive = [
    "assets/images/home-active.png",
    "assets/images/clipboard-active.png",
    "assets/images/calendar-active.png",
  ];
  List<String> navIcon = [
    "assets/images/home.png",
    "assets/images/clipboard.png",
    "assets/images/calendar.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(child: _widgetOptions.elementAt(_selectedIndex)),
          Align(alignment: Alignment.bottomCenter, child: _navBar()),
        ],
      ),
    );
  }

  final _widgetOptions = [HomePage(), AddTaskScreen(), CalendarScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _navBar() {
    return Container(
      height: 68,
      margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFECECEC),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navIcon.length, (index) {
          bool isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () => _onItemTapped(index),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFFF0F2F8) : null,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Image.asset(
                isSelected ? navIconActive[index] : navIcon[index],
              ),
            ),
          );
        }),
      ),
    );
  }
}
