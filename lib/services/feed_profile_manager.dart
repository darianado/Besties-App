import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:project_seg/models/profile_container.dart';

class FeedProfileManager {
  static Future<HashMap> getRecommendedUsers(String uid, int recs) async {
    HttpsCallable callable =
        FirebaseFunctions.instanceFor(region: 'europe-west2')
            .httpsCallable('requestRecommendations');

    final resp = await callable.call(<String, dynamic>{
      'userId': uid,
      'recs': recs,
    });
    HashMap uids = HashMap.from(resp.data);
    return uids;
  }

  static Future<List<HashMap>> getProfileData(String uid, int recs) async {
    HashMap uids = await getRecommendedUsers(uid, recs);

    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await _collectionRef.get(); //TODO .filter by uids

    // Runtime type: List<HashMap<dynamic, dynamic>>
    final allData = querySnapshot.docs
        .map((doc) => doc.data())
        .toList()
        .map((e) => HashMap.from(e as Map))
        .toList();

    return allData;
  }

  // static List<ProfileContainer> getProfileContainers() {}
}
