/// status : "success"
/// result : {"minimum_plot_size":"0.00","maximum_plot_size":"3000.00"}

class SearchRangeModel {
  String _status;
  ResultRange _result;

  String get status => _status;
  ResultRange get result => _result;

  SearchRangeModel({
      String status,
    ResultRange result}){
    _status = status;
    _result = result;
}

  SearchRangeModel.fromJson(dynamic json) {
    _status = json["status"];
    _result = json["result"] != null ? ResultRange.fromJson(json["result"]) : null;
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

/// minimum_plot_size : "0.00"
/// maximum_plot_size : "3000.00"

class ResultRange {
  String _minimumPlotSize;
  String _maximumPlotSize;

  String get minimumPlotSize => _minimumPlotSize;
  String get maximumPlotSize => _maximumPlotSize;

  ResultRange({
      String minimumPlotSize, 
      String maximumPlotSize}){
    _minimumPlotSize = minimumPlotSize;
    _maximumPlotSize = maximumPlotSize;
}

  ResultRange.fromJson(dynamic json) {
    _minimumPlotSize = json["minimum_plot_size"];
    _maximumPlotSize = json["maximum_plot_size"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["minimum_plot_size"] = _minimumPlotSize;
    map["maximum_plot_size"] = _maximumPlotSize;
    return map;
  }

}