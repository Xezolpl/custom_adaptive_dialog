import 'package:custom_adaptive_dialog/src/action/adaptive_dialog_action.dart';
import 'package:custom_adaptive_dialog/src/core/dialog_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_cupertino_dialog.dart';
import 'custom_material_dialog.dart';

abstract class IAdaptiveDialog {
  Future<void> show(BuildContext context);
  void hide(BuildContext context);
}

///Returns class with customized adaptive dialog. It will decide to be cupertino
///or material based on [style] or if its null - on Platform.
///Show the dialog by [show()] method or hide it by [hide()];
class AdaptiveDialog implements IAdaptiveDialog {
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

  ///Is dialog dismissible by pressing free space around dialog
  ///*default Material-true, Cupertino-false*
  final bool barrierDismissible;

  ///Whether to center texts (does not work for customTitle and customBody)
  ///*default Material-false, Cupertino-true*
  final bool centerTexts;

  ///Specific route name to operate on that route by Navigator (popUntil, etc.)
  ///*default unique by uuid*
  final String routeName;

  ///Capitalizes title and message for material style *default true*
  final bool fullyCapitalized;

  ///Custom destructive action color for material style *default Colors.red[600]*
  final Color destructiveColor;

  ///Border radius for material style *default BorderRadius.circular(4)*
  final BorderRadius borderRadius;

  ///Custom background color for material style *default based on style*
  final Color backgroundColor;

  ///If you want to use specific style (Cupertino/Material) no matter of Platform
  ///then specify that there
  final DialogStyle style;

  ///Instance of the dialog based on [style]
  final IAdaptiveDialog _dialogInstance;

  AdaptiveDialog(
      {this.style,
      this.title,
      this.message,
      this.customTitle,
      this.customBody,
      this.actions,
      this.backgroundColor,
      this.centerTexts,
      this.barrierDismissible,
      this.fullyCapitalized,
      this.destructiveColor,
      this.borderRadius,
      this.routeName})
      : _dialogInstance = style.isCupertinoStyle()
            ? CustomCupertinoDialog(
                title: title,
                message: message,
                customTitle: customTitle,
                actions: actions,
                customBody: customBody,
                centerTexts: centerTexts,
                barrierDismissible: barrierDismissible,
                routeName: routeName)
            : CustomMaterialDialog(
                title: title,
                message: message,
                destructiveColor: destructiveColor,
                fullyCapitalized: fullyCapitalized,
                customTitle: customTitle,
                actions: actions,
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                customBody: customBody,
                centerTexts: centerTexts,
                barrierDismissible: barrierDismissible,
                routeName: routeName);

  ///Show the adaptive dialog
  @override
  Future<void> show(BuildContext context) async {
    return await _dialogInstance.show(context);
  }

  ///Hide the adaptive dialog
  @override
  void hide(BuildContext context) async {
    return _dialogInstance.hide(context);
  }
}
