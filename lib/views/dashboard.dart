import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/appointment/appointment.dart';
import 'package:laxia/views/pages/main/favorite/favorite.dart';
import 'package:laxia/views/pages/main/home/home.dart';
import 'package:laxia/views/widgets/bottom_nav_widget.dart';
import 'package:laxia/views/pages/main/mypage/mypage.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class DashboardScreen extends StatefulWidget {
  dynamic currentTab;
  Widget currentPage = HomeScreen();
  DashboardScreen({Key? key, this.currentTab}) {
    currentTab = 0;
  }

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // int? _currentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _currentIndex = widget.currentTab as int;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Helper.whiteColor.withOpacity(0),
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Helper.whiteColor.withOpacity(0),
    ));
    final _pageController = PageController(initialPage: 0);
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Helper.whiteColor,
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (value) => {userProperties.setCurrentPageIndex(value)},
        children: [
          HomeScreen(),
          Appointment(id: userProperties.currentMe.userId),
          SizedBox(
            width: 20,
          ),
          FavoriteScreen(),
          Mypage(),
        ],
      ),
      bottomNavigationBar: BottomNav(
          currentIndex: userProperties.currentPageIndex,
          pageController: _pageController),
    );
  }
}
