import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../model/lift.dart';

/// Manages storing and retrieval of Lifts from Firebase
/// The idea is that you use a class like this in LiftsViewModel, instead of using FirebaseFirestore SDK directly from views
class LiftsRepository {
  var logger = Logger();

  final liftReference =
      FirebaseFirestore.instance.collection('lifts').withConverter<Lift>(
            fromFirestore: (snapshot, _) => Lift.fromJson(snapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );

  Stream<QuerySnapshot> getStream() {
    return liftReference.snapshots();
  }

  Future<void> addLift(Lift lift) async {
    logger.i('Adding new lift ${lift.toJson()}');
    await liftReference.add(lift);
  }

  Future<List<Lift>> getAvailableLifts() async {
    logger.i('Retrieving Available lifts');
    return liftReference
        .get()
        .then((snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
            onError: (e) {
      logger.e('Error trying to get lifts: $e', e);
    });
  }

  void updateLift(Lift lift) async {
    logger.i('Updating on available lift');
    await liftReference.doc(lift.referenceId).update(lift.toJson());
  }

  void deleteLift(Lift lift) async {
    logger.i('Deleting a lift');
    await liftReference.doc(lift.referenceId).delete();
  }

  //TODO: implement create, update and retrieve methods

}
