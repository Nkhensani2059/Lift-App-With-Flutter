import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

import '../firebase_options.dart';


///Contains the relevant lifts data for our views
class LiftsViewModel extends ChangeNotifier {
  LiftsViewModel() {
    init();
  }

  late String _date = '';
  late String _departurePlace = '';
  late String _destination = '';
  late String _passengers = '';

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  String get departurePlace => _departurePlace;
  String get destination => _destination;
  String get passenger => _passengers;
  String get departureDateTime => _date;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  set destination(String value) {
    if (value != _destination) {
      _destination = value;
      notifyListeners();
    }
  }

  set departureDateTime(String value) {
    if (value != _date) {
      _date = value;
      notifyListeners();
    }
  }

  set departurePlace(String value) {
    if (value != _departurePlace) {
      _departurePlace = value;
      notifyListeners();
    }
  }

  set passenger(String value) {
    if (value != _passengers) {
      _passengers = value;
      notifyListeners();
    }
  }

 
  //TODO keep track of loaded Lifts and notify views on changes
}
