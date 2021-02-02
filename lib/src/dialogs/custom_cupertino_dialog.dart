import 'package:custom_adaptive_dialog/src/action/adaptive_dialog_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive_dialog.dart';

class CustomCupertinoDialog implements IAdaptiveDialog {
  final String title;
  final String message;
  final Widget customTitle;
  final Widget customBody;
  final List<AdaptiveDialogAction> actions;
  final bool barrierDismissible;
  final bool centerTexts;
  final String routeName;

  CustomCupertinoDialog(
      {this.title,
      this.message,
      this.customTitle,
      this.customBody,
      this.actions,
      this.barrierDismissible,
      this.centerTexts,
      this.routeName});

  @override
  Future<void> show(BuildContext context) async {
    //Text align for all the texts
    TextAlign textAlign = TextAlign.center;

    //Show the dialog
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      routeSettings: routeName == null ? null : RouteSettings(name: routeName),
      builder: (context) {
        return CupertinoAlertDialog(
          title: customTitle ??
              (title == null
                  ? null
                  : Text(
                      title,
                      textAlign: textAlign,
                    )),
          content: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: customBody ??
                (message == null
                    ? null
                    : Column(
                        crossAxisAlignment: centerTexts
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            message,
                            textAlign: textAlign,
                          ),
                        ],
                      )),
          ),
          actions: actions == null
              ? []
              : actions
                  .map((a) =>
                      a.convertToCupertinoDialogAction(context, routeName))
                  .toList(),
          //TODO: Enable customization on IOS
          //backgroundColor: backgroundColor,
          //shape: RoundedRectangleBorder(
          //borderRadius: BorderRadius.circular(borderRadius),
          //),
        );
      },
    );
  }

  @override
  void hide(BuildContext context) {
    return Navigator.of(context).popUntil((r) => r.settings.name != routeName);
  }
}
