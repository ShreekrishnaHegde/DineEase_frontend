import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  final notificationPlugin=FlutterLocalNotificationsPlugin();
  bool _isInitialized=false;
  bool get isInitialized=>_isInitialized;

  //Initialise
  Future<void> initNotification() async{
    //Preventing reinitialization
    const initSettingAndroid=AndroidInitializationSettings('@mipmap/ic_launcher');
    if(_isInitialized) return;
    //Init settings
    const initSettings=InitializationSettings(
      android: initSettingAndroid,
    );
    //Initiate the plugin
    await notificationPlugin.initialize(initSettings);
  }
  //Notification detail setup
  NotificationDetails notificationDetails(){
      return const NotificationDetails(
        android: AndroidNotificationDetails(
            'daily_channel_id',
            'Daily Notification',
          channelDescription: 'Daily Notification Channel',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        )
      );
  }
  Future<void> showNotification({
    int id=0,
    String? title,
    String? body,
})async{
    return notificationPlugin.show(id, title, body,  notificationDetails());
  }


}