import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  bool isChecked = false;

  final _key = GlobalKey<FormState>();
  final TextEditingController _todoappController = TextEditingController();
  DateTime? selectedDate;

  void _selectDate() {
    BottomPicker.date(
      pickerTitle: Text(
        'Set date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue,
        ),
      ),
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
        });
      },
      initialDateTime: DateTime.now(),
      maxDateTime: DateTime(2100),
      minDateTime: DateTime(2000),
      pickerTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
    ).show(context);
  }

  void _submitTasks() {
    if (_key.currentState!.validate() && selectedDate != null) {
      setState(() {
        task.add({
          "title": _todoappController.text,
          "deadline": DateFormat("dd-MM-yyyy HH:mm").format(selectedDate!),
          "done": false,
        });
        _todoappController.clear();
        selectedDate = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Task has been successfully added!"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  List<Map<String, dynamic>> tasks = [];

  Widget _buildTaskCard(Map<String, dynamic> task, int index) {
    return Card(
      color: const Color.fromARGB(255, 201, 201, 201),
      child: ListTile(
        title: Text(task["title"], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deadline: ${task['deadline']}", style: const TextStyle(color: Color.fromARGB(255, 47, 55, 59))),
            Text(
              task["done"] ? "Done" : "Not Done",
              style: TextStyle(color: task["done"] ? const Color.fromARGB(255, 21, 185, 27) : Colors.red),
            ),
          ],
        ),
        trailing: Checkbox(
          value: task["done"],
          onChanged: (bool? value) {
            setState(() {
              tasks[index]["done"] = value!;
            });
          },
          activeColor: Colors.purple,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Todo App'))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Task Date:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Select a date'),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.date_range_rounded,
                      color: const Color.fromARGB(255, 33, 99, 153),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('task name'),
                          hintText: 'Enter task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 8.0)),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 54, 25, 185),
                      ),
                      child: const Text(
                        "submit",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 2),
              const Text(
                'To do List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
