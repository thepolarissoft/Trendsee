import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:trendoapp/constants/app_images.dart';
import 'package:trendoapp/constants/app_routes.dart';
import 'package:trendoapp/constants/base_color.dart';
import 'package:trendoapp/providers/filter_provider.dart';
import 'package:trendoapp/utils/notification_utils.dart';
import 'home_screen.dart';
import 'standard_user_profile_screen.dart';
import 'business_liked_screen.dart';
import 'search_by_business_screen.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Widget> listofWidgets = <Widget>[
    HomeScreen(),
    SearchByBusinessScreen(),
    BusinessLikedScreen(),
    StandardUserProfileScreen(),
  ];
  PageController pageController = new PageController(initialPage: 0);

  int selectedIndex = 0;
  // List<bool> isSelectedList = [true, false, false, false];

  @override
  void initState() {
    NotificationUtils().saveUserTokenForNotification(context);
    Provider.of<FilterProvider>(context, listen: false).selectedMetropolitanCityInfo = "";
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      // for (int i = 0; i < isSelectedList.length; i++) {
      //   if (selectedIndex == i) {
      //     isSelectedList[i] = true;

      //   } else {
      //     isSelectedList[i] = false;
      //   }
      // }
      print("selectedIndex-->> $selectedIndex");
    });
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
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
              // appBar: AppBar(
              //   title: PreferredSize(
              //     preferredSize: Size.fromHeight(120),
              //     child: Container(
              //       color: Colors.green,
              //     ),
              //   ),
              // ),
              extendBody: true,
              // backgroundColor: BaseColor.pure_white_color,
              backgroundColor: Colors.transparent,
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
                      blurRadius: 8,
                    ),
                  ],
                ),
                // borderRadius: BorderRadius.only(
                //   topRight: Radius.circular(40),
                //   topLeft: Radius.circular(40),
                // ),
                child: Container(
                  // decoration: BoxDecoration(
                  //   color: BaseColor.pure_white_color,
                  //   borderRadius: BorderRadius.only(
                  //     topRight: Radius.circular(25),
                  //     topLeft: Radius.circular(25),
                  //   ),
                  // ),
                  padding: EdgeInsets.all(4),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          selectedIndex == 0 ? AppImages.ic_tab_home_filled : AppImages.ic_tab_home,
                          height: 24,
                          width: 24,
                        ),
                        label: "",
                        // ignore: deprecated_member_use
                        // title: Text(""),
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          margin: EdgeInsets.only(right: 30),
                          child: Image.asset(
                            selectedIndex == 1 ? AppImages.ic_tab_search_filled : AppImages.ic_tab_search,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        label: "",
                        // ignore: deprecated_member_use
                        // title: Text(""),
                      ),
                      BottomNavigationBarItem(
                        icon: Container(
                          margin: EdgeInsets.only(left: 30),
                          child: Image.asset(
                            selectedIndex == 2 ? AppImages.thumbs_up_filled : AppImages.thumbs_up,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        label: "",
                        // ignore: deprecated_member_use
                        // title: Text(""),
                      ),
                      BottomNavigationBarItem(
                        icon: Image.asset(
                          selectedIndex == 3 ? AppImages.ic_tab_more_filled : AppImages.ic_tab_more,
                          height: 24,
                          width: 24,
                        ),
                        label: "",
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
                    selectedIconTheme: IconThemeData(color: BaseColor.pure_white_color),
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              floatingActionButton: GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, AppRoutes.add_new_checkin_route_name);
                  Navigator.pushNamed(context, AppRoutes.select_location_for_add_new_checkin_route_name);
                },
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      gradient: LinearGradient(colors: [BaseColor.pure_white_color, BaseColor.pure_white_color]),
                      boxShadow: [BoxShadow(color: BaseColor.shadow_color, blurRadius: 5)]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.without_fire_logo,
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
              body: listofWidgets.elementAt(selectedIndex)),
        ),
      ),
    );
  }
}
