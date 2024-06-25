import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';
import '../../../provider/home_provider.dart';
import 'package:intl/intl.dart';

import '../../../utill/color_resources.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData(BuildContext context, bool reload, String date) async {
    final loginProvider = Provider.of<AuthProvider>(context);

    await Provider.of<HomeProvider>(context, listen: false)
        .getAllEvents(context, reload, loginProvider.getUserName(), date);
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);

    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF007991),
        // Custom color
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white), // Icon color
          onPressed: () {
            // Handle menu button press
          },
        ),
        title: Text('Events', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white), // Icon color
            onPressed: () {
              // Handle more button press
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: buildTabContent(homeProvider, loginProvider),
              ),
            ],
          ),
          if (homeProvider.isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }

  Widget buildTabContent(HomeProvider homeProvider, AuthProvider authProvider) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
              String formattedDate =
              DateFormat('yyyy-MM-dd').format(_focusedDay);

              homeProvider.getAllEvents(
                  context, true, authProvider.getUserName(), formattedDate);
              print("_focusedDay" + _focusedDay.toString());
            });
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        SizedBox(height: 10),
        Expanded(
          child: Consumer<HomeProvider>(
            builder: (context, home, child) {
              if (home.eventsList != null && home.eventsList!.isNotEmpty) {
                return Column(
                  children: home.eventsList!.map((event) {
                    return LeaveRequestCard(
                      name: event.subject ?? '',
                      leaveType: "",
                      leaveIcon: Icons.business_center,
                      leaveColor: Colors.blue,
                      startDate: event.startDate ?? '',
                      endDate: event.endDate ?? '',
                      days: event.duration.toString(),
                      status: "",
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text(
                    'No events found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
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
      margin: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // CircleAvatar(
                //   radius: 20,
                //   backgroundImage: NetworkImage(
                //       'https://via.placeholder.com/150'), // Replace with actual image URL or asset
                // ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(leaveIcon, color: leaveColor, size: 16),
                        SizedBox(width: 5),
                        Text(
                          leaveType,
                          style: TextStyle(color: leaveColor, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                // Column(
                //   children: [
                //     Text(days,
                //         style: TextStyle(
                //             fontSize: 16, fontWeight: FontWeight.bold)),
                //     Text(
                //       status,
                //       style: TextStyle(
                //           color: status == 'Approved'
                //               ? Colors.green
                //               : Colors.orange,
                //           fontSize: 14),
                //     ),
                //   ],
                // ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text('Start: $startDate',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                SizedBox(width: 5),
                Text('End: $endDate',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 10),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle details button press
            //     },
            //     style: ElevatedButton.styleFrom(
            //       primary: Color(0xFF007991), // Background color
            //       onPrimary: Colors.white, // Text color
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     ),
            //     child: Text('Details'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

// Container(
//   padding: EdgeInsets.all(10.0),
//   color: Colors.white,
//   child: Row(
//     children: [
//       Expanded(
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search...',
//             hintStyle: TextStyle(color: Colors.grey), // Hint text color
//             prefixIcon: Icon(Icons.search, color: Colors.grey), // Icon color
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10.0),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             fillColor: Colors.grey[200],
//           ),
//         ),
//       ),
//       SizedBox(width: 10),
//       Container(
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: Color(0xFF007991), // Custom color
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Icon(
//           Icons.filter_list,
//           color: Colors.white,
//         ),
//       ),
//     ],
//   ),
// ),
// Container(
//   color: Colors.white,
//   child: TabBar(
//     controller: _tabController,
//     labelColor: Colors.black,
//     indicatorColor: Color(0xFF007991), // Custom color
//     unselectedLabelColor: Colors.grey,
//     tabs: [
//       Tab(text: 'Events (99)'),
//       // Tab(text: 'Leave (99)'),
//     ],
//   ),
// ),
