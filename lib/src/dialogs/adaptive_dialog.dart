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

class AdaptiveDialog implements IAdaptiveDialog {
  final DialogStyle style;
  final String title;
  final String message;
  final Widget customTitle;
  final Widget customBody;
  final List<AdaptiveDialogAction> actions;
  final bool barrierDismissible;
  final String routeName;
  //Centers title and bodyText for material style
  final bool centerTexts;
  //Capitalizes title and bodyText for material style
  final bool fullyCapitalized;
  //Custom destructive action color for material style
  final Color destructiveColor;
  //Border radius for material style
  final BorderRadius borderRadius;
  //Custom background color for material style
  final Color backgroundColor;

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
                customTitle: customTitle,
                actions: actions,
                backgroundColor: backgroundColor,
                borderRadius: borderRadius,
                customBody: customBody,
                centerTexts: centerTexts,
                barrierDismissible: barrierDismissible,
                routeName: routeName);

  @override
  Future<void> show(BuildContext context) async {
    return await _dialogInstance.show(context);
  }

  @override
  void hide(BuildContext context) async {
    return _dialogInstance.hide(context);
  }
}
