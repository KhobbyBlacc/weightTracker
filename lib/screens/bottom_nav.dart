
import 'package:flutter/material.dart';
import 'package:weight_tracker/screens/hostory.dart';
import 'package:weight_tracker/screens/insights.dart';
import 'package:weight_tracker/screens/my_aacount.dart';


class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

//list of NavItems
enum BottomsIcons {
  home,
  history,
  userAcc,
}

class _BottomNavState extends State<BottomNav> {
  BottomsIcons bottomsIcons = BottomsIcons.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      //calling Fragments from the bottomNav
      bottomsIcons == BottomsIcons.home
          ? Center(
              child: Insights(),
            )
          : Container(),
      bottomsIcons == BottomsIcons.history
          ? Center(
              child: History(),
            )
          : Container(),
      bottomsIcons == BottomsIcons.userAcc
          ?   UserAccount()
             
          : Container(),
      Align(
        alignment: Alignment.bottomCenter,
         child: Container(
              padding: const EdgeInsets.only(top:10, bottom: 10, left: 2),
              height: 60,
               decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green,
              )
            ],
          ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomsIcons = BottomsIcons.home;
                      });
                    },
                    child: bottomsIcons == BottomsIcons.home
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.home,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Icon(Icons.home_outlined, 
                        color: Colors.white,),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomsIcons = BottomsIcons.history;
                      });
                    },
                    child: bottomsIcons == BottomsIcons.history
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children:const [
                                Icon(
                                    Icons.insights_outlined,
                                    color: Colors.green,
                                
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "History",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Icon(Icons.insights_outlined, 
                        color: Colors.white),
                  ),
                  
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomsIcons = BottomsIcons.userAcc;
                      });
                    },
                    child: bottomsIcons == BottomsIcons.userAcc
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.green.shade100.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.person_add_outlined,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Account",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          )
                        :const Icon(Icons.person_add_outlined, 
                        color: Colors.white),
                  ),
                ],
              ),
            ),
        ),

    ]));
  }
}
