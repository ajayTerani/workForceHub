import 'package:flutter/material.dart';

import '../models/employee_model.dart';
import '../widgets/custom_textfield.dart';

class EditScreen extends StatefulWidget {
  final EmployeeModel user;
  final String firstName;
  final String lastName;
  final String email;
  final Function(EmployeeModel) onSave;

  const EditScreen({
    Key? key,
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.firstName;
    emailController.text = widget.email;
    lastNameController.text = widget.lastName;
  }

  bool isFieldEmpty(String value) {
    return value.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
        elevation: 1.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          children: [
            CustomTextfield(
              controller: nameController,
              hintText: 'Enter First Name',
              validator: (value) {
                if (isFieldEmpty(value??"")) {
                  return 'Please enter First Name';
                }
                return null;
              },
            ),
            SizedBox(height: height * 0.03),

            CustomTextfield(
              controller: lastNameController,
              hintText: 'Enter Last Name',
              validator: (value) {
                if (isFieldEmpty(value??"")) {
                  return 'Please enter Last Name';
                }
                return null;
              },
            ),
            SizedBox(height: height * 0.03),

            CustomTextfield(
              controller: emailController,
              hintText: 'Enter Email',
              validator: (value) {
                if (isFieldEmpty(value??"")) {
                  return 'Please enter Email';
                }
                return null;
              },
            ),

            SizedBox(height: height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        lastNameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      EmployeeModel updatedUser = EmployeeModel(
                        firstName: nameController.text,
                        email: emailController.text,
                        lastName: lastNameController.text,
                        avatar: widget.user.avatar,
                      );

                      widget.onSave(updatedUser);

                      Navigator.of(context).pop();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill in all fields.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
