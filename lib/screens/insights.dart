import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weight_tracker/models/weights.dart';
import 'package:weight_tracker/screens/home.dart';

class Insights extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Insights({Key? key}) : super(key: key);

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  WeightModel _weightModel = WeightModel();

  final TextEditingController _addWeight = TextEditingController();

  late Map<String, dynamic> _historyList;
  Future getCurrentData() async {
    final uid = FirebaseAuth.instance.currentUser?.email;
    // print(uid);
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('weights')
        .orderBy('dateCreated', descending: true)
        .get();
    print(data.docs.first.data());
    return data.docs;
  }

  @override
  void initState() {
    super.initState();
  }

  final uid = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.bar_chart_outlined),
        title: const Text("Home"),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
          future: getCurrentData(),
          builder: (context, AsyncSnapshot snapshot) {
            List data = snapshot.data;
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 8,
                      shadowColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(children: [
                          Center(
                            child: Row(
                              children: [
                                Text("Current Weight: ",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${data[0].data()['weightNo']} kg",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text('Add New Weight'),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          controller: _addWeight,
                                          decoration: const InputDecoration(
                                            labelText: 'Weight Number',
                                            icon: Icon(Icons.account_box),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: ElevatedButton(
                                        child: const Text("Submit"),
                                        onPressed: () {
                                          Map<String, dynamic> data = {
                                            "weightNo":
                                                num.parse(_addWeight.text),
                                            "dateCreated": Timestamp.now(),
                                          };
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(uid)
                                              .collection('weights')
                                              .add(data);

                                          Fluttertoast.showToast(
                                              msg: "Weight Added ");

                                          setState(() {});

                                  Navigator.pop(context);
                                        }),
                                  )
                                ],
                              );
                            });
                      },
                      child: const Text(
                        "Add New Weight",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ],
                ),
              );
            }
            return Center(
                child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text('Add New Weight'),
                        content: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: _addWeight,
                                  decoration: const InputDecoration(
                                    labelText: 'Weight Number',
                                    icon: Icon(Icons.account_box),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          Center(
                            child: ElevatedButton(
                                child: const Text("Submit"),
                                onPressed: () {
                                  Map<String, dynamic> data = {
                                    "weightNo": num.parse(_addWeight.text),
                                    "dateCreated": Timestamp.now(),
                                  };
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .collection('weights')
                                      .add(data);

                                  Fluttertoast.showToast(msg: "Weight Added ");

                                  Navigator.pop(context);

                                  setState(() {});
                                }),
                          )
                        ],
                      );
                    });
              },
              child: const Text(
                "Add New Weight",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ));
          }),
    );
  }
}
