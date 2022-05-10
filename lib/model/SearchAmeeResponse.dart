/// status : "success"
/// result : "23.00"

class SearchAmeeResponse {
  String _status;
  String _result;

  String get status => _status;
  String get result => _result;

  SearchAmeeResponse({
      String status, 
      String result}){
    _status = status;
    _result = result;
}

  SearchAmeeResponse.fromJson(dynamic json) {
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