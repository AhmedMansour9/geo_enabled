// import 'package:flutter/material.dart';
// import 'package:hr_app/utill/images.dart';
// import 'package:hr_app/utill/routes.dart';
// import 'package:hr_app/view/base/menu_bar.dart';
// import 'package:provider/provider.dart';
//
// class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         color: Theme.of(context).primaryColor,
//         width: 1170,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               // child: InkWell(
//               //   onTap: () => Navigator.pushNamed(context, Routes.getMainRoute()),
//               //   child: Provider.of<SplashProvider>(context).baseUrls != null?  Consumer<SplashProvider>(
//               //       builder:(context, splash, child) => FadeInImage.assetNetwork(
//               //         placeholder: Images.placeholder_rectangle,
//               //         image:  '${splash.baseUrls?.restaurantImageUrl}/${splash.configModel?.restaurantLogo}',
//               //         width: 120, height: 80,
//               //         imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder_rectangle, width: 120, height: 80),
//               //       )): SizedBox(),
//               // ),
//             ),
//             MenuBar(),
//           ],
//         )
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size(double.maxFinite, 50);
// }
