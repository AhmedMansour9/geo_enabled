import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/home_provider.dart';

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _leaveType;
  DateTime? _startDate;
  String? startDate;
  String? endDate;
  DateTime? _endDate;
  TextEditingController _reasonController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  List<Map<String, dynamic>> leaveTypes = [
    {"name": "Paid Time Off", "id": 1},
    {"name": "Compensatory Days", "id": 3},
    {"name": "Unpaid", "id": 4},
    {"name": "Entitlement Time Off", "id": 6},
    {"name": "Permission", "id": 7},
    {"name": "Sick Time Off", "id": 2},
  ];
  String? _selectedLeaveType;
  int? _selectedLeaveTypeId;

  _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? _startDate ?? DateTime.now()
          : _endDate ?? DateTime.now(),
      firstDate: DateTime.now(),  // Disable dates before today
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          startDate = DateFormat('yyyy-MM-dd').format(picked);
          _startDateController.text = startDate ?? '';
        } else {
          _endDate = picked;
          endDate = DateFormat('yyyy-MM-dd').format(picked);
          _endDateController.text = endDate ?? '';
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leave request',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF007991),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Leave data',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedLeaveType,
                decoration: InputDecoration(
                  labelText: 'Leave type',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: leaveTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type['name'],
                    child: Text(type['name']),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLeaveType = newValue;
                    _selectedLeaveTypeId = leaveTypes
                        .firstWhere((type) => type['name'] == newValue)['id'];
                  });
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context, true),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _startDateController,
                    decoration: InputDecoration(
                      // labelText: 'Start Date-time',
                      hintText: 'Start Date-time',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectDate(context, false),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _endDateController,
                    decoration: InputDecoration(
                      // labelText: 'End Date-time',
                      hintText: 'End Date-time',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _reasonController,
                decoration: InputDecoration(
                  // labelText: 'Reason',
                  hintText: 'Reason',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: loginProvider.isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              homeProvider
                                  .requestLeave(
                                      loginProvider.getUserName(),
                                      startDate ?? '',
                                      endDate ?? '',
                                      _reasonController.text ?? '',
                                      _selectedLeaveTypeId ?? 0)
                                  .then((value) {
                                if (value.isSuccess!) {
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: value.message ?? "",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF007991), // Background color
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: loginProvider.isLoading
                        ? CircularProgressIndicator()
                        : Text(
                            'Save & Request',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade300, // Background color
                      onPrimary: Colors.black, // Text color
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF004D66),
    );
  }
}
