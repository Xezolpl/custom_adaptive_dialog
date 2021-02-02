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
  final String bodyText;
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
      this.bodyText,
      this.customTitle,
      this.customBody,
      this.actions,
      this.backgroundColor,
      this.centerTexts = false,
      this.barrierDismissible = false,
      this.fullyCapitalized = true,
      this.destructiveColor,
      this.borderRadius,
      this.routeName})
      : _dialogInstance = style.isCupertinoStyle()
            ? CustomCupertinoDialog(
                title: title,
                bodyText: bodyText,
                customTitle: customTitle,
                actions: actions == null
                    ? null
                    : actions
                        .map((a) => a.convertToCupertinoDialogAction())
                        .toList(),
                customBody: customBody,
                centerTexts: centerTexts,
                barrierDismissible: barrierDismissible,
                routeName: routeName)
            : CustomMaterialDialog(
                title: title,
                bodyText: bodyText,
                customTitle: customTitle,
                actions: actions == null
                    ? null
                    : actions
                        .map((a) => a.convertToMaterialDialogAction(
                            destructiveColor: destructiveColor,
                            fullyCapitalizedForMaterial: fullyCapitalized))
                        .toList(),
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
