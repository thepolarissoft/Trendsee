import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/media_page.dart';

class MediaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(MediaPage());
  }
}
