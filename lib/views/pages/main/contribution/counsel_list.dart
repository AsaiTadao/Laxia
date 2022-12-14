import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/models/counseling/counceling_sub_model.dart';
import 'package:laxia/models/counseling_model.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/views/widgets/counsel_card.dart';

class AddCounselPage extends StatefulWidget {
  @override
  _AddCounselPageState createState() => _AddCounselPageState();
}

class _AddCounselPageState extends State<AddCounselPage> {
  int page = 0;
  bool isend = false, isloading = true, isexpanding = true;
  bool expanded = true;
  List<Counceling_Sub_Model> counsel_data = [];
  // final _con = HomeController();
  final _con = AuthController();
  late List<Counceling_Sub_Model> mid;
  late Me myInfo;
  List categoryList = [];
  Future<void> getData() async {
    try {
      myInfo = await _con.getMe();
      setState(() {
        for (int i = myInfo.counselings!.length - 1; i >= 0; i--)
          counsel_data.add(myInfo.counselings![i]);
        // counsel_data = myInfo.counselings!;
        print(myInfo.counselings?.length);
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'カウンセリングレポート',
          style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 25, color: Helper.titleColor),
          onPressed: () => Navigator.of(context).pushNamed("/Pages"),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(
                height: 24,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 69,
                  padding: EdgeInsets.only(top: 0, left: 16, right: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed("/AddCounselStep1");
                    },
                    style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.fromLTRB(16, 21, 16, 21),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      primary: Helper.mainColor,
                      onPrimary: Colors.white,
                      onSurface: Colors.grey,
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('新しくレポートを作成',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: Helper.headFontFamily,
                                  color: Helper.whiteColor,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(width: 16.8),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              isloading
                  ? Container(
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        color: Colors.transparent,
                        child: Center(
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        counsel_data.length > 0
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    top: 27, left: 16, bottom: 17),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '全てのカウンセリングレポート',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Helper.maintxtColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        height: 1.5),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        counsel_data.length > 0
                            ? Column(
                                children: [
                                  // menuAppBar(context),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: counsel_data.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CounselAddPage_Card(
                                          category_name: counsel_data[index]
                                              .categories![0]
                                              .name,
                                          clinic_name:
                                              counsel_data[index].clinic_name!,
                                          doctor_name:
                                              counsel_data[index].doctor_name!,
                                          counsel_id: counsel_data[index].id,
                                          onpress: () {},
                                          // avator: counseling_list[index]["avator"],
                                          // name: counseling_list[index]["name"],
                                          // image1: counseling_list[index]["image1"],
                                          // image2: counseling_list[index]["image2"],
                                          // sentence: counseling_list[index]["sentence"],
                                          // clinic: counseling_list[index]["clinic"],
                                          // type: counseling_list[index]["type"],
                                          // check: counseling_list[index]["check"],
                                          // eyes: counseling_list[index]["eyes"],
                                          // onpress: () {},
                                          // price: counseling_list[index]["price"],
                                          // buttontext: counseling_list[index]["status"],
                                          // fontcolor: (counseling_list[index]["status"] == "未公開"
                                          //     ? Color.fromARGB(255, 102, 110, 110)
                                          //     : Color.fromARGB(255, 240, 154, 55)),
                                          // buttoncolor: (counseling_list[index]["status"] == "未公開"
                                          //     ? Color.fromARGB(50, 102, 110, 110)
                                          //     : Color.fromARGB(50, 240, 154, 55)),
                                        );
                                      }),
                                ],
                              )
                            : SizedBox(),
                      ],
                    ),
            ]),
      ),
    );
  }
}
