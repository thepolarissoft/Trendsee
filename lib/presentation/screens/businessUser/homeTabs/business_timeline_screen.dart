import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/presentation/screens/businessUser/homeTabs/business_home_screen.dart';
import 'package:trendoapp/presentation/screens/businessUser/homeTabs/business_profile_screen.dart';
import 'package:trendoapp/utils/notification_utils.dart';

class BusinessTimelineScreen extends StatefulWidget {
  // const BusinessTimelineScreen({Key key}) : super(key: key);

  @override
  _BusinessTimelineScreenState createState() => _BusinessTimelineScreenState();
}

class _BusinessTimelineScreenState extends State<BusinessTimelineScreen> {
  List<Widget> listofWidgets = <Widget>[
    BusinessHomeScreen(),
    BusinessProfileScreen(),
  ];
  PageController pageController = new PageController(initialPage: 0);
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      print("selectedIndex-->> $selectedIndex");
    });
  }

  @override
  void initState() {
          NotificationUtils().saveUserTokenForNotification(context);

    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Container(
        color: BaseColor.home_bg_color,
        child: Scaffold(
            backgroundColor: BaseColor.pure_white_color,
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(top: 6, left: 6, right: 6),
              decoration: BoxDecoration(
                  color: BaseColor.pure_white_color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: BaseColor.shadow_color.withOpacity(0.5),
                        blurRadius: 8)
                  ]),
              // borderRadius: BorderRadius.only(
              //   topRight: Radius.circular(40),
              //   topLeft: Radius.circular(40),
              // ),
              child: Padding(
                padding: EdgeInsets.all(4),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        selectedIndex == 0
                            ? AppImages.ic_tab_home_filled
                            : AppImages.ic_tab_home,
                        height: 24,
                        width: 24,
                      ),
                      // ignore: deprecated_member_use
                      // title: Text(""),
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        selectedIndex == 1
                            ? AppImages.ic_tab_more_filled
                            : AppImages.ic_tab_more,
                        height: 24,
                        width: 24,
                      ),
                      // ignore: deprecated_member_use
                      // title: Text(""),
                    ),
                  ],
                  selectedItemColor: BaseColor.btn_gradient_end_color1,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selectedIndex,
                  onTap: _onItemTapped,
                  elevation: 0,
                  backgroundColor: BaseColor.pure_white_color,
                  selectedIconTheme:
                      IconThemeData(color: BaseColor.pure_white_color),
                ),
              ),
            ),
            body: listofWidgets.elementAt(selectedIndex)),
      ),
    );
  }
}
