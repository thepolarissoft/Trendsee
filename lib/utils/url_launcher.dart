import 'package:trendoapp/constants/app_messages.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  void launchUrl(String url) async {
    if (!(url.startsWith(AppMessages.http_text)) &&
        (!url.startsWith(AppMessages.https_text))) {
      url = AppMessages.http_text + url;
    }
    print("Launch url-> $url");
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void openEmail(String emailId, String subject) {
    String encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailId,
      query: encodeQueryParameters(<String, String>{'subject': subject}),
    );
    print("emailLaunchUri-> $emailLaunchUri");
    launch(emailLaunchUri.toString());
  }
}
