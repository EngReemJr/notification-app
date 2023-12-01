

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NotificationHelper {
  NotificationHelper._();

  static NotificationHelper notificationHelper = NotificationHelper._();

  //static  SharedPreferences? prefs;
  static late String? token = '';

  getToken() async {
    token = (await FirebaseMessaging.instance!.getToken())!;
    //prefs = await SharedPreferences.getInstance();

    print('My token  :  ' + token.toString() + '\n');
    // prefs!.setString('MyToken', token.toString()!);
    saveToken(token!);
  }

  void saveToken(String token) async {
    var preferences = await SharedPreferences.getInstance();
    var tokenStored = preferences.getString('deviceToken') ?? '';
    if (tokenStored == '' || tokenStored != token) {

      try {
        preferences.setString('deviceToken',token) ;
        await FirebaseFirestore.instance.collection('UserTokens').add({
          'token': token,

        });
        print('your token saved succssefully');
      }
      catch (e) {

      }
    }
    Future<String> getTokenFromFireStore(String id) async {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection(
          'UserTokens').doc(id).get();
      String token = snap['token'];

      return token;
    }
    /* void sendPushMessage(String token , String body , String title , String id) async{
    try{
      await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          headers: <String , String>{
            'Content-Type' : 'application/json',
            'Authorization' : 'key=AAAAqGYBZ90:APA91bGocA7jDHWA1RfLF5G38mWSzDki_GQ0Du4urUZW07GeVsiN0ruPqZ3aq3noGUPP9FvkN7DwAhiVibMfNKkcdYC1Zh1iJZ4ag21uMD0gK_Is9FpSytRvUQVVV9850Hd_Ycq8cy2g'
          },
          body: jsonEncode(
              <String , dynamic>{
                'notification' :<String , dynamic>{
                  'body' : '$body%$id',
                  'title' : '$title'
                },
                'priority' : 'high',
                'data' :<String , dynamic>{
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'id' : '1',
                  'status' : 'done'
                },
                'to' : '$token'
              }
          )
      );

    }
    catch(e){
      print(e.toString());
    }
  }*/


  }
}
