import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../model/lifts_view_model.dart';
import '../srs/authentication.dart';
import '../srs/widgets.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lifts'),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/pngegg.png'),
                  fit: BoxFit.fitHeight)),
          padding: const EdgeInsets.all(30),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Header("Hi there!👋"),
                  const SizedBox(height: 5),
                  const Paragraph(
                      "                      Get A fast and safe ride\n"
                      "from someone going to the same destination as yours\n"
                      "           or you can offer someone else a ride"),
                  const SizedBox(height: 35),
                  const Header("Get Started"),
                  const SizedBox(height: 20),
                  Expanded(
                      child: Consumer<LiftsViewModel>(
                    builder: (context, appState, _) => AuthFunc(
                        loggedIn: appState.loggedIn,
                        signOut: () {
                          FirebaseAuth.instance.signOut();
                        }),
                  ))
                ]),
          ),
        ));
  }
}
