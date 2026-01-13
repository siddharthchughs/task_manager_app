class TaskModel {
  String title;
  DateTime timeStamp;
  bool done;

  TaskModel({required this.title, required this.timeStamp, required this.done});

  // this function that takes in a map to use key to get the value based upon
  // a key and render the same to the UI.
  // This is an extension over our constructor class and factory method
  // starts with class name.

  factory TaskModel.fromMap(Map task) {
    // You are mapping the key's values from the toMap function to
    // the TaskModel.
    return TaskModel(
      title: task['title'],
      timeStamp: task['timestamp'],
      done: task['done'],
    );
  }

  // We can convert the class into map using this method.
  Map toMap() {
    return {'title': title, 'timestamp': timeStamp, 'done': done};
  }
}
