import 'package:email_validator/email_validator.dart';

class ValidationUtils {
  // String validUrl = '';
  bool isEmailValidate(String email) {
    if (EmailValidator.validate(email)) {
      return true;
    } else {
      return false;
    }
  }

  bool isUrlValidate(String url) {
    // if (!url.startsWith("http")) {
    //   url = "http://" + url;
    // }
    // validUrl = url;
    // if (Uri.parse(url).isAbsolute) {
    //   return true;
    // } else {
    //   return false;
    // }
     var  validCharacters = RegExp(r'^[a-zA-Z0-9./:]+$');
    if (validCharacters.hasMatch(url)) {
      return true;
    } else {
      return false;
    }
  }
}
