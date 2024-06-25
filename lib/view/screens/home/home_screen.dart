
import 'package:flutter/material.dart';
import 'package:geo_enabled/data/repository/home_repo.dart';
import 'package:geo_enabled/provider/home_provider.dart';
import 'package:geo_enabled/utill/color_resources.dart';

import '../../../provider/auth_provider.dart';
import '../../../utill/images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? mapController;
  LatLng? currentLocation;

  @override
  void initState() {
    super.initState();
    _loadData(context, false);

    _determinePosition().then((position) {
      // Use the Position object here
      currentLocation = LatLng(position.latitude, position.longitude);
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation!, zoom: 15),
      ));
    }).catchError((error) {
      // Handle the error here
    });
  }

  Future<bool> isDistanceGreaterThan(double startLatitude,
      double startLongitude, double endLatitude, double endLongitude) async {
    double distance = await calculateDistance(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distance > 200;
  }

  Future<double> calculateDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    // Use the Geolocator package to calculate the distance in meters
    double distanceInMeters = Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
    return distanceInMeters;
  }

  String getFormattedDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMMM d, yyyy');
    return formatter.format(dateTime);
  }

  String getFormattedFullDate(DateTime dateTime) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    return formattedDate;
  }

  String formattedCheckIn(String checkIn) {
    DateTime dateTime = DateTime.parse(checkIn);
    return DateFormat('MMMM d, yyyy').format(dateTime);
  }

  String formattedCheckInTime(String checkIn) {
    DateTime dateTime = DateTime.parse(checkIn);
    return DateFormat('h:mm a').format(dateTime);
  }

  String getWeekDay(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEEE');
    return formatter.format(dateTime);
  }

  String getCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat timeFormatter = DateFormat('h:mm a');
    return timeFormatter.format(now);
  }

  Future<void> _loadData(BuildContext context, bool reload) async {

    await Provider.of<HomeProvider>(context, listen: false)
        .getAllChecks(context, reload, Provider.of<AuthProvider>(context, listen: false).getUserName());
  }

  @override
  Widget build(BuildContext context) {
    double cardWidth =
        MediaQuery.of(context).size.width / 4; // Example: 1/4th of screen width
    double cardHeight = cardWidth; // Keeping height equal to the dynamic width

    final loginProvider = Provider.of<AuthProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);
    DateTime now = DateTime.now();


    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: ColorResources.COLOR_GRAY,
        // Ensures no white background shows at the corner
        appBar: AppBar(
          backgroundColor: ColorResources.COLOR_LIGHTBLUE,
          elevation: 0, // Removes the shadow from the AppBar
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(55),
                          bottomRight: Radius.circular(55),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: ColorResources.COLOR_LIGHTBLUE,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 90),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Hello,',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      Text(getWeekDay(now),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight:
                                              FontWeight.w700)),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(loginProvider.getUserName(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                    Text(getFormattedDate(now),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Center(
                                  child: Text(getCurrentTime(),
                                      style: const TextStyle(
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ),
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(15.0),
                                  child: Container(
                                    height: 120,
                                    width:
                                    MediaQuery.of(context).size.width,
                                    child: GoogleMap(
                                      onMapCreated: _onMapCreated,
                                      initialCameraPosition:
                                      CameraPosition(
                                        target: currentLocation == null
                                            ? const LatLng(
                                            30.0444, 31.2357)
                                            : currentLocation!,
                                        zoom: 15.0,
                                      ),
                                      myLocationEnabled: true,
                                      myLocationButtonEnabled: true,
                                      zoomControlsEnabled: false,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                InkWell(
                                  onTap: () async {
                                    double? workLatitude =
                                    double.tryParse(loginProvider
                                        .getUserLocationLatitude());
                                    double? workLongetude =
                                    double.tryParse(loginProvider
                                        .getUserLocationLongetude());

                                    bool isGreater =
                                    await isDistanceGreaterThan(
                                        currentLocation?.latitude ??
                                            0.0,
                                        currentLocation?.longitude ??
                                            0.0,
                                        workLatitude ?? 0.0,
                                        workLongetude ?? 0.0);
                                    !isGreater
                                        ? homeProvider.isCheckedIn()
                                        ? homeProvider.checkOut(
                                        loginProvider
                                            .getUserName(),
                                        getFormattedFullDate(now),
                                        currentLocation?.latitude
                                            .toString() ??
                                            "",
                                        currentLocation?.longitude
                                            .toString() ??
                                            "")
                                        : homeProvider.checkIn(
                                        loginProvider
                                            .getUserName(),
                                        getFormattedFullDate(now),
                                        currentLocation?.latitude
                                            .toString() ??
                                            "",
                                        currentLocation?.longitude
                                            .toString() ??
                                            "")
                                        : Fluttertoast.showToast(
                                        msg:
                                        " You Are out of the Area",
                                        toastLength:
                                        Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1393ba),
                                      // Replace with your desired color
                                      borderRadius: BorderRadius.circular(
                                          15.0), // Adjust radius to match your design
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: <Widget>[
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              Icons.location_on,
                                              // Choose the icon that fits your design
                                              color: Colors.white
                                                  .withOpacity(0.7),
                                              // Adjust color and opacity to match your design
                                              size:
                                              16.0, // Adjust size to match your design
                                            ),
                                            const SizedBox(width: 8),
                                            // Adjust spacing to match your design
                                            Text(
                                              'Geo-enabled HR App',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white
                                                    .withOpacity(
                                                    0.7), // Adjust the opacity to match your design
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          homeProvider.isCheckedIn()
                                              ? "Tap check-Out"
                                              : "Tap check-in",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 55),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: -60,
                        right: 0,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Flexible(
                                  child: buildCard(
                                    onTap: () {
                                      /* Day off tap action */
                                    },
                                    imageAsset: Images.day_off,
                                    text: 'Day off',
                                    width: cardWidth,
                                    height: cardHeight,
                                  ),
                                ),
                                Flexible(
                                  child: buildCard(
                                    onTap: () {
                                      /* Activities tap action */
                                    },
                                    imageAsset: Images.activities,
                                    text: 'Activities',
                                    width: cardWidth,
                                    height: cardHeight,
                                  ),
                                ),
                                Flexible(
                                  child: buildCard(
                                    onTap: () {
                                      /* Event tap action */
                                    },
                                    imageAsset: Images.event,
                                    text: 'Event',
                                    width: cardWidth,
                                    height: cardHeight,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  ListView(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Your Activities',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            // Add space between the text and the line
                            Flexible(
                              child: Container(
                                height: 2.0,
                                // Height of the line
                                width: double.infinity,
                                // The line should take full width available
                                color: Colors.green, // Color for the line
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<HomeProvider>(
                        builder: (context, home, child) {
                          return home.checkedList != null
                              ? Column(
                            children: [
                              Card(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      border: Border(
                                        left: BorderSide(
                                            color: ColorResources
                                                .COLOR_DARKBLUE,
                                            width:
                                            9), // The colored line
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text('Check in'),
                                      subtitle: Text(formattedCheckIn(
                                          home.checkedList?.first
                                              .checkIn ??
                                              "")),
                                      trailing: Text(
                                          formattedCheckInTime(home
                                              .checkedList
                                              ?.first
                                              .checkIn ??
                                              "")),
                                    ),
                                  )),
                              Card(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        bottomLeft: Radius.circular(5),
                                      ),
                                      border: Border(
                                        left: BorderSide(
                                            color: ColorResources
                                                .COLOR_DARKBLUE,
                                            width:
                                            9), // The colored line
                                      ),
                                    ),
                                    child: ListTile(
                                      title: Text('Check Out'),
                                      subtitle: Text(home
                                          .checkedList
                                          ?.first
                                          .checkOut
                                          ?.isNotEmpty ==
                                          true
                                          ? formattedCheckIn(home
                                          .checkedList
                                          ?.first
                                          .checkOut ??
                                          "")
                                          : ""),
                                      trailing: Text(home
                                          .checkedList
                                          ?.first
                                          .checkOut
                                          ?.isNotEmpty ==
                                          true
                                          ? formattedCheckInTime(home
                                          .checkedList
                                          ?.first
                                          .checkOut ??
                                          "")
                                          : ""),
                                    ),
                                  )),
                            ],
                          )
                              : SizedBox();
                          // : category.checkedList?.length == 0
                          //     ? SizedBox()
                          //     : CategoryView();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Event',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            // Add space between the text and the line
                            Flexible(
                              child: Container(
                                height: 2.0,
                                // Height of the line
                                width: double.infinity,
                                // The line should take full width available
                                color: Colors.green, // Color for the line
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border(
                              left: BorderSide(
                                  color: Colors.green,
                                  width: 9), // The colored line
                            ),
                          ),
                          child: const ListTile(
                            isThreeLine: true,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Online meeting',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('April 11, 2022',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                        ' Tempor feugiat sapien malesuada in at sem cursus aliquam'
                                        ' scelerisque.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300)),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Start time: 09:30'),
                                    Text(
                                      'End time: indefinite',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            border: Border(
                              left: BorderSide(
                                  color: Colors.green,
                                  width: 9), // The colored line
                            ),
                          ),
                          child: const ListTile(
                            isThreeLine: true,
                            title: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Online meeting',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                Text('April 11, 2022',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                                        ' Tempor feugiat sapien malesuada in at sem cursus aliquam'
                                        ' scelerisque.',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300)),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('Start time: 09:30'),
                                    Text(
                                      'End time: indefinite',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, request user to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time user needs to manually enable them in the app settings.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can continue accessing the position of the device.
    // Get the current location of the device.
    return await Geolocator.getCurrentPosition();
  }
}
