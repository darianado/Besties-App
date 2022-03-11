import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_seg/models/User/UserData.dart';
import 'package:project_seg/models/profile_container.dart';

class FeedProfileManager {
  static Future<List<String>> getRecommendedUsers(String uid, int recs) async {
    HttpsCallable callable = FirebaseFunctions.instanceFor(region: 'europe-west2').httpsCallable('requestRecommendations');

    final resp = await callable.call(<String, dynamic>{
      'userId': uid,
      'recs': recs,
    });

    HashMap raw = HashMap.from(resp.data);

    List<String> uids = List<String>.from(raw['data']);

    return uids;
  }

  static Future<List<UserData>> getProfileData(String uid, int recs) async {
    List<String> uids = await getRecommendedUsers(uid, recs);

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get(); //TODO .filter by uids

    // Runtime type: List<HashMap<dynamic, dynamic>>
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList().map((e) => HashMap.from(e as Map)).toList();
    final users = querySnapshot.docs.map((doc) => UserData.fromSnapshot(doc as DocumentSnapshot<Map>)).toList();
    print("--- getProfile ---" + users.map((e) => e.firstName).toString());
    return users;
  }

  static Future<List<ProfileContainer>> getProfileContainers(String uid, int recs) async {
    List<UserData> data = await getProfileData(uid, recs);
    print("--- getContainers ---" + data.runtimeType.toString());
    return data
        .map((userData) => HashMap.from({"firstName": userData.firstName!, "lastName": userData.lastName!, "location": "London"}))
        .map((e) => ProfileContainer(profile: e))
        .toList();
  }
}
