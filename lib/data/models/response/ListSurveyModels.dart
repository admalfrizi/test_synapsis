class ListSurveyModels {
  ListSurveyModels({
    required this.code,
    required this.status,
    required this.message,
    required this.totalAllData,
    required this.data,
  });
  late final int code;
  late final bool status;
  late final String message;
  late final int totalAllData;
  late final List<Data> data;

  ListSurveyModels.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'];
    message = json['message'];
    totalAllData = json['total_all_data'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['message'] = message;
    _data['total_all_data'] = totalAllData;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.surveyName,
    required this.status,
    required this.totalRespondent,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
  });
  late final String id;
  late final String surveyName;
  late final int status;
  late final int totalRespondent;
  late final String createdAt;
  late final String updatedAt;
  late final List<Questions> questions;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
        id : json['id'],
        surveyName : json['survey_name'],
        status : json['status'],
        totalRespondent : json['total_respondent'],
        createdAt : json['created_at'],
        updatedAt : json['updated_at'],
        questions : List.from(json['questions']).map((e)=>Questions.fromJson(e)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['survey_name'] = surveyName;
    _data['status'] = status;
    _data['total_respondent'] = totalRespondent;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['questions'] = questions.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Questions {
  Questions({
    required this.questionName,
    required this.inputType,
    required this.questionId,
  });
  late final String questionName;
  late final String inputType;
  late final String questionId;

  Questions.fromJson(Map<String, dynamic> json){
    questionName = json['question_name'];
    inputType = json['input_type'];
    questionId = json['question_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['question_name'] = questionName;
    _data['input_type'] = inputType;
    _data['question_id'] = questionId;
    return _data;
  }
}