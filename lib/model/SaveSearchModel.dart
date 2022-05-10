/// status : "success"
/// result : [{"id":"51","user_id":"27","country_id":"4","country_name":"Spain","region_name":"Mallorca","region_id":"24","location_name":"\"Alcúdia\",\"Buger\"","looking_for":"0","looking_for_name":"All","property_type":"0","property_type_name":"All","language":"en-GB","plot_size_from":"All","plot_size_to":"0","living_space_from":"All","living_space_to":"0","rooms_from":"All","rooms_to":"0","bedroom_from":"All","bedroom_to":"0","bathroom_from":"All","bathroom_to":"0","price_from":"All","price_to":"0","terrace":"0","air_condition":"0","sea_view":"0","swimming_pool":"0","area_name":"North,Northeast","area_id":"1,2","created_at":"2021-05-24 09:45:33"}]

class SaveSearchModel {
  String _status;
  List<Result> _result;

  String get status => _status;
  List<Result> get result => _result;

  SaveSearchModel({
      String status, 
      List<Result> result}){
    _status = status;
    _result = result;
}

  SaveSearchModel.fromJson(dynamic json) {
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

/// id : "51"
/// user_id : "27"
/// country_id : "4"
/// country_name : "Spain"
/// region_name : "Mallorca"
/// region_id : "24"
/// location_name : "\"Alcúdia\",\"Buger\""
/// looking_for : "0"
/// looking_for_name : "All"
/// property_type : "0"
/// property_type_name : "All"
/// language : "en-GB"
/// plot_size_from : "All"
/// plot_size_to : "0"
/// living_space_from : "All"
/// living_space_to : "0"
/// rooms_from : "All"
/// rooms_to : "0"
/// bedroom_from : "All"
/// bedroom_to : "0"
/// bathroom_from : "All"
/// bathroom_to : "0"
/// price_from : "All"
/// price_to : "0"
/// terrace : "0"
/// air_condition : "0"
/// sea_view : "0"
/// swimming_pool : "0"
/// area_name : "North,Northeast"
/// area_id : "1,2"
/// created_at : "2021-05-24 09:45:33"

class Result {
  String _id;
  String _userId;
  String _countryId;
  String _countryName;
  String _regionName;
  String _regionId;
  String _locationName;
  String _lookingFor;
  String _lookingForName;
  String _propertyType;
  String _propertyTypeName;
  String _language;
  String _plotSizeFrom;
  String _plotSizeTo;
  String _livingSpaceFrom;
  String _livingSpaceTo;
  String _roomsFrom;
  String _roomsTo;
  String _bedroomFrom;
  String _bedroomTo;
  String _bathroomFrom;
  String _bathroomTo;
  String _priceFrom;
  String _priceTo;
  String _terrace;
  String _airCondition;
  String _seaView;
  String _swimmingPool;
  String _areaName;
  String _areaId;
  String _createdAt;

  String get id => _id;
  String get userId => _userId;
  String get countryId => _countryId;
  String get countryName => _countryName;
  String get regionName => _regionName;
  String get regionId => _regionId;
  String get locationName => _locationName;
  String get lookingFor => _lookingFor;
  String get lookingForName => _lookingForName;
  String get propertyType => _propertyType;
  String get propertyTypeName => _propertyTypeName;
  String get language => _language;
  String get plotSizeFrom => _plotSizeFrom;
  String get plotSizeTo => _plotSizeTo;
  String get livingSpaceFrom => _livingSpaceFrom;
  String get livingSpaceTo => _livingSpaceTo;
  String get roomsFrom => _roomsFrom;
  String get roomsTo => _roomsTo;
  String get bedroomFrom => _bedroomFrom;
  String get bedroomTo => _bedroomTo;
  String get bathroomFrom => _bathroomFrom;
  String get bathroomTo => _bathroomTo;
  String get priceFrom => _priceFrom;
  String get priceTo => _priceTo;
  String get terrace => _terrace;
  String get airCondition => _airCondition;
  String get seaView => _seaView;
  String get swimmingPool => _swimmingPool;
  String get areaName => _areaName;
  String get areaId => _areaId;
  String get createdAt => _createdAt;

  Result({
      String id, 
      String userId, 
      String countryId, 
      String countryName, 
      String regionName, 
      String regionId, 
      String locationName, 
      String lookingFor, 
      String lookingForName, 
      String propertyType, 
      String propertyTypeName, 
      String language, 
      String plotSizeFrom, 
      String plotSizeTo, 
      String livingSpaceFrom, 
      String livingSpaceTo, 
      String roomsFrom, 
      String roomsTo, 
      String bedroomFrom, 
      String bedroomTo, 
      String bathroomFrom, 
      String bathroomTo, 
      String priceFrom, 
      String priceTo, 
      String terrace, 
      String airCondition, 
      String seaView, 
      String swimmingPool, 
      String areaName, 
      String areaId, 
      String createdAt}){
    _id = id;
    _userId = userId;
    _countryId = countryId;
    _countryName = countryName;
    _regionName = regionName;
    _regionId = regionId;
    _locationName = locationName;
    _lookingFor = lookingFor;
    _lookingForName = lookingForName;
    _propertyType = propertyType;
    _propertyTypeName = propertyTypeName;
    _language = language;
    _plotSizeFrom = plotSizeFrom;
    _plotSizeTo = plotSizeTo;
    _livingSpaceFrom = livingSpaceFrom;
    _livingSpaceTo = livingSpaceTo;
    _roomsFrom = roomsFrom;
    _roomsTo = roomsTo;
    _bedroomFrom = bedroomFrom;
    _bedroomTo = bedroomTo;
    _bathroomFrom = bathroomFrom;
    _bathroomTo = bathroomTo;
    _priceFrom = priceFrom;
    _priceTo = priceTo;
    _terrace = terrace;
    _airCondition = airCondition;
    _seaView = seaView;
    _swimmingPool = swimmingPool;
    _areaName = areaName;
    _areaId = areaId;
    _createdAt = createdAt;
}

  Result.fromJson(dynamic json) {
    _id = json["id"];
    _userId = json["user_id"];
    _countryId = json["country_id"];
    _countryName = json["country_name"];
    _regionName = json["region_name"];
    _regionId = json["region_id"];
    _locationName = json["location_name"];
    _lookingFor = json["looking_for"];
    _lookingForName = json["looking_for_name"];
    _propertyType = json["property_type"];
    _propertyTypeName = json["property_type_name"];
    _language = json["language"];
    _plotSizeFrom = json["plot_size_from"];
    _plotSizeTo = json["plot_size_to"];
    _livingSpaceFrom = json["living_space_from"];
    _livingSpaceTo = json["living_space_to"];
    _roomsFrom = json["rooms_from"];
    _roomsTo = json["rooms_to"];
    _bedroomFrom = json["bedroom_from"];
    _bedroomTo = json["bedroom_to"];
    _bathroomFrom = json["bathroom_from"];
    _bathroomTo = json["bathroom_to"];
    _priceFrom = json["price_from"];
    _priceTo = json["price_to"];
    _terrace = json["terrace"];
    _airCondition = json["air_condition"];
    _seaView = json["sea_view"];
    _swimmingPool = json["swimming_pool"];
    _areaName = json["area_name"];
    _areaId = json["area_id"];
    _createdAt = json["created_at"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["user_id"] = _userId;
    map["country_id"] = _countryId;
    map["country_name"] = _countryName;
    map["region_name"] = _regionName;
    map["region_id"] = _regionId;
    map["location_name"] = _locationName;
    map["looking_for"] = _lookingFor;
    map["looking_for_name"] = _lookingForName;
    map["property_type"] = _propertyType;
    map["property_type_name"] = _propertyTypeName;
    map["language"] = _language;
    map["plot_size_from"] = _plotSizeFrom;
    map["plot_size_to"] = _plotSizeTo;
    map["living_space_from"] = _livingSpaceFrom;
    map["living_space_to"] = _livingSpaceTo;
    map["rooms_from"] = _roomsFrom;
    map["rooms_to"] = _roomsTo;
    map["bedroom_from"] = _bedroomFrom;
    map["bedroom_to"] = _bedroomTo;
    map["bathroom_from"] = _bathroomFrom;
    map["bathroom_to"] = _bathroomTo;
    map["price_from"] = _priceFrom;
    map["price_to"] = _priceTo;
    map["terrace"] = _terrace;
    map["air_condition"] = _airCondition;
    map["sea_view"] = _seaView;
    map["swimming_pool"] = _swimmingPool;
    map["area_name"] = _areaName;
    map["area_id"] = _areaId;
    map["created_at"] = _createdAt;
    return map;
  }

}