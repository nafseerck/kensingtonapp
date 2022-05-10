/// status : "success"
/// property_count : 3

class CountModel {
  String _status;
  int _propertyCount;

  String get status => _status;
  int get propertyCount => _propertyCount;

  CountModel({
      String status, 
      int propertyCount}){
    _status = status;
    _propertyCount = propertyCount;
}

  CountModel.fromJson(dynamic json) {
    _status = json["status"];
    _propertyCount = json["property_count"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["property_count"] = _propertyCount;
    return map;
  }

}