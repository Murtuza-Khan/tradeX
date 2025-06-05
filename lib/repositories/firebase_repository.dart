import '../resources/exports/index.dart';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin _backLocalNotifications =
    FlutterLocalNotificationsPlugin();

final androidChannel = const AndroidNotificationChannel(
  "high_importance_channel",
  "High Importance Notification",
  description: "This channel is used for important notifications",
  importance: Importance.defaultImportance,
);

Future<(String, Map<String, dynamic>?)> getInitNotif() async {
  (String, Map<String, dynamic>?) data =
      ((AuthManager.instance.isLoggedIn ? Routes.LANDING : Routes.LOGIN), null);

  if (data.$1 == Routes.LANDING) {
    Get.lazyPut(() => LandingController(), fenix: true);
    await LandingController.instance.getNotificationCount();
  }
  return data;
}

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  CustomLogger.configure();
  await GetStorage.init(Strings.CACHE_BOX_KEY);
  await GetStorage.init().then(
    (value) async {
      await Get.putAsync(() async => AuthManager(), permanent: true);
      await Get.putAsync(
        () async => ConnectivityStreamService(),
        permanent: true,
      );
    },
  );

  await _initializeFlutterLocalNotifications();

  final title = message.data['title'] ?? 'Delta';
  final body = message.data['body'] ?? 'New message';
  final imageUrl = message.data['image'];

  AndroidNotificationDetails androidDetails;

  if (imageUrl != null && imageUrl.isNotEmpty) {
    final bigPicturePath = await FirebaseApi.downloadAndSaveFile(
      imageUrl,
      'bigImage.jpg',
    );

    androidDetails = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      icon: '@mipmap/ic_launcher',
      largeIcon: FilePathAndroidBitmap(bigPicturePath),
      styleInformation: BigTextStyleInformation(body),
      color: AppColors.primary,
    );
  } else {
    androidDetails = AndroidNotificationDetails(
      androidChannel.id,
      androidChannel.name,
      channelDescription: androidChannel.description,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(body),
      color: AppColors.primary,
    );
  }

  await _backLocalNotifications.show(
    DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title,
    body,
    NotificationDetails(android: androidDetails),
    payload: jsonEncode(message.data),
  );
}

Future<void> _initializeFlutterLocalNotifications() async {
  final ios = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
    notificationCategories: FirebaseApi.darwinNotificationCategories,
  );

  const android = AndroidInitializationSettings('@mipmap/ic_launcher');
  final settings = InitializationSettings(android: android, iOS: ios);

  await _backLocalNotifications.initialize(settings);
}

void backgroundNotificationHandler(NotificationResponse notificationResponse) {
  FirebaseApi.selectNotificationStream.add(notificationResponse.payload);
  final message = RemoteMessage.fromMap(
    jsonDecode(notificationResponse.payload!),
  );

  FirebaseApi.handleMessage(message);
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  static final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  final StreamController<FirebaseNotification>
      didReceiveLocalNotificationStream =
      StreamController<FirebaseNotification>.broadcast();

  static const String darwinNotificationCategoryText = 'textCategory';
  static const String darwinNotificationCategoryPlain = 'plainCategory';
  static const String navigationActionId = 'id_3';

  static final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  final _localNotifications = FlutterLocalNotificationsPlugin();

  static void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    if (AuthManager.instance.isLoggedIn) {
      Get.toNamed(Routes.LANDING);
    } else {
      Get.toNamed(Routes.LOGIN);
    }
  }

  Future initLocalNotifications() async {
    final ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: darwinNotificationCategories,
    );

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: ios);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            final message = RemoteMessage.fromMap(
              jsonDecode(notificationResponse.payload!),
            );
            handleMessage(message);
            break;
          case NotificationResponseType.selectedNotificationAction:
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: backgroundNotificationHandler,
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(androidChannel);
  }

  Future<void> initPushNotification() async {
    if (Platform.isIOS) {
      await toggleIosForgroundNotification(false);
      await Future.delayed(Durations.long1);
    }

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) async {
      if (AuthManager.instance.isLoggedIn) {
        Get.lazyPut(() => LandingController(), fenix: true);
        await LandingController.instance.getNotificationCount();
      }

      final title = message.data['title'] ?? 'Delta';
      final body = message.data['body'] ?? 'New essage';
      final imageUrl = message.data['image'];

      // ---------- ANDROID ----------
      if (Platform.isAndroid) {
        AndroidNotificationDetails androidDetails;

        if (imageUrl != null && imageUrl.isNotEmpty) {
          final bigPicturePath = await downloadAndSaveFile(
            imageUrl,
            'bigImage.jpg',
          );

          androidDetails = AndroidNotificationDetails( 
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@mipmap/ic_launcher',
            largeIcon: FilePathAndroidBitmap(bigPicturePath),
            color: AppColors.primary,
            styleInformation: BigTextStyleInformation(body),
          );
        } else { 
          androidDetails = AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@mipmap/ic_launcher',
            color: AppColors.primary,
            styleInformation: BigTextStyleInformation(body),
          );
        }

        await _localNotifications.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title,
          body,
          NotificationDetails(android: androidDetails),
          payload: jsonEncode(message.toMap()),
        );
      }

      // ---------- iOS ----------
      if (Platform.isIOS) {
        String? attachmentPath;
        if (imageUrl != null && imageUrl.isNotEmpty) {
          try {
            attachmentPath =
                await downloadAndSaveFile(imageUrl, 'ios_image.jpg');
          } catch (e) {
            MacLog.printR("Failed to download image for iOS: $e");
          }
        }

        final iosDetails = DarwinNotificationDetails(
          attachments: attachmentPath != null
              ? [DarwinNotificationAttachment(attachmentPath)]
              : null,
        );

        final platformChannelSpecifics = NotificationDetails(iOS: iosDetails);

        await toggleIosForgroundNotification(true);

        await _localNotifications.show(
          DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title,
          body,
          platformChannelSpecifics,
          payload: jsonEncode(message.toMap()),
        );
        await Future.delayed(Durations.long1);
        await toggleIosForgroundNotification(false);
      }
    });
  }

  Future<void> toggleIosForgroundNotification(bool value) async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: value,
      badge: value,
      sound: value,
    );
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<bool> initNotification() async {
    try {
      String? fcmToken;
      _firebaseMessaging.requestPermission();
      fcmToken = await _firebaseMessaging.getToken();
      AuthManager.instance.saveDeviceToken(fcmToken);
      log.f("FCM TOKEN :: ${AuthManager.instance.deviceToken}");
      await initPushNotification();
      await initLocalNotifications();
      return true;
    } catch (e) {
      MacLog.printR(e);
      return false;
    }
  }
}
