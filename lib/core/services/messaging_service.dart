import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_support_pack/flutter_support_pack.dart';

import 'app_state_service.dart';

abstract class BaseMessaging {
  void initialize();

  void initNotificationStream();

  Future<String?> getToken();

  void dispose();
}

class MessagingService implements BaseMessaging {
  static const TAG = 'MessagingService';
  final _firebaseMessaging = FirebaseMessaging.instance;

//  final _notificationStream = BehaviorSubject<AppNotification>();

  String? _token;
  late AppStateService _stateService;

  static final MessagingService _singleton = MessagingService._internal();

  factory MessagingService(AppStateService stateService) {
    _singleton._stateService = stateService;
    return _singleton;
  }

  MessagingService._internal();

  @override
  void initialize() async {
    Log.i(TAG, '>>>>>>>> INITIALIZING NOTIFICATIONS <<<<<<<<',
        references: ['initialize']);

    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     debugPrint("onMessage: $message");
    //     _handleMessage(message);
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     _handleMessage(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     _handleMessage(message);
    //   },
    // );

    var settings = await _firebaseMessaging.requestPermission(
        sound: true, alert: true, badge: true);

    Log.d(TAG, 'User granted permission: ${settings.authorizationStatus}',
        references: ['initialize']);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _firebaseMessaging.onTokenRefresh.listen(
        (token) async {
          print('Firebase Token Refreshed: $token');
          var state = await _stateService.getAuthState();
          //TODO
          // if (state == AuthState.SignedIn) _authRepo.updateDeviceId(token);
        },
      );

      FirebaseMessaging.onMessage.listen((message) {
        //TODO handle notification message, there are whole new set of features
      });
    }
  }

  @override
  Future<String?> getToken() async {
    if (_token == null) _token = await _firebaseMessaging.getToken();
    print('Firebase Token: $_token');
    return _token;
  }

  void _handleMessage(Map<String, dynamic> message) {
//    try {
//      RawNotificationEntity notification =
//          RawNotificationEntity.fromJson(json.decode(json.encode(message)));
//
//      print(notification.data.receivedTime);
//
//      AppNotification event;
//      if (Platform.isAndroid) {
//        switch (int.tryParse(notification.data.notificationType)) {
//          case 1:
//            event = AppNotification(NotificationType.NEW_BOOKING, 'NEW BOOKING',
//                data: notification);
//            break;
//        }
//      } else {
////        switch (num.tryParse(message['notificationType'])) {
////          case 4: //picked by domex
////            event = Notification(
////                NotificationType.ORDER_PICKED, message['order_status'],
////                data: message);
////            break;
////          case 5: //agent accept
////            event = Notification(
////                NotificationType.ORDER_ACCEPTED, message['order_status'],
////                data: message);
////            break;
////          case 6: //weight updated
////            event = Notification(
////                NotificationType.ORDER_UPDATED, "Weight has been updated",
////                data: message);
////            break;
////          case 7: //delivery completed
////            event = Notification(
////                NotificationType.ORDER_DELIVERED, message['order_status'],
////                data: message);
////            break;
////          case 101:
////            event = Notification(
////                NotificationType.FIREBASE, message['order_status'],
////                data: message);
////            break;
////          case 1:
////            event = Notification(NotificationType.TEST, 'Test Notification',
////                data: message);
////            break;
////        }
//      }
//
//      print('Has notification listeners ${_notificationStream.hasListener}');
//
//      if (event != null) {
//        _notificationStream.add(event);
//      }
//    } catch (e) {
//      print('error => $e');
//    }
  }

  @override
  void initNotificationStream() async {
    var state = await _stateService.getAuthState();
//    if (!_notificationStream.hasListener &&
//        state == AuthState.SignedIn) {
//      print('>>>>>> LISTENING TO NOTIFICATIONS <<<<<<');
//      _notificationStream.stream
//          .listen((event) => _notificationEventHandler(event));
//    }
  }

//  void _notificationEventHandler(AppNotification event) {
//    try {
//      switch (event.type) {
//        case NotificationType.NEW_BOOKING:
//          var notification = event.data as RawNotificationEntity;
//          _navigationService.navigatorKey.currentState
//              .pushNamed(Router.newBooking, arguments: notification.data);
//          break;
//        case NotificationType.BOOKING_CANCEL:
//          // TODO: Handle this case.
//          break;
//      }
//    } catch (e) {
//      print(e);
//      _crashlytics?.logError(_TAG, e.toString(), '_notificationEventHandler');
//    }
//  }

  @override
  void dispose() {
//    _notificationStream.close();
  }
}
