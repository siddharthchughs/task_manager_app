import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_manager_app/model/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTaskScreen> {
  late double _deviceWidth, _deviceHeight;
  final form_key = GlobalKey<FormState>();
  String? content;
  Box? box;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green.shade600),
        title: Text(
          'Add Task',
          style: TextStyle(fontSize: 28, color: Colors.green.shade600),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [intializeHiveBox()],
        ),
      ),
    );
  }

  Widget intializeHiveBox() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          box = snapshot.data;
          return _addTaskForm();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _addTaskForm() {
    return Form(
      key: form_key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a some characters';
              }
              return null;
            },
            onSaved: (newValue) {
              content = newValue!;
            },
            onChanged: (value) {
              content = value;
            },
          ),
          TextButton(onPressed: submit, child: Text('submit')),
        ],
      ),
    );
  }

  void submit() {
    final isValidated = form_key.currentState!.validate();
    if (isValidated) {
      form_key.currentState!.save();
      if (content != null) {
        var task = TaskModel(
          title: content!,
          timeStamp: DateTime.now(),
          done: false,
        );
        box!.add(task.toMap());
        setState(() {
          content = null;
        });
      }
      Navigator.pop(context);
    }
  }
}
