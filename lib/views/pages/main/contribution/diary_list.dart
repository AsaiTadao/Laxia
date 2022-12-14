import 'package:laxia/common/helper.dart';
import 'package:flutter/material.dart';
import 'package:laxia/controllers/auth_controller.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/diary/diary_model.dart';
import 'package:laxia/models/diary_model.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/views/widgets/diary_addpage_card.dart';

import '../../../../models/diary/diary_sub_model.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  String searchdata = "";
  int page = 0;
  bool isend = false, isloading = true, isexpanding = true;
  bool expanded = true;
  int index = -1;
  late List<Diary_Sub_Model> diary_data;
  // final _con = HomeController();
  final _con = AuthController();
  late List<Diary_Sub_Model> mid;
  late Me myInfo;
  List categoryList = [];
  Future<void> getData() async {
    try {
      myInfo = await _con.getMe();
      setState(() {
        diary_data = myInfo.diaries!;
        print(myInfo.counselings?.length);
        isloading = false;
      });
    
    } catch (e) {
      setState(() {
        isexpanding = true;
        isend = true;
        print(e.toString());
      });
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
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '日記を投稿する',
          style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.5),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, size: 25, color: Helper.titleColor),
          onPressed: () => Navigator.pop(context),
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
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 31, left: 16, right: 16),
                child: ElevatedButton(
                  onPressed: () async{
                    await Navigator.of(context).pushNamed("/AddDiaryStep1");
                    setState(() {
                      isloading = true;
                    });
                    getData();
                  },
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.only(top: 21, bottom: 22),
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
                        Text('新しい日記を投稿',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: Helper.headFontFamily,
                                color: Helper.whiteColor,
                                fontWeight: FontWeight.w400)),
                        SizedBox(width: 26.8),
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
                : Column(children: [
                    diary_data.length > 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 27, left: 16),
                            child: ListTile(
                              title: Text(
                                '全ての日記',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Helper.titleColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    height: 1.5),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: diary_data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder:
                                  (BuildContext context, int index) {
                                final List<String> categories = [];
                                for(int i=0; i< diary_data[index].categories!.length; i++)
                                  categories.add(diary_data[index].categories![i].name);
                                return DiaryAddPage_Card(
                                  title: diary_data[index].categories!.length > 0 ? diary_data[index].categories![0].name : '',
                                  photo: diary_data[index].before_image!,
                                  categories: categories.join(', '),
                                  clinic_name: diary_data[index].clinic_name!,
                                  doctor_name: diary_data[index].doctor_name!,
                                  diary_id: diary_data[index].id,
                                  onpress: () {},
                                  // avator: mid.data[index].patient_photo!,
                                  // name: mid
                                  //     .data[index].categories![subIndex].name,
                                  // image1: diary_list[index]["image1"],
                                  // image2: diary_list[index]["image2"],
                                  // sentence: diary_list[index]["sentence"],
                                  // clinic: mid.data[index].clinic_name,
                                  // type: mid
                                  //     .data[index].categories![subIndex].name,
                                  // check: mid.data[index].doctor_name!,
                                  // eyes: diary_list[index]["eyes"],
                                  // onpress: () {},
                                  // price: diary_list[index]["price"],
                                  // buttontext: diary_list[index]["status"],
                                  // fontcolor:
                                  //     (diary_list[index]["status"] == "未公開"
                                  //         ? Color.fromARGB(255, 102, 110, 110)
                                  //         : Color.fromARGB(255, 240, 154, 55)),
                                  // buttoncolor:
                                  //     (diary_list[index]["status"] == "未公開"
                                  //         ? Color.fromARGB(50, 102, 110, 110)
                                  //         : Color.fromARGB(50, 240, 154, 55)),
                                );
                              }),
                          
                        ],
                      ),
                    
                  ]),
          ],
        ),
      ),
    );
  }
}
