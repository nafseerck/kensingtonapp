/// status : "success"
/// result : {"minimum_living_space":"0.00","maximum_living_space":"3000.00"}

class LivingResponse {
  String _status;
  LivingResult _result;

  String get status => _status;
  LivingResult get result => _result;

  LivingResponse({
      String status,
    LivingResult result}){
    _status = status;
    _result = result;
}

  LivingResponse.fromJson(dynamic json) {
    _status = json["status"];
    _result = json["result"] != null ? LivingResult.fromJson(json["result"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["status"] = _status;
    if (_result != null) {
      map["result"] = _result.toJson();
    }
    return map;
  }

}

/// minimum_living_space : "0.00"
/// maximum_living_space : "3000.00"

class LivingResult {
  String _minimumLivingSpace;
  String _maximumLivingSpace;

  String get minimumLivingSpace => _minimumLivingSpace;
  String get maximumLivingSpace => _maximumLivingSpace;

  LivingResult({
      String minimumLivingSpace, 
      String maximumLivingSpace}){
    _minimumLivingSpace = minimumLivingSpace;
    _maximumLivingSpace = maximumLivingSpace;
}

  LivingResult.fromJson(dynamic json) {
    _minimumLivingSpace = json["minimum_living_space"];
    _maximumLivingSpace = json["maximum_living_space"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["minimum_living_space"] = _minimumLivingSpace;
    map["maximum_living_space"] = _maximumLivingSpace;
    return map;
  }

}