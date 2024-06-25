import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geo_enabled/localization/language_constrants.dart';
import 'package:geo_enabled/provider/language_provider.dart';
import 'package:geo_enabled/provider/localization_provider.dart';
import 'package:geo_enabled/utill/color_resources.dart';
import 'package:geo_enabled/utill/dimensions.dart';
import 'package:geo_enabled/utill/images.dart';
import 'package:geo_enabled/utill/styles.dart';
import 'package:geo_enabled/view/screens/account/AccountScreen.dart';
import 'package:geo_enabled/view/screens/calendar/CalendarScreen.dart';
import 'package:geo_enabled/view/screens/employes/EmployeesScreen.dart';
import 'package:geo_enabled/view/screens/leave/LeaveScreen.dart';
import 'package:provider/provider.dart';

import '../home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    // EmployeesScreen(),
    CalendarScreen(),
    LeaveScreen(),
    AccountScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 56,
        color: ColorResources.COLOR_DARKBLUE,
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Images.home, 'Home'),
            // _buildNavItem(1, Images.requests, 'Requests'),
            _buildNavItem(1, Images.calendar, 'Calendar'),
            _buildNavItem(2, Images.leave, 'Leave'),
            _buildNavItem(3, Images.account, 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
        child: Container(
          height: kToolbarHeight,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? ColorResources.COLOR_LIGHTBLUE
                : Colors.transparent,
            // borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                iconPath,
                width: 30,
                height: 30,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Text(label,
                  style: const TextStyle(color: Colors.white, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}

// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//
//   static const TextStyle optionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
//
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text('Home', style: optionStyle),
//     Text('Employees', style: optionStyle),
//     Text('Calendar', style: optionStyle),
//     Text('Leave', style: optionStyle),
//     Text('Account', style: optionStyle),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   BottomNavigationBarItem _buildItem({required String iconPath,required String label}) {
//     return BottomNavigationBarItem(
//       icon: Container(
//         width: 30,
//         height: 30,
//         decoration: BoxDecoration(
//           color: _selectedIndex == label ? ColorResources.COLOR_PRIMARY : ColorResources.COLOR_DARKBLUE,
//           borderRadius: BorderRadius.circular(50),
//         ),
//         child: Center(
//           child: Image.asset(
//             iconPath,
//             width: 30,
//             height: 30,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       label: label,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: ColorResources.COLOR_DARKBLUE,
//         items: [
//           _buildItem(iconPath: Images.home, label: 'Home'),
//           _buildItem(iconPath: Images.employees, label: 'Employees'),
//           _buildItem(iconPath: Images.calendar, label: 'Calendar'),
//           _buildItem(iconPath: Images.leave, label: 'Leave'),
//           _buildItem(iconPath: Images.account, label: 'Account'),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }

//
// class DashboardScreen extends StatefulWidget {
//   @override
//   _DashboardScreenPageState createState() => _DashboardScreenPageState();
// }
//
// class _DashboardScreenPageState extends State<DashboardScreen> {
//   int _selectedIndex = 0;
//
//   static const TextStyle optionStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
//
//   static const List<Widget> _widgetOptions = <Widget>[
//   Text('Home', style: optionStyle),
//
//
//     Text('Employees', style: optionStyle),
//     Text('Calendar', style: optionStyle),
//     Text('Leave', style: optionStyle),
//     Text('Account', style: optionStyle),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: ColorResources.COLOR_DARKBLUE,
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Image.asset(Images.home, width: 30,height: 30,),
//             label: 'Home',
//             backgroundColor: Colors.blue,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(Images.employees,width: 30,height: 30,),
//             label: 'Employees',
//             backgroundColor: Colors.blue,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(Images.calendar, width: 30,height: 30,),
//             label: 'Calendar',
//             backgroundColor: Colors.blue,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(Images.leave,width: 30,height: 30,),
//             label: 'Leave',
//             backgroundColor: Colors.blue,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(Images.account,width: 30,height: 30,),
//             label: 'Account',
//             backgroundColor: Colors.blue,
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.white,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//       ),
//     );
//   }
// }

// class DashboardScreen extends StatefulWidget {
//   final int pageIndex;
//
//   DashboardScreen({required this.pageIndex});
//
//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }
//
//
//
// class _DashboardScreenState extends State<DashboardScreen> {
//   PageController? _pageController;
//   int _pageIndex = 3;
//   List<Widget>? screens;
//   List<TabData>? listTabs;
//   GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
//   GlobalKey bottomNavigationKey = GlobalKey();
//   String? lang;
//
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         statusBarIconBrightness: Brightness.light,
//         statusBarColor: ColorResources.COLOR_PRIMARY));
//     _pageIndex = widget.pageIndex;
//
//     _pageController = PageController(initialPage: widget.pageIndex);
//     screens = [
//       HomeScreen(),
//       const EmployeesScreen(),
//       const CalendarScreen(),
//       const LeaveScreen(),
//       const AccountScreen(),
//     ];
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     initData();
//
//     return WillPopScope(
//       onWillPop: () async {
//         if (_pageIndex != 0) {
//
//           FancyBottomNavigationState fState = bottomNavigationKey
//               .currentState as FancyBottomNavigationState;
//           fState.setPage(0);
//
//           return false;
//         } else {
//           return true;
//         }
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         bottomNavigationBar: FancyBottomNavigation(
//          key: bottomNavigationKey,
//           barBackgroundColor: ColorResources.COLOR_PRIMARY,
//           circleColor: Colors.white,
//           inactiveIconColor: Colors.white,
//           activeIconColor: ColorResources.COLOR_PRIMARY,
//
//           tabs: listTabs,
//           onTabChangedListener: (position) {
//             setState(() {
//               _setPage(position);
//             });
//           },
//         ),
//
//
//         body: PageView.builder(
//
//           controller: _pageController,
//           itemCount: screens!.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return screens![index];
//           },
//         ),
//       ),
//     );
//   }
//
//   void _setPage(int pageIndex) {
//     setState(() {
//       _pageController?.jumpToPage(pageIndex);
//       _pageIndex = pageIndex;
//     });
//   }
//
//   void initData() {
//     lang = Provider.of<LocalizationProvider>(context, listen: false)
//         .locale
//         .languageCode;
//     listTabs = [
//       TabData(imagePath: Images.home, title: getTranslated('home', context)),
//       TabData(imagePath: Images.employees, title: getTranslated('employees', context)),
//       TabData(
//           imagePath: Images.calendar, title: getTranslated('calendar', context)),
//       TabData(
//           imagePath: Images.leave, title: getTranslated('leave', context)),
//       TabData(imagePath: Images.account, title: getTranslated('account', context)),
//     ];
//     if (lang !=null && lang!.contains("ar")) {
//       screens?.reversed;
//       listTabs?.reversed;
//     }
//     print("screeeen +$screens");
//   }
// }
