import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager_app/model/task_model.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePage();
}

class _HomePage extends State<HomePageScreen> {
  late double _deviceWidth, _deviceHeight;
  Box? boxContainer;
  String? content;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade400,
        toolbarHeight: _deviceHeight * 0.15,
        title: Text(
          'Taskly',
          style: TextStyle(fontSize: 45, color: Colors.amber.shade100),
        ),
      ),
      body: _taskBody(),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.green.shade400,
        onPressed: () {
          Navigator.of(context).pushNamed('add_task');
        },
        child: Icon(Icons.add, color: Colors.amberAccent.shade200),
      ),
    );
  }

  // void addTask() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Create New Task'),
  //         content: Column(
  //           children: [
  //             TextField(
  //               onSubmitted: (_) {
  //                 if (content != null) {
  //                   var newTask = TaskModel(
  //                     title: content!,
  //                     timeStamp: DateTime.now(),
  //                     done: false,
  //                   );
  //                   boxContainer!.add(newTask.toMap());
  //                   setState(() {
  //                     content = null;
  //                   });
  //                   Navigator.pop(context);
  //                 }
  //               },
  //               onChanged: (value) {
  //                 content = value;
  //               },
  //             ),
  //             TextButton(onPressed: () {}, child: Text('Submit')),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _taskBody() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          boxContainer = snapshot.data;
          return _showTaskList();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _showTaskList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('tasks').listenable(),
      builder: (context, value, child) {
        List taskContainerList = boxContainer!.values.toList();
        return ListView.builder(
          itemCount: taskContainerList.length,
          itemBuilder: (context, index) {
            var task = TaskModel.fromMap(taskContainerList[index]);
            return ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.done ? TextDecoration.lineThrough : null,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(task.timeStamp.toString()),
              trailing: Icon(
                task.done
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_outlined,
                color: Colors.green.shade700,
              ),
              onTap: () {
                task.done = !task.done;
                boxContainer!.putAt(index, task.toMap());
              },
              onLongPress: () {
                task.done = !task.done;
                boxContainer!.deleteAt(index);
              },
            );
          },
        );
      },
    );
  }
}
