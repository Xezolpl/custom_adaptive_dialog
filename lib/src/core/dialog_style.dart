import 'dart:io';

enum DialogStyle { adaptive, material, cupertino }

extension XDialogStyle on DialogStyle {
  bool isCupertinoStyle() {
    bool isIOSOrMac = (Platform.isIOS || Platform.isMacOS);
    if (this == null) {
      return isIOSOrMac;
    }
    return this == DialogStyle.cupertino ||
        (this == DialogStyle.adaptive && isIOSOrMac);
  }
}
