import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/models/menu/menu_sub_model.dart';

class Menu_Sub_Detail_Two extends StatefulWidget {
  final Menu_Sub_Model menu;
  const Menu_Sub_Detail_Two({ Key? key, required this.menu }) : super(key: key);

  @override
  State<Menu_Sub_Detail_Two> createState() => _Menu_Sub_Detail_TwoState();
}

class _Menu_Sub_Detail_TwoState extends State<Menu_Sub_Detail_Two> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height-70,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "施術の詳細",
                  style: defaultTextStyle(
                      Helper.titleColor, FontWeight.w700,
                      size: 18),
                ),
                IconButton(onPressed: (){
                  Navigator.of(context).pop();
                }, icon: Icon(Icons.close,size: 20,),
                splashColor: Colors.transparent,
            highlightColor: Colors.transparent,  
                )
            ]),
            Text(
              widget.menu.description!,
              style: TextStyle(color:Helper.titleColor, fontWeight:FontWeight.w400,fontSize: 14,height: 2.1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "副作用・リスク",
                style: defaultTextStyle(
                    Helper.titleColor, FontWeight.w700,
                    size: 18),
              ),
            ),
            Text(
              widget.menu.risk!,
              style: TextStyle(color:Helper.titleColor, fontWeight:FontWeight.w400,fontSize: 14,height: 2.1),
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 219,
                        height: 44,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Helper.mainColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "閉じる",
                                  style: defaultTextStyle(
                                      Helper.whiteColor, FontWeight.w700,
                                      size: 13),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 40,)
          ],),
        ),
      ),
    );
  }
}