import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/presentation/widgets/custom_button.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/task_card.dart';
import '../widgets/bottom_nav.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = ref.watch(taskViewModelProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good morning Kawser",
                style: TextStyle(fontSize: 12, color: Color(0xFF6E7591)),
              ),
              Text(
                "21 Sept, 2025",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          actions: [
            GestureDetector(
              onTap: () {},

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset("assets/images/notification.png"),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Summary",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SummaryCard(
                      count:
                          taskViewModel.tasks
                              .where((t) => t.isCompleted)
                              .length,
                      color: Colors.purpleAccent,
                      text: "Completed tasks",
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: SummaryCard(
                      count:
                          taskViewModel.tasks
                              .where((t) => !t.isCompleted)
                              .length,
                      color: Colors.green,
                      text: "Assigned tasks",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Today tasks",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              TabBar(tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")]),

              Expanded(
                child: TabBarView(
                  children: [
                    taskViewModel.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : taskViewModel.tasks.isEmpty
                        ? Center(
                          child: Text(
                            "No tasks available!",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                        : ListView.builder(
                          itemCount: taskViewModel.tasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(task: taskViewModel.tasks[index]);
                          },
                        ),
                    taskViewModel.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : taskViewModel.tasks.isEmpty
                        ? Center(
                          child: Text(
                            "No tasks available!",
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                        : ListView.builder(
                          itemCount: taskViewModel.tasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(task: taskViewModel.tasks[index]);
                          },
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
