import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/LeaveModel.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/home_provider.dart';
import '../../../utill/routes.dart';

class LeaveScreen extends StatefulWidget {
  @override
  _LeaveScreenState createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _loadData(context, true);

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didPopNext() {
    _loadData(context, true);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData(context, true);
  }

  Future<void> _loadData(BuildContext context, bool reload) async {
    await Provider.of<HomeProvider>(context, listen: false).getAllLeaves(
        context,
        reload,
        Provider.of<AuthProvider>(context, listen: false).getUserName());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF007991),
          // Custom color
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Handle menu button press
            },
          ),
          title: Text(
            'Leave',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(
                    context, Routes.getLeaveRequestRoute());
              },
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Color(0xFF007991),
            // Custom color
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Pending '),
              Tab(text: 'Approved '),
              Tab(text: 'Not approved '),
            ],
          ),
        ),
        body: Consumer<HomeProvider>(builder: (context, homeProvider, child) {
          List<LeaveModel> confirmedLeaves = homeProvider.levelsList
              ?.where((leave) => leave.status == 'confirm')
              .toList() ?? [];
          List<LeaveModel> approvedLeaves = homeProvider.levelsList
              ?.where((leave) => leave.status == 'validate')
              .toList() ?? [];
          List<LeaveModel> notApprovedLeaves = homeProvider.levelsList
              ?.where((leave) => leave.status == 'refuse')
              .toList() ?? [];

          return TabBarView(
            controller: _tabController,
            children: [
                LeaveRequestList(leaveList: confirmedLeaves),
              LeaveRequestList(leaveList: approvedLeaves),
              LeaveRequestList(leaveList: notApprovedLeaves),
            ],
          );
        }));
  }
}

class LeaveRequestList extends StatelessWidget {
  final List<LeaveModel>? leaveList;

  LeaveRequestList({required this.leaveList});

  @override
  Widget build(BuildContext context) {

    if (leaveList == null || leaveList!.isEmpty) {
      return Center(
        child: Text('No leave requests available'),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: leaveList!.length,
      itemBuilder: (context, index) {
        final leave = leaveList![index];
        return LeaveRequestCard(
          name: 'Firstname Lastname', // Assuming a name property
          leaveType: leave.type ?? "",
          leaveIcon: Icons.business_center,
          leaveColor: getStatusColor(leave.status!),
          startDate: leave.startDate ?? '',
          endDate: leave.endDate ?? '',
          days: calculateDays(leave.startDate ?? '', leave.endDate ?? ''),
          status: leave.status ?? '',
        );
      },
    );
  }
}
String calculateDays(String startDate, String endDate) {
  final start = DateTime.parse(startDate);
  final end = DateTime.parse(endDate);
  final days = end.difference(start).inDays + 1;
  return '$days Day${days > 1 ? 's' : ''}';
}
Color getStatusColor(String status) {
  switch (status) {
    case 'confirm':
      return Colors.green;
    case 'refuse':
      return Colors.red;
    default:
      return Colors.orange;
  }
}


class LeaveRequestCard extends StatelessWidget {
  final String name;
  final String leaveType;
  final IconData leaveIcon;
  final Color leaveColor;
  final String startDate;
  final String endDate;
  final String days;
  final String status;

  LeaveRequestCard({
    required this.name,
    required this.leaveType,
    required this.leaveIcon,
    required this.leaveColor,
    required this.startDate,
    required this.endDate,
    required this.days,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(leaveIcon, color: leaveColor, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    leaveType,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: leaveColor,
                    ),
                  ),
                ),
                Text(
                  days,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Center(
            //   child: Container(
            //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     decoration: BoxDecoration(
            //       color: Colors.grey.shade200,
            //       borderRadius: BorderRadius.circular(5),
            //     ),
            //     child: Text(
            //       status,
            //       style: TextStyle(
            //         fontSize: 14,
            //         color: Colors.orange,
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  'Start: $startDate',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text(
                  'End: $endDate',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}






