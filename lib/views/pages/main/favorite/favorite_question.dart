import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:laxia/common/helper.dart';
import 'package:laxia/controllers/favorite_controller.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/models/question_model.dart';
import 'package:laxia/views/pages/main/contribution/question_detail.dart';
import 'package:laxia/views/widgets/dropdownbutton_widget.dart';
import 'package:laxia/views/widgets/question_card.dart';

class Favorite_Question extends StatefulWidget {
  const Favorite_Question({
    Key? key,
  }) : super(key: key);

  @override
  State<Favorite_Question> createState() => _Favorite_QuestionState();
}

class _Favorite_QuestionState extends State<Favorite_Question> {
  bool isloading = true;
  List<Question_Sub_Model> mid = [];
  FavoriteController _con = FavoriteController();
  Future<void> getFavQuestion() async {
    final listFavQuestion = await _con.getFavQuestion();
    setState(() {
      for (int i = 0; i < listFavQuestion.length; i++)
        mid.add(listFavQuestion[i]);
      isloading = false;
    });
  }

  @override
  initState() {
    getFavQuestion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Helper.homeBgColor,
      child: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: isloading
                        ? Container(
                            child: Container(
                            height: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Center(
                              child: new CircularProgressIndicator(),
                            ),
                          ))
                        : ListView.builder(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                itemCount: mid.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
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
                            builder: (context) => QuestionDetail(index:  mid[index].id)));
                      //Navigator.of(context).pushNamed("/QuestionDetail");
                    },
                    sentence:mid[index].content==null?"": mid[index].content!,
                    type:mid[index].categories!,
                  );
                }),
          )),
        ],
      ),
    );
  }
}
