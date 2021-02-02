import 'package:custom_adaptive_dialog/src/action/adaptive_dialog_action.dart';
import 'package:custom_adaptive_dialog/src/core/dialog_style.dart';
import 'package:custom_adaptive_dialog/src/core/indicator_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'adaptive_dialog.dart';

abstract class AdaptiveDialogs {
  static IAdaptiveDialog getLoadingAdaptiveDialog({
    Color backgroundColor,
    BorderRadius borderRadius,
    bool centerTexts = false,
    String title,
    String loadingMessage,
    Widget customTitle,
    Widget customLoadingText,
    DialogStyle style,
    String routeName,
    IndicatorPosition indicatorPossition = IndicatorPosition.left,
  }) {
    Widget indicator = style.isCupertinoStyle()
        ? CupertinoActivityIndicator(
            radius: 12,
          )
        : CircularProgressIndicator();
    Widget body = indicator;
    Widget loadingTextWidget = customLoadingText ??
        Text(loadingMessage, style: TextStyle(color: Colors.grey[600]));

    switch (indicatorPossition) {
      case IndicatorPosition.left:
        {
          body = Row(
            children: [
              indicator,
              SizedBox(width: 16),
              Expanded(child: loadingTextWidget),
            ],
          );
          break;
        }
      case IndicatorPosition.right:
        {
          body = Row(
            children: [
              Expanded(child: loadingTextWidget),
              SizedBox(width: 16),
              indicator,
            ],
          );
          break;
        }
      case IndicatorPosition.bottom:
        {
          body = Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              loadingTextWidget,
              SizedBox(height: 4),
              indicator,
            ],
          );
          break;
        }
      default:
        break;
    }
    return AdaptiveDialog(
      title: title,
      customTitle: customTitle,
      barrierDismissible: false,
      centerTexts: centerTexts,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      customBody:
          Padding(padding: const EdgeInsets.fromLTRB(0, 2, 4, 0), child: body),
      routeName: routeName,
      style: style,
    );
  }

  static IAdaptiveDialog getOkAdaptiveDialog({
    String title,
    String message,
    Widget customTitle,
    Widget customBody,
    //Other customizations
    Color backgroundColor,
    String routeName,
    DialogStyle style,
    BorderRadius borderRadius,
    bool centerTexts = false,
    bool barrierDismissible = true,
    bool fullyCapitalized = true,
    //Ok button
    @required String okLabel,
    TextStyle okTextStyle,
    Function() onOkPressed,
  }) {
    return AdaptiveDialog(
        title: title,
        customTitle: customTitle,
        message: message,
        customBody: customBody,
        barrierDismissible: barrierDismissible,
        centerTexts: centerTexts,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        routeName: routeName,
        style: style,
        fullyCapitalized: fullyCapitalized,
        actions: [
          AdaptiveDialogAction(
              label: okLabel,
              textStyle: okTextStyle,
              onPressed: onOkPressed,
              isDefaultAction: true)
        ]);
  }

  static IAdaptiveDialog getOkCancelAdaptiveDialog({
    String title,
    String message,
    Widget customTitle,
    Widget customBody,
    //Other customizations
    Color backgroundColor,
    String routeName,
    DialogStyle style,
    BorderRadius borderRadius,
    bool centerTexts = false,
    bool barrierDismissible = true,
    bool fullyCapitalized = true,
    //Ok button
    @required String okLabel,
    TextStyle okTextStyle,
    Function() onOkPressed,
    //Cancel button
    bool isCancelDestructive = false,
    @required String cancelLabel,
    TextStyle cancelTextStyle,
    Function() onCancelPressed,
  }) {
    return AdaptiveDialog(
        title: title,
        customTitle: customTitle,
        message: message,
        customBody: customBody,
        barrierDismissible: barrierDismissible,
        centerTexts: centerTexts,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        routeName: routeName,
        style: style,
        fullyCapitalized: fullyCapitalized,
        actions: [
          AdaptiveDialogAction(
              label: cancelLabel,
              textStyle: cancelTextStyle,
              onPressed: onCancelPressed,
              isDestructiveAction: isCancelDestructive),
          AdaptiveDialogAction(
              label: okLabel,
              textStyle: okTextStyle,
              onPressed: onOkPressed,
              isDefaultAction: true),
        ]);
  }
}
