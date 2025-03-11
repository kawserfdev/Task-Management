import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task_management/core/utils/app_colors.dart';
import 'package:task_management/presentation/widgets/custom_textfield.dart';
import 'package:task_management/presentation/widgets/summary_card.dart';
import 'package:uuid/uuid.dart';
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

  void _selectDate(BuildContext context, bool isSelectableDate) {
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
              minDate: _selectedStartDate ?? DateTime.now(),
              initialSelectedDate:
                  isSelectableDate ? _selectedStartDate : _selectedEndDate,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  setState(() {
                    if (isSelectableDate) {
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

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      startDateController.text = DateFormat(
        'MMM dd yyy',
      ).format(widget.task!.startDate);
      endDateController.text = DateFormat(
        'MMM dd yyy',
      ).format(widget.task!.endDate);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
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
        appBar: AppBar(
          title: Text(widget.task != null ? "View Task" : "Create new task"),
          actionsPadding: EdgeInsets.only(right: 20),
          actions: [
            if (widget.task != null)
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text("Delete Task"),
                          content: Text(
                            "Are you sure you want to delete this task?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                taskViewModel.deleteTask(widget.task!.id);
                                Navigator.pop(
                                  context,
                                ); // Close the alert dialog
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Task deleted successfully"),
                                  ),
                                );
                                Navigator.pop(context); // Close the task screen
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE1E2),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFieldWidget(
                    controller: titleController,
                    label: "Task Name",
                    hintText: "Enter task name",
                    readOnly: widget.task != null ? true : false,
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
                    maxLength: 45,
                    readOnly: widget.task != null ? true : false,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: AppColor.greyText,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter task description",
                      hintStyle: const TextStyle(color: AppColor.greyText),
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
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    validator:
                        (value) => value?.length == 45 ? "Too long" : null,
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
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: " / $maxLength",
                                  style: TextStyle(
                                    color: AppColor.greyText,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          controller: startDateController,
                          label: "Start Date",
                          readOnly: true,
                          hintText: DateFormat('MMMM dd yyy').format(now),
                          suffixIcon: Icon(
                            Icons.calendar_month_outlined,
                            color: AppColor.primaryColor,
                            size: 16,
                          ),
                          onTap:
                              () =>
                                  widget.task != null
                                      ? null
                                      : _selectDate(context, true),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFieldWidget(
                          controller: endDateController,
                          label: "End Date",
                          readOnly: true,
                          hintText: DateFormat('MMMM dd yyy').format(now),

                          suffixIcon: Icon(
                            size: 16,
                            Icons.calendar_month_outlined,
                            color: AppColor.primaryColor,
                          ),
                          onTap:
                              () =>
                                  widget.task != null
                                      ? null
                                      : _selectDate(context, false),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  if (widget.task == null || !widget.task!.isCompleted)
                    CustomButton(
                      text:
                          widget.task != null ? "Complete" : "Create new tasks",

                      onPressed: () {
                        if (widget.task != null) {
                          TaskModel updatedTask = widget.task!.copyWith(
                            isCompleted: true,
                          );
                          taskViewModel.updateTask(
                            widget.task!.id,
                            updatedTask,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Task marked as completed"),
                            ),
                          );
                          Navigator.pop(context);
                        } else {
                          // Create New Task
                          var uuid = Uuid();
                          taskViewModel.addTask(
                            TaskModel(
                              id: uuid.v4(),
                              title: titleController.text,
                              description: descriptionController.text,
                              startDate: _selectedStartDate ?? DateTime.now(),
                              endDate:
                                  _selectedEndDate ??
                                  DateTime.now().add(Duration(days: 1)),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Task added successfully"),
                            ),
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
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
