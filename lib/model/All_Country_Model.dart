/// status : "success"
/// result : [{"id":"1","name":"Worldwide"},{"id":"2","name":"Germany"},{"id":"3","name":"Switzerland"},{"id":"4","name":"Spain"}]

class AllCountryModel {
  String _status;
  List<Result> _result;

  String get status => _status;
  List<Result> get result => _result;

  AllCountryModel({
      String status, 
      List<Result> result}){
    _status = status;
    _result = result;
}

  AllCountryModel.fromJson(dynamic json) {
    _status = json["status"];
    if (json["result"] != null) {
      _result = [];
      json["result"].forEach((v) {
        _result.add(Result.fromJson(v));
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

/// id : "1"
/// name : "Worldwide"

class Result {
  String _id;
  String _name;

  String get id => _id;
  String get name => _name;

  Result({
      String id, 
      String name}){
    _id = id;
    _name = name;
}

  Result.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }

}