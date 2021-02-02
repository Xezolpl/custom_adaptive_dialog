import 'package:custom_adaptive_dialog/src/action/adaptive_dialog_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'adaptive_dialog.dart';

class CustomMaterialDialog implements IAdaptiveDialog {
  final String title;
  final String message;
  final Widget customTitle;
  final Widget customBody;
  final List<AdaptiveDialogAction> actions;
  final bool barrierDismissible;
  final bool centerTexts;
  final bool fullyCapitalized;
  final Color destructiveColor;
  final Color backgroundColor;
  final BorderRadius borderRadius;
  final String routeName;

  CustomMaterialDialog(
      {this.title,
      this.message,
      this.customTitle,
      this.customBody,
      this.actions,
      this.barrierDismissible = false,
      this.centerTexts = false,
      this.fullyCapitalized = false,
      this.destructiveColor,
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
                (message == null
                    ? null
                    : Text(
                        message,
                        textAlign: textAlign,
                      )),
            actions: actions == null
                ? null
                : actions
                    .map((a) => a.convertToMaterialDialogAction(
                        context: context,
                        routeName: routeName,
                        destructiveColor: destructiveColor,
                        fullyCapitalizedForMaterial: fullyCapitalized))
                    .toList(),
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
