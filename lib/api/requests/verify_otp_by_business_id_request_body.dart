import 'package:flutter/material.dart';

class VerifyOtpByBusinessIdRequestBody {
  int businessId;
  int otp;
  VerifyOtpByBusinessIdRequestBody(
      {@required this.businessId, @required this.otp});
}
