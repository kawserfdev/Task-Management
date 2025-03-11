import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_management/core/utils/app_colors.dart';
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
              "Good morning Kawser!",
              style: TextStyle(
                fontSize: 12,
                color: AppColor.greyText,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              DateFormat('dd MMM, yyyy').format(DateTime.now()),
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
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      .where((t) => !t.isCompleted)
                                      .length,
                              color: AppColor.primaryColor,
                              text: "Assigned tasks",
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: SummaryCard(
                              count:
                                  taskViewModel.tasks
                                      .where((t) => t.isCompleted)
                                      .length,
                              color: Color(0xFF009F76),
                              text: "Completed tasks",
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Today’s Tasks",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(42),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            dividerColor: Colors.transparent,
                            indicator: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(40),
                            ),

                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 4,
                            ),

                            labelColor: Colors.white,
                            unselectedLabelColor: AppColor.greyText,
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
            ? taskViewModel.tasks.where((task) => task.isCompleted).toList()
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
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }
}
