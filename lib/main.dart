import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:kensington/pages/SplashScreen.dart';
import 'package:kensington/provider/LoginProvider.dart';
import 'package:kensington/utils/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
//final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
//BehaviorSubject<ReceivedNotification>();
//
//final BehaviorSubject<String> selectNotificationSubject =
//BehaviorSubject<String>();

const MethodChannel platform =
MethodChannel('dexterx.dev/flutter_local_notifications_example');

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}
final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");
void main() async {





  WidgetsFlutterBinding.ensureInitialized();
  final NotificationAppLaunchDetails notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('ken');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
//        didReceiveLocalNotificationSubject.add(ReceivedNotification(
//            id: id, title: title, body: body, payload: payload));
      });
  const MacOSInitializationSettings initializationSettingsMacOS =
  MacOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }

      }

  );
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'es', 'de']);


  runApp(

      MultiProvider(
        providers: [
//        FutureProvider(
//            create: (_) async => SliderProvider(),
//            lazy: false,
//        ),


          // Provider<LoginProvider>(create: (_) => LoginProvider()),
          ChangeNotifierProvider(create: (_) => LoginProvider()),

        ],
        child:  LocalizedApp(delegate, MyApp())
      )
  );
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(ColorConstant.kGreenColor);
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          //textSelectionColor: ColorConstant.kGreenColor,
          unselectedWidgetColor: ColorConstant.kGreenColor, // <-- your color
        ),
        home: SplashScreen(),
      ),
    );
  }
}
