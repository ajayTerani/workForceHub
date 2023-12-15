import 'package:flutter/material.dart';
import 'package:workforcehub/models/employee_model.dart';
import '../repository/get_employee_data.dart';
import '../widgets/shimmer.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<EmployeeModel> employees = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final apiService = GetEmployeeData();

    try {
      final fetchedEmployees = await apiService.fetchData();
      setState(() {
        employees = fetchedEmployees;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _editEmployee(EmployeeModel employee) async {
    final updatedEmployee = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          user: employee,
          firstName: employee.firstName ?? "",
          lastName: employee.lastName ?? "",
          email: employee.email ?? "",
          onSave: (updatedUser) {
            _updateEmployeeList(employee, updatedUser);
          },
        ),
      ),
    );

    if (updatedEmployee != null) {
      print('Updated employee: $updatedEmployee');
    }
  }

  void _updateEmployeeList(
      EmployeeModel oldEmployee, EmployeeModel newEmployee) {
    setState(() {
      final index = employees.indexOf(oldEmployee);
      if (index != -1) {
        employees[index] = newEmployee;
      }
    });
  }

  Future<void> _deleteEmployee(EmployeeModel employee) async {
    _removeEmployee(employee);
  }

  void _removeEmployee(EmployeeModel employee) {
    setState(() {
      employees.remove(employee);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: employees.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          shadowColor: Colors.black,
          elevation: 8,
          title: Text(
            "Home Page",
            style: TextStyle(
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Container(
              height: height * 0.06,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: TabBar(
                  tabs: employees
                      .map((employee) => Tab(text: employee.firstName))
                      .toList(),
                  isScrollable: true,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.blue,
              ),
              onPressed: () {
                _fetchData();
              },
            ),
          ],
        ),
        body: isLoading
            ? RectangleBoxShimmerWidget()
            : TabBarView(
                children: employees.map((employee) {
                  return Container(
                    padding: EdgeInsets.all(height * 0.02),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (employee.avatar != null)
                                CircleAvatar(
                                  radius: width * 0.3,
                                  backgroundImage:
                                      NetworkImage(employee.avatar!),
                                ),
                            ],
                          ),
                          SizedBox(height: height * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "First Name: ${employee.firstName}",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Last Name: ${employee.lastName}",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Email: ${employee.email}",
                                style: TextStyle(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _editEmployee(employee);
                                },
                                child: Text(
                                  "Edit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Delete Employee",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.06,
                                          ),
                                        ),
                                        content: Text(
                                          "Are you sure you want to delete ${employee.firstName}?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.04,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.04,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              _deleteEmployee(employee);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: width * 0.04,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * 0.035,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
