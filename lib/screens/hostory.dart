
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/models/weights.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class History extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

//write function with index
calculateDiference(WeightModel _model, index) {}

class _HistoryState extends State<History> {
  //setList for the history data
  List<Map<String, dynamic>> _historyList = [];

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getHistoryList() async {
    final uid = _auth.currentUser?.email;
   // print(uid);
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('weights')
        .orderBy('dateCreated', descending: true)
        .get();
   // print(data.docs.first.data());
    return data.docs;

  }

  @override
  void initState() {
    super.initState();
    //  getHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.insights_outlined),
        title: const Text("History"),
      ),
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
          future: getHistoryList(),
          builder: (context,
              AsyncSnapshot<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
                  snapshot) {
            // print(snapshot.data?["weights"]!);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                // TODO: Handle this case.
                break;
              case ConnectionState.waiting:
                return CircularProgressIndicator();
                break;
              case ConnectionState.active:
                // TODO: Handle this case.
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final data = snapshot.data;

                  snapshot.data
                      ?.map((e) => _historyList.add(e.data()))
                      .toList();

                  return ListView.builder(
                      itemCount: _historyList.length,
                      itemBuilder: (context, index) {
                         _historyList.length - 1 - index;
                        //sorting list order
                        if (index >= 1) {
                          WeightModel previousObject =
                              WeightModel.fromJson(_historyList[index - 1]);
                          WeightModel currentObject =
                              WeightModel.fromJson(_historyList[index]);
                      //    num? gain = previousObject.weightNo! + currentObject.weightNo!;
                           num? gain = currentObject.weightNo! - previousObject.weightNo!;
                          return HistoryListCard(currentObject, gain:gain);
                        }
                        return HistoryListCard( 
                            WeightModel.fromJson(_historyList[index]),
                            gain: 0,);
                      });
                }
                break;
            }

            return Text("No data");
          }),
    );
  }

  //getData from db

}

class HistoryListCard extends StatelessWidget {
  HistoryListCard(this._weightModel, {this.gain});

  final WeightModel _weightModel;

  num? gain = 0;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 8,
            shadowColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                Center(
                  child: Row(
                    children: [
                      const Text("Weight: ",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        " ${_weightModel.weightNo.toString()} Kg",
                        style: const TextStyle(
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
                Row(
                  children:   [
                    Text( gain! >= 0 ?
                      " Gained : "
                      : "Loss :",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$gain',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: gain! >= 0 ? 
                           Colors.blue
                           : Colors.red),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    const Text(
                      " Date : ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      //  " ${DateFormat.yMMMd().add_jm().format(_weightModel.dateCreated.toDate().toString()).toString()}",
                      "${DateFormat.yMMMd().add_jm().format(_weightModel.dateCreated!.toDate())}",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ]),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
    ;
  }
}
