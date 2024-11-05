import 'package:flutter/material.dart';
import 'package:hotelautomationapp/constants/fontsize.dart';
import 'package:intl/intl.dart';

class AppSwitch extends StatefulWidget {
  @required
  final bool value;
  final double width;

  @required
  final Function(bool) onChanged;
  final String textOff;
  final Color textOffColor;
  final String textOn;
  final Color textOnColor;
  final Color colorOn;
  final Color colorOff;
  final double textSize;
  final Duration animationDuration;
  final IconData iconOn;
  final IconData iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;
  final Color? iconBackColor;
  final double? height;

  const AppSwitch({super.key,
    this.value = false,
    this.width = 130,
    this.textOff = "Off",
    this.textOn = "On",
    this.textSize = 14.0,
    this.colorOn = Colors.green,
    this.colorOff = Colors.red,
    this.iconOff = Icons.flag,
    this.iconOn = Icons.check,
    this.animationDuration = const Duration(milliseconds: 600),
    this.textOffColor = Colors.white,
    this.textOnColor = Colors.white,
    required this.onTap,
    required this.onDoubleTap,
    required this.onSwipe,
    required this.onChanged, this.iconBackColor, this.height,
  });

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<AppSwitch>
    with SingleTickerProviderStateMixin {
  /// Late declarations
  late AnimationController animationController;
  late Animation<double> animation;
  late bool turnState;

  double value = 0.0;

  @override
  void dispose() {
    //Ensure to dispose animation controller
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;

    // Executes a function only one time after the layout is completed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        if (turnState) {
          animationController.forward();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //Color transition animation
    Color? transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        widget.onDoubleTap();
      },
      onTap: () {
        _action();
        widget.onTap();
      },
      onPanEnd: (details) {
        _action();
        widget.onSwipe();
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        width: widget.width,
        height: widget.height ?? Dimensions.h_30,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: isRTL(context)
                  ? Offset((-widget.width + 50) * value, 0)
                  : Offset((widget.width - 35) * value, 0),
              child: Transform.rotate(
                angle: 0,
                child: Container(
                  height: Dimensions.h_30,
                  width: Dimensions.h_30,
                  alignment: Alignment.center,
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle, color:   widget.iconBackColor ?? const Color(0xFF3E90F0)),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOff,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0),
                          child: Icon(
                            widget.iconOn,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}

bool isRTL(BuildContext context) {
  return Bidi.isRtlLanguage(Localizations.localeOf(context).languageCode);
}
