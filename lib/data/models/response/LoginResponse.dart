class LoginResponse {
  LoginResponse({
    required this.code,
    required this.status,
    required this.message,
    required this.data,
  });
  late final int code;
  late final bool status;
  late final String message;
  late final Data data;

  LoginResponse.fromJson(Map<String, dynamic> json){
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
    required this.occupationLevel,
    required this.occupationName,
  });
  late final int occupationLevel;
  late final String occupationName;

  Data.fromJson(Map<String, dynamic> json){
    occupationLevel = json['occupation_level'];
    occupationName = json['occupation_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['occupation_level'] = occupationLevel;
    _data['occupation_name'] = occupationName;
    return _data;
  }
}