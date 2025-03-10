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
        body: CustomScrollView(
          //controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                  SliverToBoxAdapter(child: Column(children: [
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
               
                  ],),),
                  SliverPadding(
                    padding: EdgeInsets.only(top: 20),
                    sliver: Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")],
                  ),
                ),
                    ),
                    SliverToBoxAdapter(child: TabBarView(children: [])),
                    
                  SliverList.builder(itemCount: taskViewModel.tasks.length, itemBuilder: (context, index) => TaskCard(taskViewModel.tasks[index]),),
              ],
          
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")],
                  ),
                ),
                TabBarView(
                  controller: _tabController,
                  children: [
                    taskViewModel.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : taskViewModel.tasks.isEmpty
                        ? Center(
                          child: Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "task.title",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "task.description",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Chip(
                                      label: Text(
                                        "Completed" /*task.isCompleted ? "Completed" : "Pending"*/,
                                      ),
                                      backgroundColor:
                                          Colors
                                              .green, // task.isCompleted ? Colors.green : Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        : ListView.builder(
                          itemCount: taskViewModel.tasks.length,
                          itemBuilder: (context, index) {
                            return TaskCard(task: taskViewModel.tasks[index]);
                          },
                        ),
                    Center(
                      child: Text(
                        "Completed Content",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
                // TabBar(tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")]),
          
                // Expanded(
                //   child: TabBarView(
                //     children: [
                //       taskViewModel.isLoading
                //           ? Center(child: CircularProgressIndicator())
                //           : taskViewModel.tasks.isEmpty
                //           ? Center(
                //             child: Card(
                //               elevation: 3,
                //               margin: EdgeInsets.symmetric(vertical: 8),
                //               child: Padding(
                //                 padding: EdgeInsets.all(16),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Text(
                //                       "task.title",
                //                       style: TextStyle(
                //                         fontWeight: FontWeight.bold,
                //                         fontSize: 18,
                //                       ),
                //                     ),
                //                     SizedBox(height: 8),
                //                     Text(
                //                       "task.description",
                //                       style: TextStyle(
                //                         fontSize: 14,
                //                         color: Colors.grey,
                //                       ),
                //                     ),
                //                     SizedBox(height: 8),
                //                     Align(
                //                       alignment: Alignment.bottomRight,
                //                       child: Chip(
                //                         label: Text(
                //                           "Completed" /*task.isCompleted ? "Completed" : "Pending"*/,
                //                         ),
                //                         backgroundColor:
                //                             Colors
                //                                 .green, // task.isCompleted ? Colors.green : Colors.orange,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           )
                //           : ListView.builder(
                //             itemCount: taskViewModel.tasks.length,
                //             itemBuilder: (context, index) {
                //               return TaskCard(task: taskViewModel.tasks[index]);
                //             },
                //           ),
                //       taskViewModel.isLoading
                //           ? Center(child: CircularProgressIndicator())
                //           : taskViewModel.tasks.isEmpty
                //           ? Center(
                //             child: Text(
                //               "No tasks available!",
                //               style: TextStyle(fontSize: 18),
                //             ),
                //           )
                //           : ListView.builder(
                //             itemCount: taskViewModel.tasks.length,
                //             itemBuilder: (context, index) {
                //               return TaskCard(task: taskViewModel.tasks[index]);
                //             },
                //           ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabBarScreen extends ConsumerStatefulWidget {
  const TabBarScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends ConsumerState<TabBarScreen>
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Container(
          width: 300,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          taskViewModel.isLoading
              ? Center(child: CircularProgressIndicator())
              : taskViewModel.tasks.isEmpty
              ? Center(
                child: Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "task.title",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "task.description",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Chip(
                            label: Text(
                              "Completed" /*task.isCompleted ? "Completed" : "Pending"*/,
                            ),
                            backgroundColor:
                                Colors
                                    .green, // task.isCompleted ? Colors.green : Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : ListView.builder(
                itemCount: taskViewModel.tasks.length,
                itemBuilder: (context, index) {
                  return TaskCard(task: taskViewModel.tasks[index]);
                },
              ),
          Center(
            child: Text("Completed Content", style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}

// class TabBarScreen extends StatefulWidget {
//   @override
//   _TabBarScreenState createState() => _TabBarScreenState();
// }

// class _TabBarScreenState extends State<TabBarScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: true,
//         title: Container(
//           width: 300,
//           height: 40,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: TabBar(
//             controller: _tabController,
//             indicator: BoxDecoration(
//               color: Colors.purple,
//               borderRadius: BorderRadius.circular(20),
//             ),
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.grey,
//             tabs: [Tab(text: "All Tasks"), Tab(text: "Completed")],
//           ),
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           Center(
//             child: Text("All Tasks Content", style: TextStyle(fontSize: 20)),
//           ),
//           Center(
//             child: Text("Completed Content", style: TextStyle(fontSize: 20)),
//           ),
//         ],
//       ),
//     );
//   }
// }
