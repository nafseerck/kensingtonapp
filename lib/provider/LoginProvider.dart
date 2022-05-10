import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kensington/apppreferences/PreferncesApp.dart';
import 'package:kensington/model/All_Country_Model.dart';
import 'package:kensington/model/CountModel.dart';
import 'package:kensington/model/FavModel.dart';
import 'package:kensington/model/LivingResponse.dart';
import 'package:kensington/model/LoginResponse.dart';
import 'package:kensington/model/NotificationModel.dart';
import 'package:kensington/model/PriceRange.dart';
import 'package:kensington/model/ProfileShowModel.dart';
import 'package:kensington/model/PropertDetailModel.dart';
import 'package:kensington/model/SaveSearchModel.dart';
import 'package:kensington/model/SearchAmeeResponse.dart';
import 'package:kensington/model/SearchModel.dart';
import 'package:kensington/model/SearchRangeModel.dart';
import 'package:kensington/model/VerifOtp.dart';
import 'package:kensington/networkapi/ApiClient.dart';
import 'package:kensington/pages/notification/PushNotificationService.dart';
import 'package:shared_preferences/shared_preferences.dart';




class LoginProvider with ChangeNotifier {
  PreferencesApp appprefense;
  String errorMessage;
  bool loading = true;
  LoginResponse user;
  FavModel _favModel;
  NotificationModel notificationModel;
  SearchRangeModel searchRangeModel;
  LivingResponse livingResponse;
  PriceRange _priceRange;
  ProfileShowModel profileShowModel;
  SearchModel searchModel;
  VerifOtp otpverify;
  PropertDetailModel _propertDetailModel;
  SaveSearchModel saveSearchModel;
  CountModel _countModel;
  AllCountryModel _allCountryModel;
  SearchAmeeResponse searchAmeeResponse;
  LoginProvider(){
    appprefense=PreferencesApp();
    appprefense.loadPrefernces();


  }
  PreferencesApp get bloc => appprefense;
  Future<bool> fetchUser(username,password,fcmToken) async {
    await ApiClient().fetchUser(username,password,fcmToken).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {

        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  Future<bool> count_notification() async {


    await ApiClient().notification_count().then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        print(data.body);
        setcount(CountModel.fromJson(json.decode(data.body)));

      } else {

        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isCount();
  }
  final PushNotificationService _pushNotificationService= PushNotificationService();


  Future handleStartUpLogic() async {
    await _pushNotificationService.initialise();
  }
  Future<bool> fetchCountry() async {


    await ApiClient().fetchall_country().then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }

  Future<bool> fetch_lookingfor() async {


    await ApiClient().fetch_looking().then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }
  Future<bool> fetch_property(country_id) async {


    await ApiClient().fetch_property(country_id).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }
  Future<bool> region(counrty_id) async {


    await ApiClient().fetch_region(counrty_id).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }
  Future<bool> all_location(counrty_id,region_id) async {


    await ApiClient().fetch_location(counrty_id,region_id).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        print(data.body);
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }
  Future<bool> all_locationforarea(counrty_id,region_id,area_id) async {


    await ApiClient().fetch_location_forarea(counrty_id,region_id,area_id).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        print(data.body);
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }
  Future<bool> all_area() async {


    await ApiClient().fetch_area().then((data) {
      setLoading(false);
      if (data.statusCode == 200) {
        print(data.body);
        setcounty(AllCountryModel.fromJson(json.decode(data.body)));


      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return iscountry();
  }
  Future<bool> Search_result(countryid,region_name,location_name,looking_for,property_type,pageno,region_name_real,sortdata) async {


    await ApiClient().search_property(countryid,region_name,location_name,looking_for,property_type,pageno,region_name_real,sortdata).then((data) {

      setLoading(false);
      if (data.statusCode == 200) {

print(data.body);
        setsearchlist(SearchModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return issearchlist();
  }
  Future<bool> quick_Search_result(quickdata,pageno,sortid) async {


    await ApiClient().search_quick(quickdata,pageno,sortid).then((data) {

      setLoading(false);
      if (data.statusCode == 200) {

        print(data.body);
        setsearchlist(SearchModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return issearchlist();
  }
  Future<bool> fav_result() async {


    await ApiClient().fav_property().then((data) {

      setLoading(false);
      if (data.statusCode == 200) {


        setsearchlist(SearchModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return issearchlist();
  }

  Future<bool> user_profile() async {


    await ApiClient().user_profile().then((data) {

      setLoading(false);
      if (data.statusCode == 200) {


        setprofile(ProfileShowModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return isprofile();
  }

  Future<bool> property_detail(propertyid) async {


    await ApiClient().detail_property(propertyid).then((data) {

      setLoading(false);
      if (data.statusCode == 200) {


        setpropertydetail(PropertDetailModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return ispropertydetail();
  }
  Future<bool> saved_result() async {


    await ApiClient().saved_property().then((data) {

      setLoading(false);
      if (data.statusCode == 200) {

print(data.body);
        savesearchlist(SaveSearchModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return issavesearchlist();
  }
  Future<bool> notification_result() async {


    await ApiClient().notification_property().then((data) {

      setLoading(false);
      if (data.statusCode == 200) {

print(json.decode(data.body));
        setnotifii(NotificationModel.fromJson(json.decode(data.body)));


      } else {

        Map<String, dynamic> result = json.decode(data.body);

      }


    });

    return isNotifi();
  }

  Future<bool> advance_Search_result(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool,sortdata) async {


    await ApiClient().advance_search_property(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool,sortdata).then((data) {
      setLoading(false);
      if (data.statusCode == 200) {

        setsearchlist(SearchModel.fromJson(json.decode(data.body)));
      } else {

        Map<String, dynamic> result = json.decode(data.body);
      }
    });

    return issearchlist();
  }
  Future<bool> fetchrooms() async {


    await ApiClient().rooms().then((data) {


      if (data.statusCode == 200) {

        setrooms(SearchAmeeResponse.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isAmmenity();
  }
  Future<bool> fetchbedrroms() async {


    await ApiClient().bedrooms().then((data) {


      if (data.statusCode == 200) {

        setrooms(SearchAmeeResponse.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isAmmenity();
  }
  Future<bool> fetchbathrooms() async {


    await ApiClient().bathrooms().then((data) {


      if (data.statusCode == 200) {

        setrooms(SearchAmeeResponse.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isAmmenity();
  }
  Future<bool> fetchterrace() async {


    await ApiClient().tarrce().then((data) {


      if (data.statusCode == 200) {

        setrooms(SearchAmeeResponse.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isAmmenity();
  }
  Future<bool> forgetpassword(email) async {


    await ApiClient().forget_pass(email).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  Future<bool> verifyotp(otp,email) async {


    await ApiClient().verifyotp(otp,email).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setOtp(VerifOtp.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isOTP();
  }
  Future<bool> verifyemailotp(otp,userid) async {


    await ApiClient().verifyemailotp(otp,userid).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  Future<bool> resenotp(email) async {


    await ApiClient().resend(email).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  Future<bool> new_password(email,newpass) async {


    await ApiClient().newpass(email,newpass).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  Future<bool> sendRequest(name,email,phone,description) async {


    await ApiClient().send_rquest(name,email,phone,description).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        print(data.body);
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  Future<bool> sendproperty_rquest(name,email,phone,description,location) async {


    await ApiClient().sendproperty_rquest(name,email,phone,description,location).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }


  Future<bool> save_favorite_property(property_id,region_name) async {


    await ApiClient().save_favorite_property(property_id,region_name).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }

  Future<bool> deltete_search(property_id) async {


    await ApiClient().delete_save_property(property_id).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
  Future<bool> save_search_property(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool) async {


    await ApiClient().save_search_property(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        print(data.body);
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
  Future<bool> update_search_property(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool,save_search_id,looking_for_name,property_type_nam,area_name,area_id) async {

print("${countryid+region_name+location_name+looking_for+property_type+plot_size_from+plot_size_to+living_space_from+living_space_to+rooms_from+rooms_to+bedroom_from+bedroom_to+bathroom_from+bathroom_to+tarrace_from+price_from+price_to+pageno+ region_name_real+aircondition+seaview+swimmingpool+save_search_id+looking_for_name+property_type_nam}");
    await ApiClient().update_search_property(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool,save_search_id,looking_for_name,property_type_nam,area_name,area_id).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
   Future<String> mainlanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String language1 = prefs.getString('language');

    switch (language1) {
      case 'en-GB':
        return 'en';
      case 'es-ES':
        return 'es';
      case 'de-DE':
        return 'de';
      default:
        return 'en';
    }
  }
  Future<bool> update_profile(user_name,user_email) async {


    await ApiClient().update_profile(user_name,user_email).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
  Future<bool> reset_password(oldpassword,newpassword) async {


    await ApiClient().reset_password(oldpassword,newpassword).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
  Future<bool> save_search(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool,looking_for_name,property_type_name,area_name,selectedareaid) async {


    await ApiClient().save_search(countryid,region_name,location_name,looking_for,property_type,plot_size_from,plot_size_to,living_space_from,living_space_to,rooms_from,rooms_to,bedroom_from,bedroom_to,bathroom_from,bathroom_to,tarrace_from,price_from,price_to, pageno, region_name_real,aircondition,seaview,swimmingpool,looking_for_name,property_type_name,area_name,selectedareaid).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        print(data.body);
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
  Future<bool> delete_favorite_property(property_id) async {


    await ApiClient().delete_favorite_property(property_id).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setFav(FavModel.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isFav();
  }
  Future<bool> fetchserch() async {


    await ApiClient().sizeofplot().then((data) {


      if (data.statusCode == 200) {

        setRange(SearchRangeModel.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isSearch();
  }

  Future<bool> fetchLiving() async {


    await ApiClient().livingspace().then((data) {


      if (data.statusCode == 200) {

        setliving(LivingResponse.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isliving();
  }

  Future<bool> fetchPriceRnge() async {


    await ApiClient().pricerange().then((data) {


      if (data.statusCode == 200) {

        setPriceRange(PriceRange.fromJson(json.decode(data.body)));

      } else {


        Map<String, dynamic> result = json.decode(data.body);

        setMessage(result['message']);
      }
    });

    return isprice();
  }
  Future<bool> signupUser(name,username,password,fcmToken) async {


    await ApiClient().signup(name,username,password,fcmToken).then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(LoginResponse.fromJson(json.decode(data.body)));

      } else {
        //print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }
  void setLoading(value) {
    loading = value;
    notifyListeners();
  }
  void setUser(value) {
    user = value;

    notifyListeners();
  }
  void setOtp(value) {
    otpverify = value;

    notifyListeners();
  }
  void setFav(value) {
    _favModel = value;

    notifyListeners();
  }
  void setRange(value) {
    searchRangeModel = value;

    notifyListeners();
  }
  void setliving(value) {
    livingResponse = value;

    notifyListeners();
  }
  void setrooms(value) {
    searchAmeeResponse = value;

    notifyListeners();
  }
  void setPriceRange(value) {
    _priceRange = value;

    notifyListeners();
  }
  void setcounty(value) {
    _allCountryModel = value;

    notifyListeners();
  }
  void setsearchlist(value) {
    searchModel = value;

    notifyListeners();
  }
  void savesearchlist(value) {
    saveSearchModel = value;

    notifyListeners();
  }
  void setpropertydetail(value) {
    _propertDetailModel = value;

    notifyListeners();
  }
  void setnotifii(value) {
    notificationModel = value;

    notifyListeners();
  }
  void setprofile(value) {
    profileShowModel = value;

    notifyListeners();
  }
  void setcount(value) {
    _countModel = value;

    notifyListeners();
  }
  bool isLoading() {
    return loading;
  }
  void setMessage(value) {
    errorMessage = value;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isUser() {
    return user != null ? true : false;
  }
  bool isOTP() {
    return otpverify != null ? true : false;
  }
  bool isNotifi() {
    return notificationModel != null ? true : false;
  }
  bool isCount() {
    return _countModel != null ? true : false;
  }
  bool isFav() {
    return _favModel != null ? true : false;
  }
  bool isSearch() {
    return searchRangeModel != null ? true : false;
  }
  bool isAmmenity() {
    return searchAmeeResponse != null ? true : false;
  }
  bool isliving() {
    return livingResponse != null ? true : false;
  }
  bool isprice() {
    return _priceRange != null ? true : false;
  }
  bool iscountry() {
    return _allCountryModel != null ? true : false;
  }
  bool issearchlist() {
    return searchModel != null ? true : false;
  }
  bool issavesearchlist() {
    return saveSearchModel != null ? true : false;
  }
  bool ispropertydetail() {
    return _propertDetailModel != null ? true : false;
  }
  bool isprofile() {
    return profileShowModel != null ? true : false;
  }
  LoginResponse getUSer() {
    return user;
  }
  VerifOtp getotpr() {
    return otpverify;
  }
  NotificationModel getNoti() {
    return notificationModel;
  }
  SearchRangeModel getsearch() {
    return searchRangeModel;
  }
  SearchAmeeResponse getAmmen() {
    return searchAmeeResponse;
  }
  LivingResponse getlivingspace() {
    return livingResponse;
  }
  PriceRange getpricerange() {
    return _priceRange;
  }
  AllCountryModel getcountry() {
    return _allCountryModel;
  }
  SearchModel getsearchresult() {
    return searchModel;
  }
  SaveSearchModel getsaveresult() {
    return saveSearchModel;
  }
  FavModel getfav() {
    return _favModel;
  }
  PropertDetailModel getpropertydetail() {
    return _propertDetailModel;
  }
  ProfileShowModel getprofile() {
    return profileShowModel;
  }
  CountModel getcount() {
    return _countModel;
  }
}