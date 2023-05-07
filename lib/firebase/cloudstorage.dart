import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart';
import 'package:firebase_dart/storage.dart' as firedart;
import 'package:collectar_admin/main.dart';

class CloudStorage {
  // var accountCredentials = ServiceAccountCredentials.fromJson({
  //   "private_key_id": "02c2028d39ec6988acd58dcdc5a8b9407cb699d0",
  //   "private_key":
  //       "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCdqwekMCcVEhTY\noh1mW1inZk0KF2BjBF7h8BVinNqUaOLKsIJxDrljrWhsFDD6BH+/3ipvS6b3pll8\nH2r3hhfLZrrL3Vri7oKMgGFziVgpvLynGb+wv0NFnsy+x2NSTMpxS91ZZ6LIAEq1\n2Jh/yj9md3Vgfxb2qGTX5X/sEB+TVYOFUHEX+8/GsjZ4gSpC1T5uIe8OV2AQWYJJ\nefnZ024UEtS6Smh89mQWcntBMa0KwcF/q+5KXpAWm4HOBcks3ht+C6iUWTCacdJP\nKHXQpfamIh8wXdcj10Fr077gDjdre/sVduXd8W7MTFXP5SbcijQ538+k9XiGuKBU\nduITxYVbAgMBAAECggEADHFW5Qo3y13l70K79zv2Px+/rLAzlxzdMA92YJXoWhX8\n7+oGIU38K3Wf7Aeb5d89BbNOvgHGZ3zlSvpfwrD+Z7rvuu75ITeZbeUjy65nGsQe\nT0Gk8xnlATWLCvNJT1FoGJDYIxoeqpH7U2aIgm0/m6KJzNe6xDR94NvnwIV1OHdD\nXXajV1OTPQioS8LnYkGMcFpaMHuThAu0fzzUkuTZpoTT7KsbJbgjYrQVNeA/Il83\nHcWyS5S7K2Tt1LI4yxDSQKujbo5HE6pl0TdqFIdCOIKPjEA0ueF09At3mmWgjejH\ncvyXKALVkyNTz0HI7vFR6oR3qxP+UcBVe7fhjWbgoQKBgQDZ1FwcJdZKq13tm16x\nl7wpuGK94A0eCS20UO9bJLONk/DKQDOdG3HC6hBJ2GcepR+YuVbEm3Vpbu0kIs6C\nHfcN7rWtlW1fF4FTJC+k4UrLQ0QeTjRMOKCtz2aQai3zrDJMbhcj4Ed+faWxa+US\nAQuIF4WOKB9e34Yz+u1MqEl1TQKBgQC5S+F7p47r1T8IsdCL0N4lDIajrR0d0JCN\n3+zU+F7PgTK/wsyOwWFVM+73spGu74P9wx/mgG51pX+Ubm4+rc7VQdQYMIgmJ5fs\nFLx22k2R9L8dQTWSVs+uETgjR+Gz1QApOH+HKIdo+6YZq5fuA/iXWnaodunUd/G3\n+qISSZtxRwKBgBN7B2XJCHoTC0plm7lcLYq5n7MFZ4bpITpABrfq91fRBDbCORty\nyeC5mA1Smh5GfCXnZVgd4wkzz2ds6XT/gwmu8HZ+p5JagslRsiUXtN2qvVvMeKbc\nZZpFsxF1PXjOTI1DRzSBKUOprvjIAmtyxno8SEhnVC7i5JifdztkzXT9AoGATxEn\nBTnJja5v+EjP4Wld8Vc3+I29F+TQWgnMKFBXPJo3yoXX/a5c1xuTA9UJvyjrHJRv\nf08cU00sdGzu1AYcdPljBHNpFUbd19o9VUXvxbE2/8e8kVZDxlYIq11X3QGt0OkP\n2d+ccFq5VMjYyrKdGBB9A4PCYWxRE516HO2Vy68CgYAd2ljoeR5ZoN1xZ5BPaqdJ\nvGs17LVbP3/6HLdwiPzN4MVSYF35DtwS9eySk6m8f3PbXEStGLjoD4gZvaq/PkcM\nCDAYlQ4oNChEk0RWxlPamSCSZ5TVVP5IFEZ69dDy1Ue1+PYkTFy3oDHeTM2TmKNP\neHCMkEMYCjQ/ZIXbtJFGmQ==\n-----END PRIVATE KEY-----\n",
  //   "client_email":
  //       "firebase-adminsdk-li3r2@navbar-e51ee.iam.gserviceaccount.com",
  //   "client_id": "115560261843906195764",
  //   "type": "service_account"
  // });

  // var scopes = [
  //   'https://www.googleapis.com/auth/cloud-platform',
  // ];

  // uploadFile(File file, String parentFolder, String folderName, String filename,
  //     String contentType) async {
  //   var client = Client();
  //   AccessCredentials credentials =
  //       await obtainAccessCredentialsViaServiceAccount(
  //           accountCredentials, scopes, client);
  //   String accessToken = credentials.accessToken.data;

  //   var request = Request(
  //     'POST',
  //     Uri.parse(
  //         'https://storage.googleapis.com/upload/storage/v1/b/navbar-e51ee.appspot.com/o?uploadType=media&name=$parentFolder/$folderName/$filename'),
  //   );
  //   request.headers['Authorization'] = "Bearer $accessToken";
  //   request.headers['Content-Type'] = contentType;
  //   request.bodyBytes = await file.readAsBytes();

  //   Response response = await Response.fromStream(await request.send());

  //   client.close();

  //   var encodedImagePath =
  //       Uri.encodeQueryComponent('$parentFolder/$folderName/$filename');
  //   ;

  //   print(response.body);

  //   return 'https://storage.googleapis.com/storage/v1/b/navbar-e51ee.appspot.com/o/$encodedImagePath?alt=media&token=';
  // }

  uploadFile(
      File file, String folderName, String filename, String contentType) async {
    var storage = firedart.FirebaseStorage.instanceFor(app: app).ref();

    var storageRef = storage.child("$folderName/$filename$contentType");
    try {
      await storageRef.putData(await file.readAsBytes());
    } on FirebaseException catch (e) {
      print(e.message);
    }

    String url = await storageRef.getDownloadURL();
    return url;
  }
}
