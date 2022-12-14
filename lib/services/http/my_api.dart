import 'dart:io';

import 'package:laxia/models/counsel_post_model.dart';
import 'package:laxia/models/counseling/councelingdetail_model.dart';
import 'package:laxia/models/diary/diary/diarydetail_model.dart';
import 'package:laxia/models/diary/diary/progress_detail_model.dart';
import 'package:laxia/models/diary_post_model.dart';
import 'package:laxia/models/follow/follow_model.dart';
import 'package:laxia/models/me_model.dart';
import 'package:laxia/models/point/point_model.dart';
import 'package:laxia/models/profile_model.dart';
import 'package:laxia/models/progess_post_model.dart';
import 'package:laxia/models/question/question_sub_model.dart';
import 'package:laxia/services/http/api.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../../models/question/media_model.dart';
import '../../models/question_post_model.dart';

class MyApi extends Api {
  MyApi();

  Future<Follow> getFollows(String per_page, String page, String q) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/follows?per_page=" + per_page + "&page=" + page + "&q=" + q,
        token);
    return Follow.fromJson(res.data["data"]["follows"]);
  }

  Future<Follow> getFollowers(String per_page, String page) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/followers?per_page=" + per_page + "&page=" + page, token);
    return Follow.fromJson(res.data["data"]["followers"]);
  }
  Future<Me> getPatientInfo(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/patients/$index", token);
    return Me.fromJson(res.data['data']['patient']);
  }
  Future<Point> getPointInfo() async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/points/history", token);
    return Point.fromJson(res.data);
  }
  Future<bool> postTooglefollow(int index) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post("$apiUrl/patients/$index/toggleFollow",<String, String>{}, token);
    if(res!.data["status"]==1){
      return true;
    }
    return false;
  }
  Future<int> getinvitation(String code) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get("$apiUrl/invite?code=${code}", token);
    return res.data["status"];
  }
  Future<void> postDiary(DiaryPostModel newDiary) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
        "$apiUrl/diaries",
        <String, String>{
          "diaries[clinic_id]": newDiary.clinic_id,
          "diaries[treat_date]": newDiary.date,
          "diaries[doctor_id]": newDiary.doctor_id,
          for (int i = 0; i < newDiary.categories.length; i++)
            'categories[' + (i+1).toString() +']': newDiary.categories[i].toString(),
          for (int j = 0; j < newDiary.questions.length; j++)
            "diary_tqs[" + (j + 1).toString() + "]": newDiary.questions[j],
          for (int k = 0; k < newDiary.rates.length; k++)
            "diaries[rate_0" + (k + 1).toString() + "]": newDiary.rates[k].toString(),
          "diaries[cost_anesthetic]": newDiary.cost_anes.toString(),
          "diaries[cost_drug]": newDiary.cost_drug.toString(),
          "diaries[cost_other]": newDiary.cost_other.toString(),
          // // for (int i = 0; i < newDiary.imageIds.length; i++)
          // //   "medias[]": newDiary.imageIds[i].toString(),
          for (int i = 0; i < newDiary.imageIds[0].length; i++)
            "before_medias[]": newDiary.imageIds[0][i].toString(),
          for (int i = 0; i < newDiary.imageIds[1].length; i++)
            "after_medias[]": newDiary.imageIds[1][i].toString(),
          "menus[0][cost]": newDiary.cost_op.toString(),
          "menus[0][id]": newDiary.menu_id.toString(),
        },
        token);
  }
  Future<dynamic> editDiary(DiaryPostModel newDiary, String diary_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
        "$apiUrl/diaries/" + diary_id,
        <String, String>{
          "diaries[clinic_id]": newDiary.clinic_id,
          "diaries[treat_date]": newDiary.date,
          "diaries[doctor_id]": newDiary.doctor_id,
          for (int i = 0; i < newDiary.categories.length; i++)
            'categories[' + (i+1).toString() +']': newDiary.categories[i].toString(),
          for (int j = 0; j < newDiary.questions.length; j++)
            "diary_tqs[" + (j + 1).toString() + "]": newDiary.questions[j],
          for (int k = 0; k < newDiary.rates.length; k++)
            "diaries[rate_0" + (k + 1).toString() + "]": newDiary.rates[k].toString(),
          "diaries[cost_anesthetic]": newDiary.cost_anes.toString(),
          "diaries[cost_drug]": newDiary.cost_drug.toString(),
          "diaries[cost_other]": newDiary.cost_other.toString(),
          // for (int i = 0; i < newDiary.imageIds.length; i++)
          //   "medias[]": newDiary.imageIds[i].toString(),
          for (int i = 0; i < newDiary.imageIds[0].length; i++)
            "before_medias["+i.toString()+"]": newDiary.imageIds[0][i].toString(),
          for (int i = 0; i < newDiary.imageIds[1].length; i++)
            "after_medias["+i.toString()+"]": newDiary.imageIds[1][i].toString(),
          "menus[0][cost]": newDiary.cost_op.toString(),
          "menus[0][id]": newDiary.menu_id.toString(),
          "_method":"PUT"
        },
        token);
    return res;
  }

  Future<dynamic> postQuestion(QuestionPostModel newQuestion) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/questions", 
      <String, String> {
        'questions[title]': newQuestion.title,
        'questions[content]': newQuestion.content,
        for(int i = 0; i < newQuestion.categories.length; i++)
          'categories[' + (i+1).toString() +']': newQuestion.categories[i].toString(),
        for(int j = 0; j < newQuestion.imageID_list.length; j++)
          'medias[]': newQuestion.imageID_list[j].toString(),
      } ,
      token
    );
    return res;
  }
  Future<dynamic> postCounsel(CounselPostModel newCounsel) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/counselings", 
      <String, String> {
        'counselings[clinic_id]': newCounsel.clinic_id,
        'counselings[doctor_id]': newCounsel.doctor_id,
        'counselings[counseling_date]': newCounsel.date,
        'counselings[content]': newCounsel.content,
        'counselings[reason]': newCounsel.reason,
        'counselings[before_counseling]': newCounsel.before_counsel,
        'counselings[after_ccounseling]': newCounsel.after_counsel,
        'counselings[rate]': newCounsel.rate,
        for(int i = 0; i < newCounsel.categories.length; i++)
          'categories[' + (i+1).toString() +']': newCounsel.categories[i].toString(),
        for(int j = 0; j < newCounsel.imageIds[0].length; j++)
          'medias[self][]': newCounsel.imageIds[0][j].toString(),
        for(int j = 0; j < newCounsel.imageIds[1].length; j++)
          'medias[like][]': newCounsel.imageIds[1][j].toString(),
        for(int j = 0; j < newCounsel.imageIds[2].length; j++)
          'medias[dislike][]': newCounsel.imageIds[2][j].toString(),
        for(int i = 0; i < newCounsel.question.length; i++)
          'questions[' + (i+1).toString() + '][question]': newCounsel.question[i].question,
        for(int i = 0; i < newCounsel.question.length; i++)
          'questions[' + (i+1).toString() + '][answer]': newCounsel.question[i].answer,
      } ,
      token
    );
    return res;
  }
  Future<dynamic> editCounsel(CounselPostModel newCounsel, String counsel_id) async {
    String? token = await preferenceUtil.getToken();
    print(newCounsel.toString());
    final res = await Api.post(
      "$apiUrl/counselings/" + counsel_id, 
      <String, String> {
        'counselings[clinic_id]': newCounsel.clinic_id,
        'counselings[doctor_id]': newCounsel.doctor_id,
        'counselings[counseling_date]': newCounsel.date,
        'counselings[content]': newCounsel.content,
        'counselings[reason]': newCounsel.reason,
        'counselings[before_counseling]': newCounsel.before_counsel,
        'counselings[after_ccounseling]': newCounsel.after_counsel,
        'counselings[rate]': newCounsel.rate,
        for(int i = 0; i < newCounsel.categories.length; i++)
          'categories[' + (i+1).toString() +']': newCounsel.categories[i].toString(),
        for(int j = 0; j < newCounsel.imageIds[0].length; j++)
          'medias[self][]': newCounsel.imageIds[0][j].toString(),
        for(int j = 0; j < newCounsel.imageIds[1].length; j++)
          'medias[like][]': newCounsel.imageIds[1][j].toString(),
        for(int j = 0; j < newCounsel.imageIds[2].length; j++)
          'medias[dislike][]': newCounsel.imageIds[2][j].toString(),
        for(int i = 0; i < newCounsel.question.length; i++)
          'questions[' + (i+1).toString() + '][question]': newCounsel.question[i].question,
        for(int i = 0; i < newCounsel.question.length; i++)
          'questions[' + (i+1).toString() + '][answer]': newCounsel.question[i].answer,
        "_method":"PUT"
      } ,
      token
    );
    print("____"+res!.data.toString());
    return res;
  }
  Future<dynamic> postProgress(ProgressPostModel newProgress, String diary_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/diaries/" + diary_id + '/progresses', 
      <String, String> {
        'progresses[from_treat_day]': newProgress.from_treat_day,
        'progresses[content]': newProgress.content,
        'status[1]': newProgress.status1.toString(),
        'status[2]': newProgress.status2.toString(),
        'status[3]': newProgress.status3.toString(),
        for(int j = 0; j < newProgress.imageIds.length; j++)
          'medias[]': newProgress.imageIds[j].toString(),
      } ,
      token
    );
    return res;
  }
  Future<dynamic> editProgress(ProgressPostModel newProgress, String progress_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/progresses/" + progress_id, 
      <String, String> {
        'progresses[from_treat_day]': newProgress.from_treat_day,
        'progresses[content]': newProgress.content,
        'status[1]': newProgress.status1.toString(),
        'status[2]': newProgress.status2.toString(),
        'status[3]': newProgress.status3.toString(),
        for(int j = 0; j < newProgress.imageIds.length; j++)
          'medias[]': newProgress.imageIds[j].toString(),
        "_method":"PUT",
      } ,
      token
    );
    return res;
  }
  Future<dynamic> editProfile(ProfileModel profile) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/register/detail",
      <String, String> {
        'patients[unique_id]': profile.unique_id.toString(),
        'patients[nickname]': profile.nick_name.toString(),
        'patients[intro]': profile.intro.toString(),
        'medias': profile.photo.toString(),
        'patients[birthday]': profile.birthday.toString(),
        'patients[gender]': profile.gender.toString(),
        'patients[area_id]': profile.area_id.toString(),
        for(int k = 0; k < profile.patient_categories.length; k++)
          'patient_categories[' + k.toString() + ']': profile.patient_categories[k].toString(),
      },
      token
    );
    return res;
  }

  Future<Media_model> imageUpload(String imagePicked) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.post(
      "$apiUrl/media",
      <String, dynamic> {
        "media": imagePicked
      },
      token
    );
    return Media_model.fromJson(res!.data['media']);
  }

  Future<CouncelingDetail_Model> getCounselDetail(String counsel_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/counselings/" + counsel_id,
        token);
    return CouncelingDetail_Model.fromJson(res.data["data"]["counseling"]);
  }
  Future<DiaryDetail_Model> getDiaryDetail(String diary_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/diaries/" + diary_id,
        token);
    return DiaryDetail_Model.fromJson(res.data["data"]["diary"]);
  }
  Future<ProgressDetail_Model> getProgressDetail(String progress_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/progresses/" + progress_id,
        token);
    return ProgressDetail_Model.fromJson(res.data["progress"]);
  }
  Future<Question_Sub_Model> getQuestionDetail(String question_id) async {
    String? token = await preferenceUtil.getToken();
    final res = await Api.get(
        "$apiUrl/questions/" + question_id,
        token);
    return Question_Sub_Model.fromJson(res.data["data"]["question"]);
  }
}
