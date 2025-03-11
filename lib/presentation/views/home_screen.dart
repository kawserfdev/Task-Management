// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:task_management/presentation/widgets/custom_button.dart';
// import '../viewmodels/task_viewmodel.dart';
// import '../widgets/task_card.dart';

// class HomePage extends ConsumerStatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends ConsumerState<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final taskViewModel = ref.watch(taskViewModelProvider);

//     return DefaultTabController(
//       initialIndex: 0,
//       length: 2,
//       child: Scaffold(
//         appBar:  AppBar(
//           title: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 "Good morning Kawser",
//                 style: TextStyle(fontSize: 12, color: Color(0xFF6E7591)),
//               ),
//               Text(
//                 "21 Sept, 2025",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),

//           actions: [
//             GestureDetector(
//               onTap: () {},

//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Image.asset("assets/images/notification.png"),
//               ),
//             ),
//           ],
//           bottom: PreferredSize(preferredSize: Size.fromHeight(0), child: Column(
//             children: [
//               Text(
//               "Summary",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: SummaryCard(
//                     count:
//                         taskViewModel.tasks.where((t) => t.isCompleted).length,
//                     color: Colors.purpleAccent,
//                     text: "Completed tasks",
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCard(
//                     count:
//                         taskViewModel.tasks.where((t) => !t.isCompleted).length,
//                     color: Colors.green,
//                     text: "Assigned tasks",
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Today tasks",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             Container(
//               width: 300,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicator: BoxDecoration(
//                   color: Colors.purple,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.grey,
//                 tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")],
//               ),
//             ),
//             ],
//           )),
//         ),
//         body: Column(
//           //controller: _scrollController,
//           children: [
//             Text(
//               "Summary",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: SummaryCard(
//                     count:
//                         taskViewModel.tasks.where((t) => t.isCompleted).length,
//                     color: Colors.purpleAccent,
//                     text: "Completed tasks",
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: SummaryCard(
//                     count:
//                         taskViewModel.tasks.where((t) => !t.isCompleted).length,
//                     color: Colors.green,
//                     text: "Assigned tasks",
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Today tasks",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//             ),
//             Container(
//               width: 300,
//               height: 40,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: TabBar(
//                 controller: _tabController,
//                 indicator: BoxDecoration(
//                   color: Colors.purple,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.grey,
//                 tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")],
//               ),
//             ),

//             Expanded(
//               child: TabBarView(
//                 controller: _tabController,
//                 children: [
//                   taskViewModel.isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : taskViewModel.tasks.isEmpty
//                       ? SizedBox(
//                         child: ListView.builder(
//                           itemCount: 10,
//                           shrinkWrap: true,
//                           scrollDirection: Axis.vertical,
//                           physics: NeverScrollableScrollPhysics(),

//                           itemBuilder: (context, index) {
//                             return Card(
//                               elevation: 3,
//                               margin: EdgeInsets.symmetric(vertical: 8),
//                               child: Padding(
//                                 padding: EdgeInsets.all(16),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "task.title",
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Text(
//                                       "task.description",
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                     SizedBox(height: 8),
//                                     Align(
//                                       alignment: Alignment.bottomRight,
//                                       child: Chip(
//                                         label: Text(
//                                           "Completed" /*task.isCompleted ? "Completed" : "Pending"*/,
//                                         ),
//                                         backgroundColor:
//                                             Colors
//                                                 .green, // task.isCompleted ? Colors.green : Colors.orange,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                       : ListView.builder(
//                         itemCount: taskViewModel.tasks.length,
//                         itemBuilder: (context, index) {
//                           return TaskCard(task: taskViewModel.tasks[index]);
//                         },
//                       ),
//                   taskViewModel.isLoading
//                       ? Center(child: CircularProgressIndicator())
//                       : taskViewModel.tasks.isEmpty
//                       ? Center(
//                         child: Text(
//                           "No tasks available!",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       )
//                       : ListView.builder(
//                         itemCount: taskViewModel.tasks.length,
//                         itemBuilder: (context, index) {
//                           return TaskCard(task: taskViewModel.tasks[index]);
//                         },
//                       ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_management/presentation/widgets/custom_button.dart';
import '../viewmodels/task_viewmodel.dart';
import '../widgets/task_card.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = ref.watch(taskViewModelProvider);

    return Scaffold(
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
        // bottom: TabBar(
        //   controller: _tabController,
        //   indicatorColor: Colors.purple,
        //   labelColor: Colors.purple,
        //   unselectedLabelColor: Colors.grey,
        //   tabs: [
        //     Tab(text: "All Tasks"),
        //     Tab(text: "Completed"),
        //   ],
        // ),
      ),
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Summary",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
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
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Today’s Tasks",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),

                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: "All Tasks"),
                            Tab(text: "Completed"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildTaskList(taskViewModel, false),
            _buildTaskList(taskViewModel, true),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskList(TaskViewModel taskViewModel, bool showCompleted) {
    final tasks =
        showCompleted
            ? taskViewModel.tasks.where((task) => task.isCompleted ).toList()
            : taskViewModel.tasks;

    if (taskViewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (tasks.isEmpty) {
      return Center(
        child: Text("No tasks available!", style: TextStyle(fontSize: 18)),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }
}
