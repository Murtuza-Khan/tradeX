import '../resources/exports/index.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();

  final StreamController<FirebaseNotification>
      didReceiveLocalNotificationStream =
      StreamController<FirebaseNotification>.broadcast();

  static const String darwinNotificationCategoryText = 'textCategory';
  static const String darwinNotificationCategoryPlain = 'plainCategory';
  static const String navigationActionId = 'id_3';

  final List<DarwinNotificationCategory> darwinNotificationCategories =
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

  final _androidChannel = const AndroidNotificationChannel(
    "high_importance_channel",
    "High Importance Notification",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    Get.toNamed(Routes.LANDING);
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
          (NotificationResponse notificationResponse) {
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
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  Future<dynamic> initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      if (Platform.isAndroid) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@mipmap/ic_launcher',
              color: AppColors.primary,
            ),
          ),
          payload: jsonEncode(message.toMap()),
        );
      }
    });
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
