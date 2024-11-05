import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hotelautomationapp/constants/appcolor.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';

class AppScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Color? safeAreaColor;
  final PreferredSizeWidget? appBar;
  final bool extendBodyBehindAppBar;
  final bool isLoading;
  final Widget? floatingActionButton;
  final bool bottom;
  final  Future<bool> Function()? onWillPop;

  const AppScaffold(
      {super.key,
        required this.body,
        this.backgroundColor,
        this.bottomNavigationBar,
        this.drawer,
        this.appBar,
        this.safeAreaColor,
        this.endDrawer,
        this.extendBodyBehindAppBar = false,
        this.isLoading = false,
        this.onWillPop,
        this.bottom = true,
       this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: AppColor.darkScaffold,
        child: SafeArea(
          bottom: bottom,
          child: Stack(
            children: [
              Scaffold(
                endDrawerEnableOpenDragGesture: false,
                drawerEnableOpenDragGesture: false,
                endDrawer: endDrawer,
                extendBodyBehindAppBar: extendBodyBehindAppBar,
                resizeToAvoidBottomInset: true,
                appBar: appBar,
                body: body,
                bottomNavigationBar: bottomNavigationBar,
                drawer: drawer,
                backgroundColor: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
                extendBody: true,
                floatingActionButton: floatingActionButton,
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              ),
              isLoading ?   Center(child: SpinKitWaveSpinner(color: AppColor.appColor,waveColor: Color(0xFFF3E166),
              size: Dimensions.h_70)) : const SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
