import 'package:flutter/material.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:intl/intl.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _todoappController = TextEditingController();
  DateTime? selectedDate;

  void _selectDate() {
    BottomPicker.date(
      pickerTitle: Text(
        'Set task date & time',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.blue[900],
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

  List<Map<String, dynamic>> task = [];

  Widget _buildTaskCard(Map<String, dynamic> tasks, int index) {
    return Card(
      color: const Color.fromARGB(255, 224, 222, 222),
      child: ListTile(
        title: Text(
          tasks["title"],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Deadline: ${tasks['deadline']}",
              style: const TextStyle(color: Color.fromARGB(255, 4, 5, 5)),
            ),
            Text(
              tasks["done"] ? "Done" : "Not Done",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color:
                    tasks["done"]
                        ? const Color.fromARGB(255, 28, 145, 31)
                        : Colors.red,
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: tasks["done"],
          onChanged: (bool? value) {
            setState(() {
              task[index]["done"] = value!;
            });
          },
          activeColor: const Color.fromARGB(255, 80, 39, 176),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Todo App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        selectedDate != null
                            ? DateFormat(
                              "dd-MM-yyyy HH:mm",
                            ).format(selectedDate!)
                            : 'Select a date',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _selectDate,
                    icon: Icon(
                      Icons.date_range_rounded,
                      color: const Color.fromARGB(255, 33, 99, 153),
                    ),
                  ),
                ],
              ),
              if (selectedDate == null)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Please select a date",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Form(
                      key: _key,
                      child: TextFormField(
                        controller: _todoappController,
                        decoration: InputDecoration(
                          label: Text('task name'),
                          hintText: 'Enter task',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Task cannot be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 8.0)),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: _submitTasks,
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: task.length,
                  itemBuilder:
                      (context, index) => _buildTaskCard(task[index], index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
