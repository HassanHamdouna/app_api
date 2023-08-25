import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RefreshWidget extends StatelessWidget {
  const RefreshWidget(
      {super.key,
      required this.child,
      required this.onRefresh,
      required this.keyRefresh});

  final Widget child;
  final Future Function() onRefresh;
  final GlobalKey<RefreshIndicatorState> keyRefresh;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? buildAndroidWidget() : buildIosWidget();
  }

  buildIosWidget() {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(key: keyRefresh,onRefresh: onRefresh,),
        SliverToBoxAdapter(
          child: child,
        )
      ],
    );
  }

  buildAndroidWidget() {
    return RefreshIndicator(onRefresh: onRefresh,key: keyRefresh,child: child,);
  }

}
