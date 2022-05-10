/// status : "202"
/// user_id : "2"
/// msg : "You have successfully login."

class LoginResponse {
  String _status;
  String _userId;
  String _msg;

  String get status => _status;
  String get userId => _userId;
  String get msg => _msg;

  LoginResponse({
      String status, 
      String userId, 
      String msg}){
    _status = status;
    _userId = userId;
    _msg = msg;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json["status"];
    _userId = json["user_id"];
    _msg = json["msg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["user_id"] = _userId;
    map["msg"] = _msg;
    return map;
  }

}