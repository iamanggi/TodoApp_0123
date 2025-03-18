import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  bool isChecked = false;

  final _key = GlobalKey<FormState>();
  final TextEditingController _todoappController = TextEditingController();


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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                     
                  ),
                  SizedBox(
                    child: ElevatedButton(onPressed: (){}, style: 
                    ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 54, 25, 185)
                    ),
                    child: const Text("submit",style: TextStyle(color: Colors.white, fontSize: 16),),
                  ))
                ]
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 2),
              const Text('To do List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              
            ],
          ),
        ),
      ),
    );
  }
}
