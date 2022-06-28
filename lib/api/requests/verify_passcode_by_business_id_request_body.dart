import 'package:flutter/material.dart';

class VerifyPasscodeByBusinessIdRequestBody {
  int businessId;
  int passcode;
  VerifyPasscodeByBusinessIdRequestBody(
      {@required this.businessId, @required this.passcode});
}
