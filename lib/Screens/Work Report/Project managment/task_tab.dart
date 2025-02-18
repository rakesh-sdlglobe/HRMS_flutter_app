import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/Work%20Report/Project%20managment/edit_project_task.dart';
import 'package:hrm_employee/Screens/Work%20Report/Project%20managment/project_progress.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:hrm_employee/providers/user_provider.dart';
import 'package:intl/intl.dart';

class TasksTab extends StatefulWidget {
  final Project project;

  TasksTab({required this.project});

  @override
  _TasksTabState createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  late UserData userData;
  List<Map<String, dynamic>> taskData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    userData = Provider.of<UserData>(context, listen: false);

    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.4:3000/task/getProjectTask'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userData.token}',
        },
        body: json.encode({
          'project': widget.project.name,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> taskRecords = jsonData['taskRecords'];
        List<Map<String, dynamic>> data = taskRecords.map((record) {
          return {
            'id': record['id'] ?? 0,
            'task': record['task'],
            'deadline': record['deadline'],
            'assignee': record['assignee'],
            'description': record['description'],
            'status': record['status'],
          };
        }).toList();

        setState(() {
          taskData = data;
        });
      } else {
        print('Failed to fetch tasks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching tasks: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tasks',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20.0),
               ...taskData.map((task) => _buildTaskCard(
                      context,
                      id: task['id'],
                      title: task['task'],
                      description: task['description'],
                      completed: task['status'] == 'Completed',
                      assignee: task['assignee'],
                      deadline: _formatDate(task['deadline']), 
                    )).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

    String _formatDate(String dateTimeString) {
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      return formatter.format(dateTime);
    } catch (e) {
      return dateTimeString;  
    }
  }

Widget _buildTaskCard(
  BuildContext context, {
  required int id,
  required String title,
  required String description,
  required bool completed,
  required String assignee,
  required String deadline,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    margin: const EdgeInsets.only(bottom: 16.0),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 5.0),
                IconButton(
                  onPressed: () async {
                    final updatedTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProjectTaskScreen(
                          task: {
                            'id': id,
                            'project':widget.project.name,
                            'task_name': title,
                            'description': description,
                            'completed': completed,
                            'assignee': assignee,
                            'deadline': deadline,
                          },
                        ),
                      ),
                    );

                    if (updatedTask != null) {
                      fetchData();
                    }
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            if (completed)
              const Chip(
                label: Text(
                  'Completed',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            if (!completed)
              const Chip(
                label: Text(
                  'Not Completed',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          description,
          style: TextStyle(color: Colors.grey[800]),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Deadline: $deadline',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 12.0),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.people, color: Colors.blueAccent),
          title: const Text(
            'Assignee:',
            style: TextStyle(color: Colors.black87),
          ),
          subtitle: Text(assignee),
        ),
      ],
    ),
  );
}
}