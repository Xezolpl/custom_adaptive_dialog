import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'adaptive_dialog.dart';

class CustomMaterialDialog implements IAdaptiveDialog {
  final String title;
  final String bodyText;
  final Widget customTitle;
  final Widget customBody;
  final List<Widget> actions;
  final bool barrierDismissible;
  final Color backgroundColor;
  final bool centerTexts;
  final BorderRadius borderRadius;
  final String routeName;

  CustomMaterialDialog(
      {this.title,
      this.bodyText,
      this.customTitle,
      this.customBody,
      this.actions,
      this.barrierDismissible = false,
      this.centerTexts = false,
      this.backgroundColor,
      this.borderRadius,
      String routeName})
      : this.routeName = routeName ?? Uuid().v4();

  @override
  Future<void> show(BuildContext context) async {
    //Text align for all the texts
    TextAlign textAlign = centerTexts ? TextAlign.center : TextAlign.start;

    return await showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        routeSettings:
            routeName == null ? null : RouteSettings(name: routeName),
        builder: (context) {
          return AlertDialog(
            title: customTitle ??
                (title == null
                    ? null
                    : Container(
                        child: Text(
                          title,
                          textAlign: textAlign,
                        ),
                      )),
            content: customBody ??
                (bodyText == null
                    ? null
                    : Text(
                        bodyText,
                        textAlign: textAlign,
                      )),
            actions: actions,
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(4.0),
            ),
          );
        });
  }

  @override
  void hide(BuildContext context) {
    return Navigator.of(context).popUntil((r) => r.settings.name != routeName);
  }
}