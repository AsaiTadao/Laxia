import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/my_controller.dart';
import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/views/pages/main/mypage/following_card_widget.dart';

class FollowingListPage extends StatefulWidget {
  const FollowingListPage({Key? key}) : super(key: key);

  @override
  State<FollowingListPage> createState() => _FollowingListPageState();
}

class _FollowingListPageState extends State<FollowingListPage> {
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  List mid = [];
  late Follow follow_data;
  final MyController _con = MyController();
  Future<void> getFollows({required String page}) async {
    try {
      if (!isend) {
        if (!isloading) {
          setState(() {
            isexpanding = false;
          });
        }
        final mid = await _con.getFollows(page: page);
        setState(() {
          if (isloading) {
            follow_data = mid;
            isloading = false;
          } else {
            follow_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      isexpanding = true;
      isend = true;
      setState(() {
        print(e.toString());
      });
    }
  }

  Future<void> postTooglefollow(int index) async {
    try {
      final res =
          await _con.postTooglefollow(index: follow_data.data[index].id);
      if (res == true) {
        setState(() {
          follow_data.data.removeAt(index);
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    getFollows(page: page.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helper.whiteColor,
        shadowColor: Helper.whiteColor,
        title: Text(
          'フォロー中',
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Helper.titleColor,
              size: 30,
            )),
        elevation: 0,
      ),
      body: isloading
          ? Container(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            )
          : Container(
              child: follow_data.data.length != 0
                  ? Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: LayoutBuilder(builder:
                              (context, BoxConstraints viewportConstraints) {
                            return NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels ==
                                    scrollInfo.metrics.maxScrollExtent) {
                                  if (isexpanding) {
                                    getFollows(page: (page + 1).toString());
                                    setState(() {
                                      page += 1;
                                    });
                                  }
                                }
                                return true;
                              },
                              child: Column(children: [
                                ListView.builder(
                                  itemCount: follow_data.data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      child: FollowingCardWidget(
                                        photo: follow_data.data[index].photo!,
                                        name: follow_data.data[index].name!,
                                        nickname:
                                            follow_data.data[index].nickname!,
                                        onPress: () {
                                          postTooglefollow(index);
                                        },
                                      ),
                                    );
                                  },
                                  shrinkWrap: true,
                                  physics: AlwaysScrollableScrollPhysics(),
                                ),
                                isexpanding
                                    ? Container()
                                    : Container(
                                        height: 100,
                                        color: Colors.transparent,
                                        child: Center(
                                          child:
                                              new CircularProgressIndicator(),
                                        ),
                                      )
                              ]),
                            );
                          }),
                        ),
                      ],
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
                          SvgPicture.asset(
                            "assets/images/LAXIA.svg",
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'まだフォローしている\nユーザーはいません',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              fontWeight: FontWeight.w700,
                              color: Helper.txtColor,
                            ),
                          )
                        ],
                      ),
                    )),
    );
  }
}
