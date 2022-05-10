/// status : "200"
/// msg : ["Favorite Property Saved Successfully"]

class FavModel {
  String _status;
  List<String> _msg;

  String get status => _status;
  List<String> get msg => _msg;

  FavModel({
      String status, 
      List<String> msg}){
    _status = status;
    _msg = msg;
}

  FavModel.fromJson(dynamic json) {
    _status = json["status"];
    _msg = json["msg"] != null ? json["msg"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    map["msg"] = _msg;
    return map;
  }

}