// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:hrm_employee/Screens/Admin%20Dashboard/Project%20managment/assign_project.dart';
import 'package:hrm_employee/Screens/Admin%20Dashboard/Project%20managment/project_progress.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_application.dart';
import 'package:hrm_employee/Screens/Leave%20Management/leave_apply.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../constant.dart';

class ProjectManagementScreen extends StatefulWidget {
  const ProjectManagementScreen({Key? key}) : super(key: key);

  @override
  _ProjectManagementScreenState createState() =>
      _ProjectManagementScreenState();
}

class _ProjectManagementScreenState extends State<ProjectManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 84, 27, 94),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 84, 27, 94),
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Project Managment',
          maxLines: 2,
          style: kTextStyle.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: context.width(),
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFF7D6AEF),
                            width: 3.0,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          ProjectProgress().launch(context);
                        },
                        leading: const Image(
                            image: AssetImage('images/leaveapplication.png')),
                        title: Text(
                          'Project Progress',
                          maxLines: 2,
                          style: kTextStyle.copyWith(
                              color: kTitleColor, fontWeight: FontWeight.bold),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Material(
                    elevation: 2.0,
                    child: GestureDetector(
                      onTap: () {
                        const ProjectAssignmentScreen().launch(context);
                      },
                      child: Container(
                        width: context.width(),
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Color(0xFFFD73B0),
                              width: 3.0,
                            ),
                          ),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          leading: const Image(
                              image:
                                  AssetImage('images/leaverecommendation.png')),
                          title: Text(
                            'Assign Project',
                            maxLines: 2,
                            style: kTextStyle.copyWith(
                                color: kTitleColor,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
