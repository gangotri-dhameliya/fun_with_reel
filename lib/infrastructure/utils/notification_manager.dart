import 'dart:math' as math;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reels_app/infrastructure/constant/storage_constants.dart';
import 'package:reels_app/infrastructure/storage/shared_preference_service.dart';

// class NotificationManager {
//   static FlutterLocalNotificationsPlugin downloadNotification =
//       FlutterLocalNotificationsPlugin();
//
//   // static List<NotificationImageModel> imageFileList = [];
//
//   static initNotification() async {
//     downloadNotification = FlutterLocalNotificationsPlugin();
//
//     AndroidInitializationSettings androidSetting =
//         const AndroidInitializationSettings("@mipmap/ic_launcher");
//     DarwinInitializationSettings iosSetting = const DarwinInitializationSettings();
//
//     InitializationSettings flutterSetting =
//         InitializationSettings(android: androidSetting, iOS: iosSetting);
//
//     await downloadNotification.initialize(
//       flutterSetting,
//       // onDidReceiveNotificationResponse: (details) {
//       //   debugPrint("Clicked!! ${imageFileList[imageFileList.indexWhere((element) => element.id == details.id)].filePath}");
//       //   OpenFile.open(imageFileList[imageFileList.indexWhere((element) => element.id == details.id)].filePath);
//       // },
//     );
//   }
//
//   static void showCompleteNotification({required String filePath}) async {
//     int id = math.Random().nextInt(10000);
//     // imageFileList.add(NotificationImageModel(filePath: filePath, id: id));
//     await requestNotificationPermissions();
//     // final bigPicturePath = await downloadFile(
//     //   url,
//     //   'bigPicture',
//     // );
//     // await ImageGallerySaver.saveImage(
//     //   File(filePath).readAsBytesSync(),
//     //     quality: 100,
//     //     name: fileName,
//     // );
//
//     final styleInformation = BigPictureStyleInformation(FilePathAndroidBitmap(filePath));
//
//     AndroidNotificationDetails android = AndroidNotificationDetails(
//         "1", "android",
//         priority: Priority.high,
//         importance: Importance.max,
//         playSound: true,
//         enableVibration: true,
//         styleInformation: styleInformation);
//
//     DarwinNotificationDetails ios = const DarwinNotificationDetails();
//
//     NotificationDetails complete =
//         NotificationDetails(android: android, iOS: ios);
//
//     await downloadNotification.show(
//         id, "", "Your Wallpaper Downloaded", complete);
//   }
//
//   static void showRingtoneNotification({required String filePath}) async {
//     int id = math.Random().nextInt(10000);
//     // imageFileList.add(NotificationImageModel(filePath: filePath, id: id));
//     await requestNotificationPermissions();
//
//     AndroidNotificationDetails android = const AndroidNotificationDetails(
//         "1", "android",
//         priority: Priority.high,
//         importance: Importance.max,
//         playSound: true,
//         enableVibration: true);
//
//     DarwinNotificationDetails ios = const DarwinNotificationDetails();
//
//     NotificationDetails complete =
//         NotificationDetails(android: android, iOS: ios);
//
//     await downloadNotification.show(
//         id, "", "Your Ringtone Downloaded", complete);
//   }
//
//   static Future<String> downloadFile(String url, String fileName) async {
//     final directory = await getTemporaryDirectory();
//     final filePath = "${directory.path}/$fileName";
//     final response = await http.get(Uri.parse(url));
//     final file = File(filePath);
//
//     await file.writeAsBytes(response.bodyBytes);
//
//     return filePath;
//   }
//
//   static Future<void> requestNotificationPermissions() async {
//     final PermissionStatus status = await Permission.notification.request();
//     if (status.isGranted) {
//       debugPrint("Notification Permission granted");
//     } else if (status.isDenied) {
//       debugPrint("Notification Permission denied");
//       await Permission.notification.request();
//     } else if(status.isRestricted){
//       openAppSettings();
//     }
//   }
// }
//
// class NotificationImageModel {
//   String filePath;
//   int id;
//
//   NotificationImageModel({
//     required this.filePath,
//     required this.id,
//   });
// }

class NotificationManager {

  static init(){
    AwesomeNotifications().initialize(null, [
      NotificationChannel(
        locked: true,
        channelKey: 'reels_app',
        channelName: 'Reels Scheduler',
        defaultColor: const Color(0xff020202),
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'Description',
      ),
      NotificationChannel(
        locked: true,
        channelKey: 'scheduled',
        channelName: 'Wallpaper Scheduler',
        defaultColor: const Color(0xff020202),
        importance: NotificationImportance.High,
        channelShowBadge: true,
        channelDescription: 'Description',
      ),
    ]);
  }

  static showCompletedNotification({required String category,required String filePath}) async{
    int id = math.Random().nextInt(100000);
    Get.closeAllSnackbars();
    bool notificationEnable =await SharedPreferenceService.getBoolValue(StorageConstants.showNotificationKey)??true;

    if(notificationEnable)
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'reels_app',
        title: "Download Reels",
        body: "Your $category",
        notificationLayout: NotificationLayout.BigPicture,
        wakeUpScreen: true,
        displayOnBackground: true,
        bigPicture: "file://$filePath"
      ),
    );
  }

  @pragma('vm:entry-point')
  static  Future<void> createElevenAMNotification() async {
    // await requestNotificationPermissions();
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) async{
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        await AwesomeNotifications().requestPermissionToSendNotifications();

        await AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 11,
            channelKey: 'reels_app',
            title: "Reels title",
            body: "Reels data",
            notificationLayout: NotificationLayout.Default,
            category: NotificationCategory.Reminder,
            wakeUpScreen: true,
            displayOnBackground: true,
          ),
          actionButtons: [
            // NotificationActionButton(
            //   key: 'MARK_DONE',
            //   label: 'Pill Taken',
            // ),
          ],
          schedule: NotificationCalendar(
              hour: 11,
              minute: 0,
              second: 0,
              millisecond: 0,
              repeats: true
          ),
        );
      }
    });
  }

  // @pragma('vm:entry-point')
  // static  Future<bool> scheduleNotification(int id,TimeOfDay time, DateTime day, String title, String icon) async {
  //   try{
  //     return await AwesomeNotifications().createNotification(
  //       content: NotificationContent(
  //         id: id,
  //         channelKey: 'scheduled',
  //         title: title,
  //         largeIcon: icon,
  //         category: NotificationCategory.Reminder,
  //         notificationLayout: NotificationLayout.Default,
  //         wakeUpScreen: true,
  //         displayOnBackground: true,
  //         autoDismissible: false,
  //       ),
  //       actionButtons: [
  //         // NotificationActionButton(
  //         //   key: 'MARK_DONE',
  //         //   label: 'Pill Taken',
  //         // )
  //       ],
  //       schedule: NotificationCalendar(
  //         year: day.year,
  //         month: day.month,
  //         day: day.day,
  //         hour: time.hour,
  //         minute: time.minute,
  //         second: 0,
  //         millisecond: 0,
  //       ),
  //     );
  //   }catch(e){
  //     log("=================>$e");
  //     return false;
  //   }
  // }
  //
  // @pragma('vm:entry-point')
  // static  Future<bool> scheduleWeeklyNotification(int id,TimeOfDay time, int day, String title, String icon) async {
  //
  //   return await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: id,
  //       channelKey: 'wallpaper_app',
  //       title: title,
  //       // body: "It's time to take a pill",
  //       category: NotificationCategory.Reminder,
  //       notificationLayout: NotificationLayout.Default,
  //       wakeUpScreen: true,
  //       displayOnBackground: true,
  //     ),
  //     actionButtons: [
  //       // NotificationActionButton(
  //       //   key: 'MARK_DONE',
  //       //   label: 'Pill Taken',
  //       // )
  //     ],
  //     schedule: NotificationCalendar(
  //       hour: time.hour,
  //       minute: time.minute,
  //       second: 0,
  //       millisecond: 0,
  //       weekday: day,
  //       repeats: true,
  //     ),
  //   );
  // }

  static  Future<void> cancelScheduledNotification(int id,) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  static Future<void> requestNotificationPermissions() async {
    final PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      debugPrint("Notification Permission granted");
    } else if (status.isDenied) {
      debugPrint("Notification Permission denied");
      await Permission.notification.request();
    } else if(status.isRestricted){
      openAppSettings();
    }
  }

}
