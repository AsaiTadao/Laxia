import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laxia/provider/pref_provider.dart';
import 'package:laxia/provider/search_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/home/search/searchresult.dart';
import 'package:laxia/views/pages/main/home/sub/home_case.dart';
import 'package:laxia/views/pages/main/home/sub/home_clinic.dart';
import 'package:laxia/views/pages/main/home/sub/home_counseling.dart';
import 'package:laxia/views/pages/main/home/sub/home_diary.dart';
import 'package:laxia/views/pages/main/home/sub/home_doctor.dart';
import 'package:laxia/views/pages/main/home/sub/home_menu.dart';
import 'package:laxia/views/pages/main/home/sub/home_question.dart';
import 'package:laxia/views/pages/main/home/sub/home_sub.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:laxia/views/widgets/tabbar.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  const HomeScreen({Key? key, this.parentScaffoldKey}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> tabMenus = [
    'ホーム',
    'メニュー',
    'クリニック',
    'ドクター',
    '日記',
    '症例',
    'カウセレポ',
    '質問',
  ];
  late TabController _tabController;
  bool isvisible=true,searchbarstate=true;
  TextEditingController filter = new TextEditingController();
  @override
  void initState() {
    _tabController = new TabController(length: 8, vsync: this);
        _tabController.addListener(() {
      if(_tabController.indexIsChanging){
        // print(_tabController.index.toString());
        if(_tabController.index!=0){
          setState(() {
            searchbarstate=false;
          });
        }else{
          setState(() {
            searchbarstate=true;
            //print("object");
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    PrefProvider prefyprovider =
        Provider.of<PrefProvider>(context, listen: true);
    SurGeryProvider surgeryprovider =
        Provider.of<SurGeryProvider>(context, listen: true);
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: true);
    tabMenus[0]="ホーム";
    if (userProperties.searchtext != "") {
          isvisible=true;
      tabMenus[0]="総合";
    }
    if(_tabController.index==0){
      filter.value=TextEditingValue(text: userProperties.searchtext);
    }
    //TextEditingController filter = new TextEditingController(text: userProperties.searchtext);
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SearchbarWidget(
              onchange: ()=>{
                //print(filter.value.text)
                if(filter.text==null){
                  userProperties.setSearchtext("")
                }else{
                  userProperties.setSearchtext(filter.text.toString())
                }
              },
              state: searchbarstate,
              filter: filter,
            ),
          ),
          Visibility(
            visible: isvisible,
            child: TabBarWidget(
              tabMenus: tabMenus,
              tabController: _tabController, 
              onpress: () {
                searchProvider.initSelected();
                prefyprovider.initSelected();
                surgeryprovider.initSelected();
              },
            ),
          ),
          userProperties.searchtext.isEmpty
              ? Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Home_Sub(isvisible: isvisible, onpress: () {  setState(() {
                        isvisible=!isvisible;
                      });},),
                      Home_Menu(),
                      Home_Clinic(),
                      Home_Doctor(),
                      Home_Diary(),
                      Home_Case(),
                      Home_Counseling(),
                      Home_Question(),
                    ],
                    controller: _tabController,
                  ),
                )
              : Expanded(
                  child:userProperties.completed?TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                     SearchResultAll(tabController: _tabController),
                      Home_Menu(),
                      Home_Clinic(),
                      Home_Doctor(),
                      Home_Diary(),
                      Home_Case(),
                      Home_Counseling(),
                      Home_Question(),
                    ],
                    controller: _tabController,
                  ):Container(),
                ),
        ],
      )),
    );
  }
}
