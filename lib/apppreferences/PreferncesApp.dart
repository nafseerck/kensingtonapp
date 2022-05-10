import 'package:shared_preferences/shared_preferences.dart';

class PreferencesApp{
  savePrefernses(String id,String mobile) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id',id );
    await prefs.setString('mobile',mobile );
    await prefs.setString('language',"en-GB" );

  }
  savelanguage(String lang) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language',lang );

  }
  langSelected(bool isselect) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isselected',isselect );

  }
  savenotifiArrived(bool isselect) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notification_arr',isselect );

  }
  savePrefernsestutorialscreen(bool isfirst) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('first_time', isfirst);




  }
  loadPrefernces () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userid = prefs.getString('id');
  }
  removePrefenses() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('mobile');
    prefs.remove('language');

  }
}