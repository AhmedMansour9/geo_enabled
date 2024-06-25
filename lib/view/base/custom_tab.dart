import 'package:flutter/material.dart';
import 'package:geo_enabled/utill/color_resources.dart';
import 'package:geo_enabled/utill/styles.dart';
import 'package:provider/provider.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class CustomTabItem extends StatelessWidget {
  CustomTabItem(
      {this.uniqueKey,
      this.selected,
      this.imagePath,
      this.isShowCart,
      this.title,
      this.callbackFunction,
      this.textColor,
      this.iconColor});

  final UniqueKey? uniqueKey;
  final String? title;
  final String? imagePath;
  final bool? selected;
  bool? isShowCart = false;
  final Function(UniqueKey uniqueKey)? callbackFunction;
  final Color? textColor;
  final Color? iconColor;

  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   height: double.infinity,
          //   width: double.infinity,
          //   child: AnimatedAlign(
          //       duration: Duration(milliseconds: ANIM_DURATION),
          //       alignment: Alignment(0, (selected) ? TEXT_ON : TEXT_OFF),
          //       child: Padding(
          //         padding: const EdgeInsets.all(20.0),
          //         child: Text(
          //           title,
          //           overflow: TextOverflow.ellipsis,
          //           maxLines: 1,
          //         ),
          //       )),
          // ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, (selected!) ? ICON_OFF : ICON_ON),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: ANIM_DURATION),
                opacity: (selected!) ? ALPHA_OFF : ALPHA_ON,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [


                    IconButton(

                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      padding: const EdgeInsets.all(0),
                      alignment: const Alignment(0, 0),
                      icon: Image.asset(
                        '',
                        color: iconColor, // Apply color if needed, remove if not.
                        // Fit as needed, or remove for the default value.
                        fit: BoxFit.contain,
                      ),

                      onPressed: () {
                        callbackFunction!(uniqueKey!);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}


