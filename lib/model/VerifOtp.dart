/// status : "200"
/// result : "OTP Verified."

class VerifOtp {
  String _status;
  String _result;

  String get status => _status;
  String get result => _result;

  VerifOtp({
      String status, 
      String result}){
    _status = status;
    _result = result;
}

  VerifOtp.fromJson(dynamic json) {
    _status = json["status"];
    _result = json["result"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["result"] = _result;
    return map;
  }

}