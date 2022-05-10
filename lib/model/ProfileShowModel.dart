/// status : "success"
/// result : [{"user_id":"13","user_name":"priya","user_email":"Kush@gmail.com","password":"123456","status":"0","created_at":"2021-01-20 12:58:30"}]

class ProfileShowModel {
  String _status;
  List<ProfileResult> _result;

  String get status => _status;
  List<ProfileResult> get result => _result;

  ProfileShowModel({
      String status, 
      List<ProfileResult> result}){
    _status = status;
    _result = result;
}

  ProfileShowModel.fromJson(dynamic json) {
    _status = json["status"];
    if (json["result"] != null) {
      _result = [];
      json["result"].forEach((v) {
        _result.add(ProfileResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_result != null) {
      map["result"] = _result.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// user_id : "13"
/// user_name : "priya"
/// user_email : "Kush@gmail.com"
/// password : "123456"
/// status : "0"
/// created_at : "2021-01-20 12:58:30"

class ProfileResult {
  String _userId;
  String _userName;
  String _userEmail;
  String _password;
  String _status;
  String _createdAt;

  String get userId => _userId;
  String get userName => _userName;
  String get userEmail => _userEmail;
  String get password => _password;
  String get status => _status;
  String get createdAt => _createdAt;

  ProfileResult({
      String userId, 
      String userName, 
      String userEmail, 
      String password, 
      String status, 
      String createdAt}){
    _userId = userId;
    _userName = userName;
    _userEmail = userEmail;
    _password = password;
    _status = status;
    _createdAt = createdAt;
}

  ProfileResult.fromJson(dynamic json) {
    _userId = json["user_id"];
    _userName = json["user_name"];
    _userEmail = json["user_email"];
    _password = json["password"];
    _status = json["status"];
    _createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["user_email"] = _userEmail;
    map["password"] = _password;
    map["status"] = _status;
    map["created_at"] = _createdAt;
    return map;
  }

}