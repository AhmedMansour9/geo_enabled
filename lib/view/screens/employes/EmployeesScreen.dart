import 'package:flutter/material.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employees Screen'),
      ),
      body: Center(
        child: Text('Employees Screen'),
      ),
    );
  }
}