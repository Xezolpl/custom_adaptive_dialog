import 'package:custom_adaptive_dialog/src/action/adaptive_dialog_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive_dialog.dart';

///Returns class with customized cupertino dialog. Show it by [show()] method or hide by [hide()];
class CustomCupertinoDialog implements IAdaptiveDialog {
  ///Title string with default TextStyle, will be omitted if [customTitle!=null]
  final String title;

  ///Message string with default TextStyle, will be omitted if [customBody!=null]
  final String message;

  ///Custom title widget in place of title
  final Widget customTitle;

  ///Custom body widget in place of content
  final Widget customBody;

  ///Bottom clickable actions (buttons)
  final List<AdaptiveDialogAction> actions;

  ///Is dialog dismissible by pressing free space around dialog - *default false*
  final bool barrierDismissible;

  ///Whether to center texts (does not work for customTitle and customBody) *default false*
  final bool centerTexts;

  ///Specific route name to operate on that route by Navigator (popUntil, etc.) *default unique by uuid*
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

  ///Show the dialog by [showCupertinoDialog]
  @override
  Future<void> show(BuildContext context) async {
    //Text align for all the texts
    TextAlign textAlign = (centerTexts == null || centerTexts == true)
        ? TextAlign.center
        : TextAlign.start;

    //Show the dialog
    return await showCupertinoDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
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
                    ? SizedBox.shrink()
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

  ///Hide the dialog by [Navigator.pop] specifing dialog's route name.
  ///WARNING: If you've set same route name for many dialogs then all the dialogs
  ///with that [routeName] will be popped
  @override
  void hide(BuildContext context) {
    return Navigator.of(context).popUntil((r) => r.settings.name != routeName);
  }
}
