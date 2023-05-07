import 'package:collectar_admin/firebase/firebase_options.dart';

class FireOptions {
  static var dfOptions = DefaultFirebaseOptions.web;

  static Map<String, dynamic> toJson() => {
        'apiKey': dfOptions.apiKey,
        'appId': dfOptions.appId,
        'messagingSenderId': dfOptions.messagingSenderId,
        'projectId': dfOptions.projectId,
        'authDomain': dfOptions.authDomain,
        'databaseURL': dfOptions.databaseURL,
        'storageBucket': dfOptions.storageBucket,
        'measurementId': dfOptions.measurementId,
        'trackingId': dfOptions.trackingId,
        'deepLinkURLScheme': dfOptions.deepLinkURLScheme,
        'androidClientId': dfOptions.androidClientId,
        'iosClientId': dfOptions.iosClientId,
        'appGroupId': dfOptions.appGroupId
      };
}
