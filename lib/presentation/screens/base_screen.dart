import 'package:flutter/material.dart';



class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    super.initState();
    // ConnectionUtils(context: context).init();
  }

  @override
  void dispose() {
    super.dispose();
    // ConnectionUtils(context: context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void setInternetConnectionValue(bool value) {
    // setState(() {
    //   isInterenet = value;
    // });
  }
}