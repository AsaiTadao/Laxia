import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/generated/L10n.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/diary/diary_sub_model.dart';
import 'package:laxia/models/m_user.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/counsel_detail.dart';
import 'package:laxia/views/pages/main/contribution/diary_detail.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/pages/main/mypage/fix_profile_page.dart';
import 'package:laxia/views/pages/main/mypage/follower_list_page.dart';
import 'package:laxia/views/pages/main/mypage/following_list_page.dart';
import 'package:laxia/views/pages/main/mypage/invite_page.dart';
import 'package:laxia/views/pages/main/mypage/point_page.dart';
import 'package:laxia/views/pages/main/mypage/setting_page.dart';
import 'package:laxia/views/widgets/counseling_card.dart';
import 'package:laxia/views/widgets/diray_card.dart';
import 'package:laxia/views/widgets/indicator.dart';
import 'package:laxia/views/widgets/question_card.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class Mypage extends StatefulWidget {
  const Mypage({Key? key}) : super(key: key);

  @override
  _MypageState createState() => _MypageState();
}

class _MypageState extends State<Mypage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
   bool isfirst=true;
   bool isloading = true;
    final _con = AuthController();
    late Me myInfo;
  late UserProvider userProperties;
Future<void> getMe() async {
    try {
      final me = await _con.getMe();
      // print(me);
      if (me.id != 0) {
        setState(() {
          myInfo = me;
          isloading = false;
        });
        userProperties.setMe(me);
      }
    } catch (e) {
      print(e.toString());
      setState(() {
      });
    }
  }
  @override
  initState() {
    getMe();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  //   for (int i = 0; i < counseling_list.length; i++)
  //     setState(() {
  //       mid.add(counseling_list[i]);
  //     });
  //   for (int i = 0; i < question_list.length; i++)
  //     setState(() {
  //       nid.add(question_list[i]);
  //     });
  // }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userProperties = Provider.of<UserProvider>(context, listen: true);
    // if(isfirst==true){
    //   getMe();
    //   setState(() {
    //     isfirst=false;
    //   });
    // }
    // print(userProperties.getMe.diaries);
    return !isloading
    ? Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          myInfo.nickname!,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            
            color: Helper.titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
            onPressed: () {
              userProperties.setCurrentPageIndex(0);
              Navigator.of(context).pushNamed('/Pages');
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Helper.titleColor,
              size: 30,
            )),
        elevation: 0,
      ),
      body: Container(
        // margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: NestedScrollView(
          headerSliverBuilder: _silverBuilder,
          body: ListView(
            children: <Widget>[
              // _buildTabBar(),
              _buildTabView()
            ],
          ),
        ),
      ),
    )
    : Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ));
  }

  TabBar _buildTabBar() {
    return TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2.0,
        labelColor: Helper.titleColor,
        unselectedLabelColor: Helper.unSelectTabColor,
        labelPadding: EdgeInsets.only(left: 8, top: 4, right: 8, bottom: 0),
        indicatorPadding: EdgeInsets.only(bottom: 0, right: -3, left: -3),
        indicator: CircleTabIndicator(color: Helper.mainColor, radius: 20),
        tabs: [
          Tab(
            child: Text(
              "??????",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                
              ),
            ),
          ),
          Tab(
            child: Text(
              "???????????????",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                
              ),
            ),
          ),
          Tab(
            child: Text(
              "??????",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                
              ),
            ),
          )
        ]);
  }

  Widget _buildTabView() {
    return Container(
      height: 1000,
      child: TabBarView(
        controller: _tabController,
        children: [
          buildDiaryPage(myInfo.diaries!),
          buildCounselingPage(myInfo.counselings!),
          buildQuestionPage(myInfo.favorite_questions!)
        ],
      ),
    );
  }

  Widget buildDiaryPage(List<Diary_Sub_Model> mid) {
    return Container(
      color: Helper.bodyBgColor,
      height: 640,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: mid.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Diary_Card(
                      avator:
                          mid[index].patient_photo == null
                              ? "http://error.png"
                              : mid[index].patient_photo!,
                      check: mid[index].doctor_name == null
                          ? ""
                          : mid[index].doctor_name!,
                      image2: mid[index].after_image == null
                          ? "http://error.png"
                          : mid[index].after_image!,
                      image1:
                          mid[index].before_image == null
                              ? "http://error.png"
                              : mid[index].before_image!,
                      eyes: mid[index].views_count == null
                          ? ""
                          : mid[index].views_count!
                              .toString(),
                      clinic: mid[index].clinic_name == null
                          ? ""
                          : mid[index].clinic_name!,
                      name: mid[index].patient_nickname ==
                              null
                          ? ""
                          : mid[index].patient_nickname!,
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Diary_Detail(
                                      isMyDiary: true, index: mid[index].id,
                                    ))
                        );
                      },
                      price: mid[index].price == null
                          ? ""
                          : mid[index].price.toString(),
                      sentence:
                          mid[index].doctor_name == null
                              ? ""
                              : mid[index].doctor_name!,
                      type: mid[index].doctor_name == null
                          ? ""
                          : mid[index].doctor_name!,
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }

  Widget buildCounselingPage(List<Counceling_Sub_Model> mid) {
    return Container(
      height: 640,
      color: Helper.bodyBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
                builder: (context, BoxConstraints viewportConstraints) {
              return ListView.builder(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  itemCount: mid.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Counseling_Card(
                      hearts: mid[index].likes_count ==
                              null
                          ? ""
                          : mid[index].likes_count!
                              .toString(),
                      chats: mid[index].comments_count ==
                              null
                          ? ""
                          : mid[index].comments_count
                              .toString(),
                      avator: mid[index].patient_photo ==
                              null
                          ? "http://error.png"
                          : mid[index].patient_photo!,
                      check: mid[index].doctor_name ==
                              null
                          ? ""
                          : mid[index].doctor_name!,
                      images:mid[index].media_self!,
                      eyes: mid[index].views_count ==
                              null
                          ? ""
                          : mid[index].views_count!
                              .toString(),
                      name: mid[index].patient_nickname ==
                              null
                          ? ""
                          : mid[index].patient_nickname!,
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CounselDetail(
                                      isMyDiary: true, index: mid[index].id,
                                    )));
                      },
                      sentence:
                          mid[index].content == null
                              ? ""
                              : mid[index].content!,
                      type:
                          mid[index].categories!,
                      clinic: mid[index].clinic_name ==
                              null
                          ? ""
                          : mid[index].clinic_name!,
                    );
                  });
            }),
          ),
        ],
        
      ),
    );
  }

  Widget buildQuestionPage(List<Question_Sub_Model> mid) {
    return Container(
      height: 640,
      color: Helper.bodyBgColor,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, BoxConstraints viewportConstraints) {
                return ListView.builder(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                    itemCount: mid.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Question_Card(
                        isanswer: mid[index].answers.isNotEmpty,
                        hearts: mid[index].likes_count==null?"":mid[index].likes_count!.toString(),
                        chats: mid[index].comments_count==null?"":mid[index].comments_count.toString(),
                        avator:mid[index].owner!.photo==null?"http://error.png": mid[index].owner!.photo!,
                        images: mid[index].medias!,
                        eyes: mid[index].views_count==null?"":mid[index].views_count!.toString(),
                        name:mid[index].owner!.name==null?"": mid[index].owner!.name!,
                        onpress: () { 
                             Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuestionDetail(
                                        isMyDiary: true, index: mid[index].id,
                                      )));
                          //Navigator.of(context).pushNamed("/QuestionDetail");
                        },
                        sentence:mid[index].content==null?"": mid[index].content!,
                        type:mid[index].categories!,
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _silverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverAppBar(
        elevation: 0,
        expandedHeight: 285,
        floating: true,
        pinned: false,
        automaticallyImplyLeading: false,
        backgroundColor: Helper.whiteColor,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: Helper.whiteColor,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15.0, left: 16.0, right: 16.0, bottom: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            myInfo.photo!,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  myInfo.name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )),
                          ),
                          OutlinedButton(
                            
                              onPressed: () async {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             FixProfilePage()));


                                await showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                  ),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return FixProfilePage();
                                    // return Container(
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.white,
                                    //     borderRadius: BorderRadius.only(
                                    //       topLeft: Radius.circular(10.0),
                                    //       topRight: Radius.circular(10.0),
                                    //     )
                                    //   ),
                                    //   child: FixProfilePage());
                                  },
                                  isScrollControlled: true,
                                );
                                setState(() {
                                  isloading=true;
                                });
                                getMe();
                                // print("object");
                              },
                              style: OutlinedButton.styleFrom(
                                splashFactory: NoSplash.splashFactory,
                                shadowColor: Colors.transparent,
                                minimumSize: Size.zero,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                                  shape: StadiumBorder(),
                                  side: BorderSide(
                                      width: 1, color: Helper.mainColor)),
                              child: Text(
                                "??????",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  
                                  color: Helper.mainColor,
                                ),
                              )),
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowingListPage()));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                                // height: 24,
                                // width: 24,
                                child: Text(
                                  myInfo.followsCount.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                child: Text(
                              "????????????",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowerListPage()));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                                // height: 24,
                                // width: 24,
                                child: Text(
                                  myInfo.followersCount
                                      .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    
                                    color: Helper.titleColor,
                                  ),
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                child: Text(
                              "???????????????",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            myInfo.intro!,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.justify,
                            maxLines: 4,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              height: 1.3,
                              color: Helper.titleColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Color.fromARGB(255, 210, 210, 212))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "??????????????????",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            
                            color: Color.fromARGB(255, 18, 18, 18),
                          ),
                        ),
                        Expanded(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${myInfo.point} p",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                
                                color: Color.fromARGB(255, 18, 18, 18),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right_sharp),
                              color: Helper.titleColor,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PointPage()));
                              },
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.only(
                        top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Color.fromARGB(255, 210, 210, 212))),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0)),
                                  ),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) {
                                    return InvitePage(text: myInfo.uniqueId.toString());
                                  },
                                  isScrollControlled: true,
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.supervisor_account,
                                    color: Helper.titleColor,
                                    size: 15
                                  ),
                                  SizedBox(height: 0),
                                  Text(
                                    "????????????",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Helper.titleColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            width: 20,
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SettingPage()));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.settings,
                                    color: Helper.titleColor,
                                    size: 15,
                                  ),
                                  Text(
                                    "??????",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Helper.titleColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SliverPersistentHeader(
          pinned: true, delegate: _SliverAppBarDelegate(_buildTabBar()))
    ];
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Container(
      color: Helper.whiteColor,
      child: _tabBar,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
