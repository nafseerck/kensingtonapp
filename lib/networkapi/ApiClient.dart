import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static final String url = 'http://wp13320458.server-he.de/app/api/';

  static final String BASE_URL = 'https://www.kensington-international.com/';
  static final String Last_IMAGE_URL =
      '/297e70ee-a34e-4e6f-945f-3d1b913b7fd1.jpg';

  Future<http.Response> fetchUser(email, password, fcmToken) {
    return http.post(url + 'login.php',
        body: {"email": email, "password": password, "gcm_token": fcmToken});
  }

  Future<http.Response> forget_pass(email) {
    return http.post(url + 'forgotpassword.php', body: {"email": email});
  }

  Future<http.Response> verifyotp(otp, email) {
    return http.post(url + 'verifyotp.php', body: {"email": email, "otp": otp});
  }

  Future<http.Response> verifyemailotp(otp, userid) async {
    return http.post(url + 'email_verified.php',
        body: {"user_id": userid, "otp": otp});
  }

  Future<http.Response> resend(email) async {
    return http.post(url + 'resend_email_otp.php', body: {"email": email});
  }

  Future<http.Response> newpass(email, new_password) {
    return http.post(url + 'changepassword.php',
        body: {"email": email, "new_password": new_password});
  }

  Future<http.Response> send_rquest(name, email, phone, description) {
    return http.post(url + 'sendrequest.php', body: {
      "full_name": name,
      "email": email,
      "phone_number": phone,
      "message": description
    });
  }

  Future<http.Response> sendproperty_rquest(
      name, email, phone, description, location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    return http.post(url + 'sell_property_request.php', body: {
      "name": name,
      "email": email,
      "mobile": phone,
      "message": description,
      "location": location,
      "user_id": userid
    });
  }

  Future<http.Response> save_favorite_property(property_id, region_name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');
    return http.post(url + 'save_favorite_property.php', body: {
      "property_id": property_id,
      "user_id": userid,
      "language": lang == null ? "es-ES" : lang,
      "region_name": region_name
    });
  }

  Future<http.Response> notification_count() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');

    return http.post(url + 'bell_icon_status.php', body: {"user_id": userid});
  }

  Future<http.Response> delete_save_property(property_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');

    return http.post(url + 'delete_save_search.php',
        body: {"save_search_id": property_id});
  }

  Future<http.Response> update_search_property(
      countryid,
      region_name,
      location_name,
      looking_for,
      property_type,
      plot_size_from,
      plot_size_to,
      living_space_from,
      living_space_to,
      rooms_from,
      rooms_to,
      bedroom_from,
      bedroom_to,
      bathroom_from,
      bathroom_to,
      tarrace_from,
      price_from,
      price_to,
      pageno,
      region_name_real,
      aircondition,
      seaview,
      swimmingpool,
      save_search_id,
      looking_for_name,
      property_type_nam,
      area_name,
      area_id) async {
    //print("${countryid+region_name+location_name+looking_for+property_type+plot_size_from+plot_size_to+living_space_from+living_space_to+rooms_from+rooms_to+bedroom_from+bedroom_to+bathroom_from+bathroom_to+tarrace_from+price_from+price_to+pageno+ region_name_real+aircondition+seaview+swimmingpool+""+looking_for_name+property_type_nam}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');
    return http.post(url + 'update_save_search.php', body: {
      "country_id": countryid,
      "region_id": region_name,
      "location_name": location_name,
      "looking_for": looking_for,
      "property_type": property_type,
      "plot_size_from": plot_size_from != null ? plot_size_from : '',
      "plot_size_to": plot_size_to != null ? plot_size_to : '',
      "living_space_from": living_space_from != null ? living_space_from : '',
      "living_space_to": living_space_to != null ? living_space_to : '',
      "rooms_from": rooms_from != null ? rooms_from : '',
      "rooms_to": rooms_to != null ? rooms_to : '',
      "bedroom_from": bedroom_from != null ? bedroom_from : '',
      "bedroom_to": bedroom_to != null ? bedroom_to : '',
      "terrace": tarrace_from != null
          ? tarrace_from
          : tarrace_from != null
              ? tarrace_from
              : '',
      "air_condition": aircondition != null ? aircondition : "",
      "sea_view": seaview != null ? seaview : '',
      "swimming_pool": swimmingpool != null ? swimmingpool : '',
      "price_from": price_from != null ? price_from : '',
      "price_to": price_to != null ? price_to : '',
      "user_id": userid,
      "language": lang == null ? "en-GB" : lang,
      "pageno": pageno,
      "region_name": region_name_real,
      "bathroom_from": bathroom_from != null ? bathroom_from : '',
      "bathroom_to": bathroom_to != null ? bathroom_to : '',
      "save_search_id": save_search_id,
      "looking_for_name": looking_for_name,
      "property_type_name": property_type_nam,
      "area_name": area_name,
      "area_id": area_id
    });
  }

  Future<http.Response> update_profile(user_name, user_email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');

    return http.post(url + 'update_profile.php', body: {
      "user_name": user_name,
      "user_id": userid,
      "user_email": user_email
    });
  }

  Future<http.Response> reset_password(oldpassword, newpassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');

    return http.post(url + 'reset_password.php', body: {
      "old_password": oldpassword,
      "user_id": userid,
      "new_password": newpassword
    });
  }

  Future<http.Response> save_search(
      countryid,
      region_name,
      location_name,
      looking_for,
      property_type,
      plot_size_from,
      plot_size_to,
      living_space_from,
      living_space_to,
      rooms_from,
      rooms_to,
      bedroom_from,
      bedroom_to,
      bathroom_from,
      bathroom_to,
      tarrace_from,
      price_from,
      price_to,
      pageno,
      region_name_real,
      aircondition,
      seaview,
      swimmingpool,
      looking_for_name,
      property_type_nam,
      area_name,
      selectedareaid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('id');

    String lang = prefs.getString('language');

    return http.post(url + 'save_search.php', body: {
      "country_id": countryid,
      "region_id": region_name,
      "location_name": location_name,
      "looking_for": looking_for,
      "property_type": property_type,
      "plot_size_from": plot_size_from != null ? plot_size_from : '',
      "plot_size_to": plot_size_to != null ? plot_size_to : '',
      "living_space_from": living_space_from != null ? living_space_from : '',
      "living_space_to": living_space_to != null ? living_space_to : '',
      "rooms_from": rooms_from != null ? rooms_from : '',
      "rooms_to": rooms_to != null ? rooms_to : '',
      "bedroom_from": bedroom_from != null ? bedroom_from : '',
      "bedroom_to": bedroom_to != null ? bedroom_to : '',
      "terrace": tarrace_from != null
          ? tarrace_from
          : tarrace_from != null
              ? tarrace_from
              : '',
      "air_condition": aircondition != null ? aircondition : "",
      "sea_view": seaview != null ? seaview : '',
      "swimming_pool": swimmingpool != null ? swimmingpool : '',
      "price_from": price_from != null ? price_from : '',
      "price_to": price_to != null ? price_to : '',
      "user_id": userid,
      "language": lang == null ? "es-ES" : lang,
      "pageno": '1',
      "region_name": region_name_real,
      "bathroom_from": bathroom_from != null ? bathroom_from : '',
      "bathroom_to": bathroom_to != null ? bathroom_to : '',
      "looking_for_name": looking_for_name,
      "property_type_name": property_type_nam,
      'area_name': area_name,
      'area_id': selectedareaid
    });
  }

  Future<http.Response> delete_favorite_property(property_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');
    return http.post(url + 'change_favorite_property.php', body: {
      "property_id": property_id,
      "user_id": userid,
      "language": lang == null ? "en-GB" : lang
    });
  }

  Future<http.Response> signup(name, email, password, fcmToken) {
    return http.post(url + 'signup.php', body: {
      "kng_nutzername": name,
      "email": email,
      "password": password,
      "gcm_token": fcmToken
    });
  }

  Future<http.Response> sizeofplot() {
    return http.get(url + "sizeofplot.php");
  }

  Future<http.Response> rooms() {
    return http.get(url + "rooms.php");
  }

  Future<http.Response> bedrooms() {
    return http.get(url + "bedrooms.php");
  }

  Future<http.Response> bathrooms() {
    return http.get(url + "bathrooms.php");
  }

  Future<http.Response> tarrce() {
    return http.get(url + "terrace.php");
  }

  Future<http.Response> livingspace() {
    return http.get(url + "sizeoflivingspace.php");
  }

  Future<http.Response> pricerange() {
    return http.get(url + "pricerange.php");
  }

  Future<http.Response> fetchall_country() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');
    print(lang);
    // return http.post(url + 'all_country.php', body: {"language":lang==null?"en-GB":lang});
    return http.post(
        url + "all_country.php",
        body: {"language": lang == null ? "en-GB" : lang});
  }

  Future<http.Response> fetch_looking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');
    return http.post(url + 'get_looking_for.php',
        body: {"language": lang == null ? "en-GB" : lang});
  }

  Future<http.Response> fetch_property(country_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');

    return http.post(url + 'property_type.php', body: {
      "language": lang == null ? "en-GB" : lang,
      "country_id": country_id
    });
  }

  Future<http.Response> fetch_region(countryid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');
    return http.post(url + 'get_regions.php', body: {
      "country_id": countryid,
      "language": lang == null ? "en-GB" : lang
    });
  }

  Future<http.Response> fetch_location(countryid, regionid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');
    return http.post(url + 'all_loactions.php', body: {
      "country_id": countryid,
      "region_id": regionid,
      "language": lang == null ? "en-GB" : lang
    });
  }

  Future<http.Response> fetch_location_forarea(
      countryid, regionid, area_id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');
    return http.post(url + 'get_location_according_region.php', body: {
      "area_id": area_id,
      "country_id": countryid,
      "region_id": regionid,
      "language": lang == null ? "en-GB" : lang
    });
  }

  Future<http.Response> fetch_area() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('language');
    return http.post(url + 'get_area.php',
        body: {"language": lang == null ? "en-GB" : lang});
  }

  Future<http.Response> search_property(
      String countryid,
      String region_name,
      String location_name,
      String looking_for,
      String property_type,
      String pageno,
      String region_name_real,
      sort_data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('id');

    String lang = prefs.getString('language');

    return http.post(url + 'search_property.php', body: {
      "country_id": countryid,
      "region_id": region_name,
      "location_name": location_name,
      "looking_for": looking_for,
      "property_type": property_type,
      "user_id": userid,
      "language": lang == null ? "en-GB" : lang,
      "pageno": pageno,
      "region_name": region_name_real,
      "sort": sort_data
    });
  }

  Future<http.Response> search_quick(quick_seach_value, pageno, sortid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('id');

    String lang = prefs.getString('language');

    return http.post(url + 'quick_search.php', body: {
      "language": lang == null ? "en-GB" : lang,
      "user_id": userid,
      "quick_seach_value": quick_seach_value,
      "pageno": pageno,
      "sort": sortid
    });
  }

  Future<http.Response> fav_property() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');
    print('user' + userid);
    print("lamg" + lang);
    return http.post(url + 'get_favorite_property.php',
        body: {"user_id": userid, "language": lang == null ? "en-GB" : lang});
  }

  Future<http.Response> user_profile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');

    return http.post(url + 'user_profile.php', body: {"user_id": userid});
  }

  Future<http.Response> detail_property(propertyid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');

    return http.post(url + 'property_details.php', body: {
      "user_id": userid,
      "language": lang == null ? "en-GB" : lang,
      "vt_objektnr_extern": propertyid
    });
  }

  Future<http.Response> saved_property() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('id');
    String lang = prefs.getString('language');

    return http.post(url + 'get_save_search.php',
        body: {"user_id": userid, "language": lang == null ? "en-GB" : lang});
  }

  Future<http.Response> notification_property() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('id');

    return http.post(url + 'notifications.php', body: {"user_id": userid});
  }

  Future<http.Response> advance_search_property(
      countryid,
      region_name,
      location_name,
      looking_for,
      property_type,
      plot_size_from,
      plot_size_to,
      living_space_from,
      living_space_to,
      rooms_from,
      rooms_to,
      bedroom_from,
      bedroom_to,
      bathroom_from,
      bathroom_to,
      tarrace_from,
      price_from,
      price_to,
      pageno,
      region_name_real,
      aircondition,
      seaview,
      swimmingpool,
      sort_data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');
    return http.post(url + 'advancesearch.php', body: {
      "country_id": countryid,
      "region_id": region_name,
      "location_name": location_name,
      "looking_for": looking_for,
      "property_type": property_type,
      "plot_size_from": plot_size_from != null ? plot_size_from : '',
      "plot_size_to": plot_size_to != null ? plot_size_to : '',
      "living_space_from": living_space_from != null ? living_space_from : '',
      "living_space_to": living_space_to != null ? living_space_to : '',
      "rooms_from": rooms_from != null ? rooms_from : '',
      "rooms_to": rooms_to != null ? rooms_to : '',
      "bedroom_from": bedroom_from != null ? bedroom_from : '',
      "bedroom_to": bedroom_to != null ? bedroom_to : '',
      "terrace": tarrace_from != null
          ? tarrace_from
          : tarrace_from != null
              ? tarrace_from
              : '',
      "air_condition": aircondition != null ? aircondition : "",
      "sea_view": seaview != null ? seaview : '',
      "swimming_pool": swimmingpool != null ? swimmingpool : '',
      "price_from": price_from != null ? price_from : '',
      "price_to": price_to != null ? price_to : '',
      "user_id": userid,
      "language": lang == null ? "en-GB" : lang,
      "pageno": pageno,
      "region_name": region_name_real,
      "bathroom_from": bathroom_from != null ? bathroom_from : '',
      "bathroom_to": bathroom_to != null ? bathroom_to : '',
      "sort": sort_data
    });
  }

  Future<http.Response> save_search_property(
      countryid,
      region_name,
      location_name,
      looking_for,
      property_type,
      plot_size_from,
      plot_size_to,
      living_space_from,
      living_space_to,
      rooms_from,
      rooms_to,
      bedroom_from,
      bedroom_to,
      bathroom_from,
      bathroom_to,
      tarrace_from,
      price_from,
      price_to,
      pageno,
      region_name_real,
      aircondition,
      seaview,
      swimmingpool) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
    String lang = prefs.getString('language');
    return http.post(url + 'save_search.php', body: {
      "country_id": countryid,
      "region_id": region_name,
      "location_name": location_name,
      "looking_for": looking_for,
      "property_type": property_type,
      "plot_size_from": plot_size_from != null ? plot_size_from : '',
      "plot_size_to": plot_size_to != null ? plot_size_to : '',
      "living_space_from": living_space_from != null ? living_space_from : '',
      "living_space_to": living_space_to != null ? living_space_to : '',
      "rooms_from": rooms_from != null ? rooms_from : '',
      "rooms_to": rooms_to != null ? rooms_to : '',
      "bedroom_from": bedroom_from != null ? bedroom_from : '',
      "bedroom_to": bedroom_to != null ? bedroom_to : '',
      "terrace": tarrace_from != null
          ? tarrace_from
          : tarrace_from != null
              ? tarrace_from
              : '',
      "air_condition": aircondition != null ? aircondition : "",
      "sea_view": seaview != null ? seaview : '',
      "swimming_pool": swimmingpool != null ? swimmingpool : '',
      "price_from": price_from != null ? price_from : '',
      "price_to": price_to != null ? price_to : '',
      "user_id": userid,
      "language": lang == null ? "en-GB" : lang,
      "pageno": pageno,
      "region_name": region_name_real,
      "bathroom_from": bathroom_from != null ? bathroom_from : '',
      "bathroom_to": bathroom_to != null ? bathroom_to : ''
    });
  }
}
