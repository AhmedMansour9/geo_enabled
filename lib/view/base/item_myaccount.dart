import 'package:flutter/material.dart';
import 'package:geo_enabled/localization/language_constrants.dart';
import 'package:geo_enabled/provider/localization_provider.dart';
import 'package:geo_enabled/utill/routes.dart';
import 'package:geo_enabled/utill/styles.dart';
import 'package:provider/provider.dart';

class ItemMyAccount extends StatelessWidget {
  final String? title;
  String? leadIcon;
  final String? leadIconAr;
  final String route;
  bool? hasIconArabic;

  ItemMyAccount(
      {this.title,
      this.leadIcon,
      required this.route,
      this.hasIconArabic = false,
      this.leadIconAr});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Image.asset(
                Provider.of<LocalizationProvider>(context, listen: false)
                        .locale
                        .languageCode
                        .contains('ar')
                    ? hasIconArabic!
                        ? leadIconAr!
                        : leadIcon!
                    : leadIcon!,
                width: 25,
                height: 25,
                color: Colors.black),
            SizedBox(
              width: 20,
            ),
            Text(getTranslated('$title', context),
                style: medium.copyWith(fontSize: 13)),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

class SpaceMyAccount extends StatelessWidget {
  const SpaceMyAccount();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Divider(
          height: 1,
          color: Colors.black12,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
