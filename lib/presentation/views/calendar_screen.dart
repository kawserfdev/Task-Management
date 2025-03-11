import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_management/core/utils/app_colors.dart';
import 'package:task_management/presentation/viewmodels/task_viewmodel.dart';
import 'package:task_management/presentation/widgets/task_card.dart';
import 'package:task_management/routes/app_routes.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskViewModel = ref.watch(taskViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("All Tasks"),
        actionsPadding: EdgeInsets.only(right: 20),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.initialRoute,
                arguments: 1,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFFF0EDFD),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                "Create New",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          DatePickerWidget(
            selectedDate: DateTime.now(),
            onDateSelected: (date) {},
          ),

          Expanded(
            child:
                taskViewModel.tasks.isEmpty
                    ? Center(child: Text("No tasks available!"))
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: taskViewModel.tasks.length,
                      itemBuilder: (context, index) {
                        final task = taskViewModel.tasks[index];

                        return TaskCard(task: task);
                      },
                    ),
          ),
        ],
      ),
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
    List<DateTime> dates = List.generate(
      7,
      (index) => today.add(Duration(days: index - 3)),
    );

    return Container(
      height: 96,
      color: Colors.white,
      // padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          DateTime date = dates[index];
          bool isSelected =
              date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: isSelected ? 16 : 23,
              ),
              padding: EdgeInsets.symmetric(horizontal: isSelected ? 22 : 16),
              decoration: BoxDecoration(
                color: !isSelected ? Color(0xFFEBF2FF) : null,
                gradient:
                    isSelected
                        ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF886CED), AppColor.primaryColor],
                        )
                        : null,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(date),

                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: isSelected ? Colors.white : AppColor.primaryColor,
                    ),
                  ),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontSize: isSelected ? 20 : 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColor.primaryColor,
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
