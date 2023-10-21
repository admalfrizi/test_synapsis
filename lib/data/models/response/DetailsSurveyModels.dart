class DetailsSurveyModels {
  DetailsSurveyModels({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });
  late final int code;
  late final bool status;
  late final String message;
  late final Data data;

  DetailsSurveyModels.fromJson(Map<String, dynamic> json){
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    _data['message'] = message;
    _data['data'] = data.toJson();
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

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    surveyName = json['survey_name'];
    status = json['status'];
    totalRespondent = json['total_respondent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questions = List.from(json['questions']).map((e)=>Questions.fromJson(e)).toList();
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
    required this.id,
    required this.questionNumber,
    required this.surveyId,
    required this.section,
    required this.inputType,
    required this.questionName,
    required this.questionSubject,
    required this.options,
  });
  late final String id;
  late final int questionNumber;
  late final String surveyId;
  late final String section;
  late final String inputType;
  late final String questionName;
  late final String questionSubject;
  late final List<Options> options;

  Questions.fromJson(Map<String, dynamic> json){
    id = json['id'];
    questionNumber = json['question_number'];
    surveyId = json['survey_id'];
    section = json['section'];
    inputType = json['input_type'];
    questionName = json['question_name'];
    questionSubject = json['question_subject'];
    options = List.from(json['options']).map((e)=>Options.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question_number'] = questionNumber;
    _data['survey_id'] = surveyId;
    _data['section'] = section;
    _data['input_type'] = inputType;
    _data['question_name'] = questionName;
    _data['question_subject'] = questionSubject;
    _data['options'] = options.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Options {
  Options({
    required this.id,
    required this.questionId,
    required this.optionName,
    required this.value,
    required this.color,
  });
  late final String id;
  late final String questionId;
  late final String optionName;
  late final int value;
  late final String color;

  Options.fromJson(Map<String, dynamic> json){
    id = json['id'];
    questionId = json['question_id'];
    optionName = json['option_name'];
    value = json['value'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question_id'] = questionId;
    _data['option_name'] = optionName;
    _data['value'] = value;
    _data['color'] = color;
    return _data;
  }
}