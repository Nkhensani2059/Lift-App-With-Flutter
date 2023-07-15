// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';


import 'model/lift.dart';
import 'model/lifts_view_model.dart';
import 'repository/lifts_repository.dart';

class Addlift extends StatefulWidget {
  const Addlift({Key? key}) : super(key: key);

  @override
  _AddliftState createState() => _AddliftState();
}

class _AddliftState extends State<Addlift> {
  late LiftsViewModel liftsViewModel = LiftsViewModel();
  late LiftsRepository repository = LiftsRepository();
  final TextEditingController _departurePlaceController = TextEditingController();
  final TextEditingController _departureDateTimeController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _passengersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Add lift'),
        content: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            TextFormField(
                controller: _departurePlaceController,
                decoration: const InputDecoration(
                  labelText: 'Departure Place')),
            TextFormField(
                controller:  _departureDateTimeController,
                decoration: const InputDecoration(
                    hintText: 'dd-mm-yyyy  00:00', labelText: 'DateTime')),
            TextFormField(
                controller:   _passengersController,
                decoration: const InputDecoration(
                  hintText: 'Enter number of passengers',
                  labelText: 'Seats',
                )),
            TextFormField(
                controller:  _destinationController,
                decoration: const InputDecoration(
                  hintText: 'Enter address and town',
                  labelText: 'Destination',
                )),
          ],
        )),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                final newLift = Lift(
                  departureDateTime: liftsViewModel.departureDateTime =  _departureDateTimeController.text ,
                  destination: liftsViewModel.destination = _destinationController.text,
                  departurePlace: liftsViewModel.departurePlace =
                     _departurePlaceController.text,
                  passengers: liftsViewModel.passenger = _passengersController.text,
                );

                repository.addLift(newLift);

                Navigator.of(context).pop();
              },
              child: const Text('Add')),
        ]);
  }

  @override
  void dispose() {
    _departureDateTimeController.dispose();
    _departurePlaceController.dispose();
    _destinationController.dispose();
    _passengersController.dispose();
    super.dispose();
  }
}
