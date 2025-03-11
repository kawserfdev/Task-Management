import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task_management/core/utils/app_colors.dart';
import 'package:task_management/presentation/widgets/custom_textfield.dart';
import 'package:task_management/presentation/widgets/summary_card.dart';
import '../viewmodels/task_viewmodel.dart';
import '../../data/models/task_model.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  final TaskModel? task;
  const AddTaskScreen({super.key, this.task});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  void _selectDate(BuildContext context, bool isStartDate) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Date"),
          content: SizedBox(
            height: 300,
            width: 300,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  setState(() {
                    if (isStartDate) {
                      _selectedStartDate = args.value;
                      startDateController.text = DateFormat(
                        'MMM dd, yyyy',
                      ).format(_selectedStartDate!);
                    } else {
                      _selectedEndDate = args.value;
                      endDateController.text = DateFormat(
                        'MMM dd, yyyy',
                      ).format(_selectedEndDate!);
                    }
                  });
                  Navigator.pop(context);
                }
              },
            ),
          ),
        );
      },
    );
  }

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskViewModel = ref.read(taskViewModelProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Create new task")),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFieldWidget(
                  controller: titleController,
                  label: "Task Name",
                  hintText: "Enter task name",
                ),
                SizedBox(height: 12),

                Text(
                  "Task Description",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 5,
                  maxLength: 100,
                  decoration: InputDecoration(
                    hintText: "Enter task description",
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusColor: Colors.orange,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFDCE1EF)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFDCE1EF)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Color(0xFFDCE1EF)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  buildCounter: (
                    context, {
                    required currentLength,
                    required maxLength,
                    required isFocused,
                  }) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: RichText(
                          text: TextSpan(
                            text: "$currentLength",
                            style: TextStyle(color: Colors.deepPurpleAccent),
                            children: [
                              TextSpan(
                                text: " / $maxLength",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        controller: startDateController,
                        label: "Start Date",
                        readOnly: true,
                        hintText: DateFormat('MMM dd yyy').format(now),
                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColor.primaryColor,
                        ),
                        onTap: () => _selectDate(context, true),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: TextFieldWidget(
                        controller: endDateController,
                        label: "Start Date",
                        readOnly: true,
                        hintText: DateFormat('MMM dd yyy').format(now),

                        suffixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: AppColor.primaryColor,
                        ),
                        onTap: () => _selectDate(context, false),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                CustomButton(
                  text: "Create new tasks",
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        _selectedStartDate == null ||
                        _selectedEndDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill in all fields"),
                        ),
                      );
                      return;
                    }
                    TaskModel newTask = TaskModel(
                      title: titleController.text,
                      description: descriptionController.text,
                      startDate: _selectedStartDate!,
                      endDate: _selectedEndDate!,
                    );
                    print("New Task ${newTask.title}");
                    taskViewModel.addTask(newTask);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Task added successfully")),
                    );
                    FocusScope.of(context).unfocus();
                    titleController.clear();
                    descriptionController.clear();
                    startDateController.clear();
                    endDateController.clear();
                    setState(() {
                      _selectedStartDate = null;
                      _selectedEndDate = null;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
