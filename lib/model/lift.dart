

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

/// Use this class to represent a Lift
class Lift {
  final String departureDateTime ;
  String departurePlace;
  String destination;
  String passengers;

  String? referenceId;

  Lift(
      {
      required this.departureDateTime,
      required this.destination,
      required this.departurePlace,
      required this.passengers,
      this.referenceId, });

 
  Lift.fromJson(Map<String, Object?> jsonMap ) 
      : this(
      departureDateTime:(jsonMap['departureDateTime'] as String),
      departurePlace: jsonMap['departurePlace'] as String,
      destination: jsonMap['destination'] as String,
      passengers: jsonMap['passengers'] as String,
      
  );

  factory Lift.fromSnapshot(DocumentSnapshot snapshot) {
    final newLift = Lift.fromJson(snapshot.data() as Map<String, Object?>);
    newLift.referenceId = snapshot.reference.id;
    return newLift;
  }
 
  Map<String, Object?> toJson() {
    return {
      'departureDateTime': departureDateTime,
      'departurePlace': departurePlace,
      'destination': destination,
      'passengers': passengers
    };
  }


  @override
  String toString() {
    return 'Lift{departureDateTime: $departureDateTime, departurePlace: $departurePlace,destination: $destination,passengers: $passengers}';
  }
}
