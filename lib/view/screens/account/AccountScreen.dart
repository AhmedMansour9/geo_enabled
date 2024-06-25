import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:geo_enabled/data/repository/home_repo.dart';
import 'package:geo_enabled/provider/home_provider.dart';
import 'package:geo_enabled/utill/color_resources.dart';
import 'package:geo_enabled/view/screens/auth/login.dart';
import 'package:restart_app/restart_app.dart';

import '../../../provider/auth_provider.dart';
import '../../../utill/images.dart';
import 'package:provider/provider.dart';

import '../splash/splash_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadData(BuildContext context, bool reload) async {
    // final loginProvider = Provider.of<AuthProvider>(context);
    //
    // await Provider.of<HomeProvider>(context, listen: false)
    //     .getAllChecks(context, reload, loginProvider.getUserName());
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width / 4; // Example: 1/4th of screen width
    double cardHeight = cardWidth; // Keeping height equal to the dynamic width

    final loginProvider = Provider.of<AuthProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    _loadData(context, false);

    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: ColorResources.COLOR_GRAY,
        // Ensures no white background shows at the corner
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_LIGHTBLUE,
          elevation: 0, // Removes the shadow from the AppBar
          // leading: IconButton(
          //   icon: const Icon(Icons.menu, color: Colors.white),
          //   onPressed: () {},
          // ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(200),
                                bottomRight: Radius.circular(200),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: ColorResources.COLOR_LIGHTBLUE,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 120,
                                        margin: const EdgeInsets.only(top: 100),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            // Set the border color
                                            width: 4.0, // Set the border width
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/image/img_profile.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(loginProvider.getUserName(),
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                      const SizedBox(height: 25),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Positioned(
                            //   left: 0,
                            //   bottom: 0,
                            //   right: 0,
                            //   child: Center(
                            //     child: Container(
                            //      padding: EdgeInsets.only(top: 20),
                            //       width: 150,
                            //       child: ElevatedButton(
                            //           onPressed: () {
                            //             // Add your onPressed code here!
                            //           },
                            //           style: ElevatedButton.styleFrom(
                            //             primary: Color(0xFF0097A7),
                            //             // Background color
                            //             onPrimary: Colors.white,
                            //             // Text color
                            //             padding: EdgeInsets.symmetric(
                            //                 horizontal: 24, vertical: 12),
                            //             shape: RoundedRectangleBorder(
                            //               borderRadius:
                            //               BorderRadius.circular(
                            //                   20), // Rounded corners
                            //             ),
                            //             elevation: 5, // Shadow elevation
                            //           ),
                            //           child: Text(
                            //             'Edit profile',
                            //             style: TextStyle(
                            //               fontSize: 16, // Text size
                            //             ),
                            //           )),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ListView(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: buildSmallCard(
                                        onTap: () {
                                          /* Day off tap action */
                                        },
                                        imageAsset: Images.leave,
                                        text: 'Business leave',
                                        width: cardWidth,
                                        height: cardHeight,
                                      ),
                                    ),
                                    Flexible(
                                      child: buildSmallCard(
                                        onTap: () {
                                          /* Activities tap action */
                                        },
                                        imageAsset: Images.leave,
                                        text: 'Sick leave',
                                        width: cardWidth,
                                        height: cardHeight,
                                      ),
                                    ),
                                    Flexible(
                                      child: buildSmallCard(
                                        onTap: () {
                                          /* Event tap action */
                                        },
                                        imageAsset: Images.leave,
                                        text: 'Annual leave',
                                        width: cardWidth,
                                        height: cardHeight,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                        ListView(
                          padding: const EdgeInsets.all(8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: buildSmallCard(
                                        onTap: () {
                                          /* Day off tap action */
                                        },
                                        imageAsset: Images.leave,
                                        text: 'Arrive late',
                                        width: cardWidth,
                                        height: cardHeight,
                                      ),
                                    ),
                                    Flexible(
                                      child: buildSmallCard(
                                        onTap: () {
                                          /* Event tap action */
                                        },
                                        imageAsset: Images.leave,
                                        text: 'Absent work',
                                        width: cardWidth,
                                        height: cardHeight,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ProfileInformation(),
                            ),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {
                              loginProvider.clearSharedData();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => LoginScreen()),
                                    (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF0097A7),
                              // Background color
                              onPrimary: Colors.white,
                              // Text color
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Rounded corners
                              ),
                              elevation: 5, // Shadow elevation
                            ),
                            child: Text(
                              'Log out',
                              style: TextStyle(
                                fontSize: 16, // Text size
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Overlay CircularProgressIndicator if isLoading is true
            if (homeProvider.isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ));
  }

  void handleTap() {
    // Tap handling logic
  }

  Widget buildCard(
      {void Function()? onTap,
      required String imageAsset,
      required String text,
      required double width,
      required double height}) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(imageAsset, width: 40, height: 40),
              const SizedBox(height: 10),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSmallCard(
    {void Function()? onTap,
    required String imageAsset,
    required String text,
    required double width,
    required double height}) {
  return Card(
    elevation: 2.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageAsset, width: 25, height: 25),
            const SizedBox(height: 15),
            Text(text),
          ],
        ),
      ),
    ),
  );
}

class ProfileInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<AuthProvider>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ProfileRow(label: 'Username', value: loginProvider.getUserFullName()),
            ProfileRow(label: 'Position', value: loginProvider.getUserPosition()),
            ProfileRow(label: 'Birthday', value: loginProvider.getUserBirthDate()),
            ProfileRow(label: 'Personal E-mail', value: loginProvider.getUserEmail()),
            ProfileRow(label: 'Start of date work', value: loginProvider.getUserStartDate()),
          ],
        ),
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;

  ProfileRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white60,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12.0),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
