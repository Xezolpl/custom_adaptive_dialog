import 'package:custom_adaptive_dialog/src/action/adaptive_dialog_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'adaptive_dialog.dart';

///Returns class with customized cupertino dialog. Show it by [show()] method or hide by [hide()];
class CustomMaterialDialog implements IAdaptiveDialog {
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

  ///Is dialog dismissible by pressing free space around dialog - *default true*
  final bool barrierDismissible;

  ///Whether to center texts (does not work for customTitle and customBody) *default false*
  final bool centerTexts;

  ///Specific route name to operate on that route by Navigator (popUntil, etc.) *default unique by uuid*
  final String routeName;

  ///Fully capitalized actions *default true*
  final bool fullyCapitalized;

  ///Custom destructive color *default Colors.red[600]*
  final Color destructiveColor;

  ///Custom background color *default based on theme*
  final Color backgroundColor;

  ///Custom border radius *default BorderRadius.circular(4)*
  final BorderRadius borderRadius;

  CustomMaterialDialog(
      {this.title,
      this.message,
      this.customTitle,
      this.customBody,
      this.actions,
      this.barrierDismissible,
      this.centerTexts,
      this.fullyCapitalized,
      this.destructiveColor,
      this.backgroundColor,
      this.borderRadius,
      String routeName})
      : this.routeName = routeName ?? Uuid().v4();

  ///Show the dialog by [showDialog]
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

  ///Hide the dialog by [Navigator.pop] specifing dialog's route name.
  ///WARNING: If you've set same route name for many dialogs then all the dialogs
  ///with that [routeName] will be popped
  @override
  void hide(BuildContext context) {
    return Navigator.of(context).popUntil((r) => r.settings.name != routeName);
  }
}
