import 'package:trendoapp/api/common/exception/custom_exceptions.dart';
import 'package:trendoapp/constants/app_messages.dart';

import 'exception_type.dart';

class ExceptionHelper {
  Exception handleExceptions(ExceptionType type) {
    switch (type) {
      case ExceptionType.NetworkException:
        return NetworkException(AppMessages.no_internet_msg);
        break;
      case ExceptionType.TokenExpiredException:
        return TokenExpiredException(AppMessages.token_expired_text);
        break;
      default:
        return HttpException(AppMessages.something_went_wrong_msg);
    }
  }
}
