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
      isDefaultAction: isDefaultAction ?? false,
      isDestructiveAction: isDestructiveAction ?? false,
      //TODO: Enable custom text style for cupertino if we will be able to customize its background color
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
    bool fullyCapitalizedForMaterial,
  }) {
    return TextButton(
      child: Text(
        (fullyCapitalizedForMaterial == null ||
                fullyCapitalizedForMaterial == true)
            ? label.toUpperCase()
            : label,
        style: textStyle?.copyWith(
              color:
                  (isDestructiveAction == null || isDestructiveAction == false)
                      ? null
                      : (destructiveColor ?? Colors.red[600]),
            ) ??
            TextStyle(
              fontSize: 15,
              color:
                  (isDestructiveAction == null || isDestructiveAction == false)
                      ? Colors.lightBlue[400]
                      : (destructiveColor ?? Colors.red[600]),
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
