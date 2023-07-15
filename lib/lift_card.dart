

import 'package:flutter/material.dart';



import 'package:flutter/material.dart';

import 'model/lift.dart';



class LiftRoom extends StatelessWidget {
  final Lift lift;

  const LiftRoom({super.key, required this.lift});



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(lift.departurePlace),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body:Text("LIft Full details")
      ),
    );
  }
}