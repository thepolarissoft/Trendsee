import 'package:flutter/material.dart';
import 'package:trendoapp/global/view/global_view.dart';
import 'package:trendoapp/presentation/pages/common/my_all_check_ins_page.dart';

class MyAllCheckInsScreen extends StatelessWidget {
  const MyAllCheckInsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalView().safeAreaView(MyAllCheckInsPage());
  }
}
