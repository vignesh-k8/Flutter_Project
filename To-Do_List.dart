import 'package:flutter/material.dart';

void main() {
  runApp(const StylishTodoApp());
}

class StylishTodoApp extends StatelessWidget {
  const StylishTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stylish To-Do List with Time',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16.0),
        ),
        useMaterial3: true,
      ),
      home: const TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // 1. Storage now holds a Map with 'task' and 'time' keys
  final List<Map<String, String>> _todoItems = [];

  final TextEditingController _taskController = TextEditingController();
  // 2. New controller for time input
  final TextEditingController _timeController = TextEditingController(); 

  void _addTask() {
    setState(() {
      final task = _taskController.text.trim();
      final time = _timeController.text.trim(); // Get the time value

      if (task.isNotEmpty) {
        // Add both task and time to the map
        _todoItems.add({'task': task, 'time': time.isEmpty ? 'No Time' : time});
        _taskController.clear();
        _timeController.clear(); // Clear the time field
      }
    });
  }

  void _removeTask(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Tasks with Time',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        elevation: 10,
      ),
      
      body: Column(
        children: <Widget>[
          // --- Input Section: Task and Time Fields ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // Task Input (Expanded)
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Task Description',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                      labelStyle: const TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                // Time Input (Fixed Width)
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _timeController,
                    keyboardType: TextInputType.datetime, // Suggests number/time input
                    decoration: InputDecoration(
                      labelText: 'Time',
                      hintText: 'e.g., 9:00 AM',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                      labelStyle: const TextStyle(color: Colors.purple),
                      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8), // Adjust padding
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                // Add Button
                FloatingActionButton(
                  onPressed: _addTask,
                  backgroundColor: Colors.deepPurple,
                  elevation: 5,
                  mini: true, // Use a smaller button for space
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          
          // --- List View Section ---
          Expanded(
            child: ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (context, index) {
                final item = _todoItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      // Display the time on the left
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          item['time']!, // Display the time
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple.shade800,
                          ),
                        ),
                      ),
                      
                      // Display the task description in the center
                      title: Text(
                        item['task']!, // Display the task
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0,
                        ),
                      ),
                      
                      // Delete button on the right
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => _removeTask(index),
                        splashRadius: 20.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}