import 'package:flutter/cupertino.dart';

class ChangePasscodeRequestBody {
  String oldPasscode;
  String newPasscode;

  ChangePasscodeRequestBody(
      {@required this.oldPasscode, @required this.newPasscode});
}
