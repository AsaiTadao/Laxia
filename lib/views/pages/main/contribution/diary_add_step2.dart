import 'package:laxia/common/helper.dart';
import 'package:laxia/provider/post_diary_provider.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step3.dart';
import 'package:laxia/views/pages/main/contribution/diary_add_step4.dart';
import 'package:laxia/views/widgets/photocarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AddDiaryStep2Page extends StatefulWidget {
  String? diary_id;
  final String operationName;
  final bool? isMyDiary;
  AddDiaryStep2Page({Key? key, required this.operationName, this.isMyDiary = false, this.diary_id = ''}) : super(key: key);
  @override
  _AddDiaryStep2PageState createState() => _AddDiaryStep2PageState();
}

class _AddDiaryStep2PageState extends State<AddDiaryStep2Page> {
  bool isAddEnabled = true;
  bool initDetail = true;
  TextEditingController conOp = TextEditingController();
  TextEditingController conAnes = TextEditingController();
  TextEditingController conDrug = TextEditingController();
  TextEditingController conOther = TextEditingController();
  int cost_op = 0;
  int cost_anes = 0;
  int cost_drug = 0;
  int cost_other = 0;
  int total_cost = 0;
  //File imageURI;
  // late OfferController _con;

  // _AddDiaryStep2PageState() : super(OfferController()) {
  //   _con = controller as OfferController;
  // }

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

  // AddDiaryStep3Page({String? diary_id}) {
  //   Navigator.of(context).pushNamed("/AddDiaryStep3");
  // }

  editTitle(String title) {
    if (title.isNotEmpty) isAddEnabled = true;
  }

  @override
  void initState() {
    super.initState();
  }

  Future getImageFromGallery() async {
    // var image = await AddDiaryStep2Page.pickImage(source: ImageSource.gallery);

    // setState(() {
    //   imageURI = image;
    // });
  }

  @override
  Widget build(BuildContext context) {
    PostDiaryProvider diaryProperties =
        Provider.of<PostDiaryProvider>(context, listen: true);
    // diaryProperties.setCostAnesthetic(cost_anes);
    // diaryProperties.setCostDrug(cost_drug);
    // diaryProperties.setCostOther(cost_other);
    if(initDetail && widget.diary_id != '') {
      setState(() {
        conOp.text = (diaryProperties.cost_op - diaryProperties.cost_anesthetic - diaryProperties.cost_drug - diaryProperties.cost_other).toString();
        conAnes.text = diaryProperties.cost_anesthetic.toString();
        conDrug.text = diaryProperties.cost_drug.toString();
        conOther.text = diaryProperties.cost_other.toString();
        initDetail = false;
      });
    }
    setState(() {
      total_cost = 0;
      if(conOp.text != '' && conOp.text != null)
        total_cost += int.parse(conOp.text);
      if(conAnes.text != '' && conAnes.text != null)
        total_cost += int.parse(conAnes.text);
      if(conDrug.text != '' && conDrug.text != null)
        total_cost += int.parse(conDrug.text);
      if(conOther.text != '' && conOther.text != null)
        total_cost += int.parse(conOther.text);
      // total_cost = cost_op + cost_anes + cost_drug + cost_other;
    });
    
    if(diaryProperties.getCostOp > 0)
      setState(() {
        isAddEnabled = true;
      });
    else
      setState(() {
        isAddEnabled = false;
      });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('?????????????????????',
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
            Navigator.pop(context);
          },
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
            Padding(
              padding: const EdgeInsets.only(top: 23, left: 16, bottom: 6),
              child: Text(
                '????????????',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Color.fromARGB(255, 102, 110, 110),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    height: 1.5),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 16.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            widget.operationName,
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: conOp,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            onChanged: (val){
                              // setState(() {
                              //   conOp.text = val;
                              // });
                              diaryProperties.setCostOp(int.parse(val));
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Text(
                          '???',
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        )
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 16.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "????????????",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: conAnes,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            onChanged: (val) {
                              // setState(() {
                              //   conAnes.text = val;
                              // });
                              diaryProperties.setCostAnesthetic(int.parse(val));
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Text(
                          '???',
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        )
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 16.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "??????????????????",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: conDrug,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            onChanged: (val) {
                              // setState(() {
                              //   conDrug.text = val;
                              // });
                              diaryProperties.setCostDrug(int.parse(val));
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Text(
                          '???',
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        )
                      ]),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Color.fromARGB(255, 198, 198, 200)),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 16.0, 15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            "??????????????????",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                height: 1.5),
                          ),
                        ),
                        Flexible(
                          child: TextField(
                            controller: conOther,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.right,
                            onChanged: (val) {
                              // setState(() {
                              //   conOther.text = val;
                              // });
                              diaryProperties.setCostOther(int.parse(val));
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 18, 18),
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                height: 1.5),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                            ),
                          ),
                        ),
                        Text(
                          '???',
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              height: 1.5),
                        )
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
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 16.0, 15.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Text(
                      "????????????: ",
                      style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.5),
                    ),
                    Text(
                      total_cost.toString(),
                      style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.5),
                    ),
                    Text(
                      "???",
                      style: TextStyle(
                              color: Color.fromARGB(255, 18, 18, 18),
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              height: 1.5),
                    ),
                  ]),
                ),
              ),
            ),
            !widget.isMyDiary!
                ? Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 85,
                      padding: EdgeInsets.only(top: 40, left: 16, right: 16),
                      child: ElevatedButton(
                        onPressed:
                            isAddEnabled ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddDiaryStep3Page(
                                    diary_id: widget.diary_id
                              )));
                            } : null,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          primary: Helper.mainColor,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                          splashFactory: NoSplash.splashFactory,
                              shadowColor: Colors.transparent,
                        ),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '????????????',
                            style: TextStyle(
                                fontSize: 14,
                                
                                fontWeight: FontWeight.w700),
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
                      onPressed: isAddEnabled ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddDiaryStep4Page(
                                    isMyDiary: widget.isMyDiary, diary_id: widget.diary_id,)));
                      } : null,
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
                          '????????????',
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
}
