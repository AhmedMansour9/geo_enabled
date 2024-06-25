

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_enabled/utill/color_resources.dart';

class SliverAppBarTabDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  SliverAppBarTabDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  double get minExtent => child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}