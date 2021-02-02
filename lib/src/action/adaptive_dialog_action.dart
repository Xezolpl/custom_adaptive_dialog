import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveDialogAction {
  const AdaptiveDialogAction({
    @required this.label,
    @required this.onPressed,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
    this.textStyle,
  });

  final String label;
  final Function() onPressed;

  /// Make font weight to bold (Only works for CupertinoStyle).
  final bool isDefaultAction;

  /// Make font color to destructive/error color(red) (e.g. delete).
  final bool isDestructiveAction;

  final TextStyle textStyle;

  Widget convertToCupertinoDialogAction() {
    return CupertinoDialogAction(
      child: Text(label),
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      //TODO: Enable it after background customization
      //textStyle: textStyle ?? TextStyle(),
      onPressed: onPressed ?? () {},
    );
  }

  Widget convertToMaterialDialogAction({
    @required Color destructiveColor,
    @required bool fullyCapitalizedForMaterial,
  }) {
    return TextButton(
      child: Text(
        fullyCapitalizedForMaterial ? label.toUpperCase() : label,
        style: textStyle?.copyWith(
              color: isDestructiveAction ? destructiveColor : null,
            ) ??
            TextStyle(
              fontSize: 15,
              color: isDestructiveAction
                  ? destructiveColor
                  : Colors.lightBlue[400],
            ),
      ),
      onPressed: onPressed ?? () {},
    );
  }
}
