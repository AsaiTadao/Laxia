import 'package:equatable/equatable.dart';

class Test_Question extends Equatable {
  final int id;
  final String? name;
  final int? visible;
  final int? sort_no;
  final String? created_at;
  final String? updated_at;
  final Pivot? pivot;

  const Test_Question({required this.id, this.updated_at, this.pivot,this.name,  this.visible,  this.sort_no,  this.created_at});

  factory Test_Question.fromJson(Map<String, dynamic> json) {
    return Test_Question(
        name: json["name"],
        visible: json["visible"],
        sort_no: json["sort_no"],
        created_at:json["created_at"], 
        id: json["id"],
        updated_at:json["updated_at"],
        pivot: json["pivot"] == null ? Pivot(answer: '') : Pivot.fromJson(json["pivot"])
        );
  }
  @override
  List<Object?> get props => [
        name,
        visible,
        sort_no,
        created_at
      ];
}

class Pivot extends Equatable {
  final int? diary_id;
  final int? question_id;
  final String? answer;
  const Pivot({this.answer,this.diary_id, this.question_id});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
        answer:json["answer"],
        diary_id: json["diary_id"],
        question_id: json["question_id"]);
  }
  @override
  List<Object?> get props => [
         diary_id,
        question_id,
        answer
      ];
}