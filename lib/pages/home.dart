import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_lift.dart';
import '../model/lift.dart';
import '../model/lifts_view_model.dart';
import '../repository/lifts_repository.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LiftsRepository repository = LiftsRepository();
  late final Lift lift;
  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(builder: (context, liftModel, child) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.title),
            leading:
                IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.deepPurple,
            shape: const CircularNotchedRectangle(),
            child: SizedBox(
                height: 60.0,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                              onPressed: () => {},
                              icon: const Icon(Icons.account_circle)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.list_sharp,
                              ))
                        ]))),
          ),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/pngegg.png'),
                    fit: BoxFit.fitHeight)),
            padding: const EdgeInsets.all(30),
            alignment: Alignment.topLeft,
            child: StreamBuilder(
                stream: repository.getStream(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const LinearProgressIndicator()
                      : ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            QueryDocumentSnapshot<Object?>? lifts =
                                snapshot.data?.docs[index];
                            return Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color.fromARGB(255, 59, 183, 255)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                              child: InkWell(
                                child: Row(children: <Widget>[
                                  Expanded(
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 16.0),
                                          child: Column(children: [
                                            Text('Derpature Date and time: ' +
                                                lifts!["departureDateTime"]),
                                            Text('Derpature place: ' +
                                                lifts["departurePlace"]),
                                            Text('Available seats: ' +
                                                lifts["passengers"]),
                                            Text(
                                              'Destination: ' +
                                                  lifts["destination"],
                                            )
                                          ])))
                                ]),
                                onTap: (() {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                          title:const Text("Confirm Lift"),
                                          content: const Text("Confirm you want to book this lift by OK."),
                                          actions: <Widget>[
                                            TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();},
                                              child: Container(
                                                padding: const EdgeInsets.all(14),
                                                child: const Text("OK")),),
                                                 TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();},
                                              child: Container(
                                                padding: const EdgeInsets.all(14),
                                                child: const Text("Cancel")),)]));
                                }),
                              ),
                            );
                          },
                        );
                }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _liftAdder();
            },
            tooltip: 'create lift',
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked);
    });
  }

  void _liftAdder() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const Addlift();
      },
    );
  }
}
