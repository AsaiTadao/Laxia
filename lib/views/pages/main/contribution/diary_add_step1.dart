import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/home_controller.dart';
import 'package:laxia/models/clinic/clinic_model.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/provider/surgery_provider.dart';
import 'package:laxia/provider/user_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step2.dart';
import 'package:laxia/views/pages/main/contribution/select_clinic.dart';
import 'package:laxia/views/pages/main/contribution/select_doctor.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laxia/views/widgets/search_bar_widget.dart';
import 'package:provider/provider.dart';
import 'package:laxia/models/clinic_model.dart';
import 'package:laxia/models/doctor_model.dart';
import 'package:flutter_datetime_picker_forked/flutter_datetime_picker_forked.dart';

class AddDiaryStep1Page extends StatefulWidget {
  final bool? isMyDiary;
  const AddDiaryStep1Page({Key? key, this.isMyDiary = false}) : super(key: key);
  @override
  _AddDiaryStep1PageState createState() => _AddDiaryStep1PageState();
}

class _AddDiaryStep1PageState extends State<AddDiaryStep1Page> {
  // 選択してください
  List<String> addList = [
    "",
    "",
    "",
    "",
    "",
  ];
  bool isAddEnabled = true, isUsed = false;
  TextEditingController filter = new TextEditingController();
  int index = 0;
  List<String> images = [];
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        images.add(pickedImage.path);
      });
    }
    ;
  }

  enableAddButton() {
    setState(() {
      isAddEnabled = true;
    });
  }

  disableAddButton() {
    setState(() {
      isAddEnabled = false;
    });
  }

  _AddDiaryStep1Page() {
    showDialog(
      context: context,
      builder: (context) {
        PostDiaryProvider diaryProperties =
            Provider.of<PostDiaryProvider>(context, listen: true);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(children: [
            Container(
              width: 300,
              height: 200,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 14),
                    child: Text(
                      "下書きに保存しますか？",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        
                        fontWeight: FontWeight.w700,
                        color: Helper.titleColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "まだ投稿が完了しておりません。\n戻ると入力内容が消えてしまいます。",
                        style: TextStyle(
                          fontSize: 14,
                          
                          fontWeight: FontWeight.w400,
                          color: Helper.titleColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        new FlatButton(
                          textColor: Helper.mainColor,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 3, horizontal: 0),
                            child: Text(
                              '保存しない',
                              style: TextStyle(
                                fontSize: 16,
                                
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        new FlatButton(
                          color: Helper.mainColor,
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 10),
                              child: Text(
                                '保存する',
                                style: TextStyle(
                                  fontSize: 16,
                                  
                                  fontWeight: FontWeight.w400,
                                ),
                              )),
                          onPressed: () {
                            diaryProperties.setMedias(images);
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed("/AddDiaryStep2");
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 14,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  size: 20,
                  color: Helper.titleColor,
                ),
              ),
            )
          ]),
        );
      },
    );
  }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  String searchdata = "";
  bool isloading = true, isexpanding = true, isend = false;
  int page = 1;
  bool expanded = false;
  late Clinic clinic_data;
  final _con = HomeController();
  Future<void> getclinicData(
      {required String page,
      String? pref_id = "",
      String? city_id = "",
      String? q = ""}) async {
    try {
      if (!isend) {
        if (!isloading)
          setState(() {
            isexpanding = false;
          });
        final mid = await _con.getclinicData(
            page: page, pref_id: pref_id!, city_id: city_id!, q: q!);
        setState(() {
          if (isloading) {
            clinic_data = mid;
            isloading = false;
          } else {
            clinic_data.data.addAll(mid.data);
            isexpanding = true;
          }
        });
      }
    } catch (e) {
      print("object");
      isexpanding = true;
      isend = true;
      setState(() {
        print(e.toString());
      });
    }
  }

  void init() {
    setState(() {
      isloading = true;
      isexpanding = true;
      isend = false;
      page = 1;
      expanded = false;
      index = -1;
    });
  }

  @override
  void initState() {
    isUsed = false;
    getclinicData(page: page.toString());
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep1Page.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    SurGeryProvider surgeryProvider =
        Provider.of<SurGeryProvider>(context, listen: true);
    List listOperationTypes = diaryProperties.getOperationTypes;
    if (diaryProperties.getDate != "" //&&
        // listOperationTypes.length != 0 &&
        // diaryProperties.getClinicID &&
        // diaryProperties.getDoctorID &&
        // images.isNotEmpty
        ) {
      setState(() {
        isAddEnabled = true;
      });
    } else {
      setState(() {
        isAddEnabled = false;
      });
    }
    UserProvider userProperties =
        Provider.of<UserProvider>(context, listen: true);
    if (searchdata != userProperties.searchtext) {
      init();
      setState(() {
        searchdata = userProperties.searchtext;
        getclinicData(page: page.toString(), q: userProperties.searchtext);
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('基本情報を入力',
            style: TextStyle(
              color: Helper.titleColor,
              fontWeight: FontWeight.w700,
              fontSize: 16,
              
            )),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Helper.titleColor,
          ),
          onPressed: () {
            diaryProperties.setDate("");
            userProperties.setSelectedClinic("");
            userProperties.setSelectedDoctor("");
            surgeryProvider.selectedCurePosStr.clear();
            surgeryProvider.selectedCurePos.clear();
            Navigator.pop(context);
          },
          splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 240, 242, 245),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '基本情報',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術日",
                            style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                addList[0] != "" ? addList[0] : '選択してください',
                                style: TextStyle(
                                    color: addList[0] != "" ? Helper.titleColor : Helper.txtColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2200, 6, 7),
                                      onChanged: (date) {}, onConfirm: (date) {
                                    setState(() {
                                      addList[0] = date.year.toString() +
                                          "年" +
                                          date.month.toString() +
                                          "月" +
                                          date.day.toString() +
                                          "日";
                                    });
                                    diaryProperties.setDate(
                                        date.year.toString() +
                                            "/" +
                                            date.month.toString() +
                                            "/" +
                                            date.day.toString());
                                  },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.jp);
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術箇所",
                            style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  surgeryProvider.selectedCurePosStr.isNotEmpty
                                      ? surgeryProvider.getSelectedCurePosStr
                                      : "選択してください",
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: surgeryProvider.selectedCurePosStr.isNotEmpty? Helper.titleColor: Helper.txtColor,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 12,
                                      ),
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  surgeryProvider.selectedCurePosStr.clear();
                                  surgeryProvider.setButtonText("次へ");
                                  Navigator.of(context)
                                      .pushNamed("/SelectSurgery");
                                  setState(() {
                                    isUsed = true;
                                  });
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "クリニック",
                            style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                userProperties.getSelectedClinic != ""
                                    ? userProperties.getSelectedClinic
                                    : "選択してください",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: userProperties.getSelectedClinic != ""? Helper.titleColor : Helper.txtColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (context) {
                                        return SelectClinic();
                                      });
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "担当ドクター",
                            style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                userProperties.getSelectedDoctor != ""
                                    ? userProperties.getSelectedDoctor
                                    : "選択してください",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: userProperties.getSelectedDoctor != ""? Helper.titleColor : Helper.txtColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (context) {
                                        return SelectDoctor();
                                      });
                                },
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Helper.txtColor,
                                  size: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 21.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "施術内容",
                            style: TextStyle(
                                color: Color.fromARGB(255, 51, 51, 51),
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '選択してください',
                                style: TextStyle(
                                    color: Helper.txtColor,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12,
                                    ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                      ),
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      context: context,
                                      builder: (context) {
                                        return Container();
                                      });
                                },
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Helper.txtColor, size: 15),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, top: 23, bottom: 10),
              child: Text(
                '施術前の写真',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    ),
              ),
            ),
            imagePicker(context),
            !widget.isMyDiary!
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 85,
                      padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Color.fromARGB(255, 194, 194, 194),
                        ),
                        child: ElevatedButton(
                          onPressed:
                              isAddEnabled ? () => _AddDiaryStep1Page() : null,
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6))),
                            primary: Helper.mainColor,
                            onPrimary: Colors.white,
                            onSurface: Color.fromARGB(255, 194, 194, 194),
                            splashFactory: NoSplash.splashFactory,
                            shadowColor: Colors.transparent,
                          ),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '次に進む',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddDiaryStep2Page(
                                    isMyDiary: widget.isMyDiary)));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 70),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        side: const BorderSide(
                            color: Helper.mainColor,
                            width: 1,
                            style: BorderStyle.solid),
                        primary: Helper.whiteColor,
                        splashFactory: NoSplash.splashFactory,
                            shadowColor: Colors.transparent,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          '次へ進む',
                          style: TextStyle(
                              fontSize: 14,
                              
                              fontWeight: FontWeight.w700,
                              color: Helper.mainColor),
                        ),
                      ),
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  Widget imagePicker(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, top: 0, right: 12, bottom: 0),
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _openImagePicker();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 14),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 194, 194, 194),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/photo.svg",
                      width: 36,
                      height: 29,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('写真を追加',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PhotoCarouselWidget(
                      ImageList: images,
                      onRemove: (int) {
                        setState(() {
                          images.removeAt(int);
                        });
                      },
                      bRemove: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
