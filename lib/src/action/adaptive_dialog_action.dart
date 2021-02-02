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

  Widget convertToCupertinoDialogAction(
      BuildContext context, String routeName) {
    return CupertinoDialogAction(
      child: Text(label),
      isDefaultAction: isDefaultAction,
      isDestructiveAction: isDestructiveAction,
      //TODO: Enable it after background customization
      //textStyle: textStyle ?? TextStyle(),
      onPressed: () {
        if (onPressed != null) onPressed();
        //Pops this route
        Navigator.of(context).popUntil((r) => r.settings.name != routeName);
      },
    );
  }

  Widget convertToMaterialDialogAction({
    @required BuildContext context,
    @required String routeName,
    Color destructiveColor,
    bool fullyCapitalizedForMaterial = false,
  }) {
    return TextButton(
      child: Text(
        fullyCapitalizedForMaterial ? label.toUpperCase() : label,
        style: textStyle?.copyWith(
              color: isDestructiveAction
                  ? (destructiveColor ?? Colors.red[600])
                  : null,
            ) ??
            TextStyle(
              fontSize: 15,
              color: isDestructiveAction
                  ? (destructiveColor ?? Colors.red[600])
                  : Colors.lightBlue[400],
            ),
      ),
      onPressed: () {
        if (onPressed != null) onPressed();
        //Pops this route
        Navigator.of(context).popUntil((r) => r.settings.name != routeName);
      },
    );
  }
}
