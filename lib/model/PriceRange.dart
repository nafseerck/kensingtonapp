/// status : "success"
/// result : {"minimum_price":"0.00","maximum_price":"22500000.00"}

class PriceRange {
  String _status;
  PriceResult _result;

  String get status => _status;
  PriceResult get result => _result;

  PriceRange({
      String status,
    PriceResult result}){
    _status = status;
    _result = result;
}

  PriceRange.fromJson(dynamic json) {
    _status = json["status"];
    _result = json["result"] != null ? PriceResult.fromJson(json["result"]) : null;
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

/// minimum_price : "0.00"
/// maximum_price : "22500000.00"

class PriceResult {
  String _minimumPrice;
  String _maximumPrice;

  String get minimumPrice => _minimumPrice;
  String get maximumPrice => _maximumPrice;

  Result({
      String minimumPrice, 
      String maximumPrice}){
    _minimumPrice = minimumPrice;
    _maximumPrice = maximumPrice;
}

  PriceResult.fromJson(dynamic json) {
    _minimumPrice = json["minimum_price"];
    _maximumPrice = json["maximum_price"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["minimum_price"] = _minimumPrice;
    map["maximum_price"] = _maximumPrice;
    return map;
  }

}