// ignore_for_file: no_logic_in_create_state, unused_element

import 'package:flutter/material.dart';
import 'login_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();

  final duplicateItems = List<String>.generate(10000, (i) => "Vehicle no. $i");
  var items = <String>[];
  bool isLoading = false;

  // @override
  // void initState() {
  //   // items = duplicateItems;
  //   super.initState();
  // }

  // void filterSearchResults(String query) {
  //   if (query.isNotEmpty) {
  //     items.clear();
  //   }

  //   String stringPart = "";
  //   String numberPart = "";
  //   bool flag = false;
  //   if (int.parse(query) <= 10000) {
  //     for (var item in duplicateItems) {
  //       stringPart = item.substring(0, 12);
  //       numberPart = item.substring(12);
  //       for (int digit = 0; digit < query.length; digit++) {
  //         if (query[digit] == numberPart[digit] &&
  //             query.length <= numberPart.length) {
  //           flag = true;
  //         } else {
  //           flag = false;
  //           break;
  //         }
  //       }
  //       if (flag) {
  //         setState(() {
  //           items.add(stringPart + numberPart);
  //         });
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin:
            const EdgeInsets.only(left: 30, right: 30, top: 300, bottom: 10),
        child: Column(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     maxLength: 2,
            //     autofocus: true,
            //     keyboardType: TextInputType.number,
            //     onChanged: (value) {
            //       // filterSearchResults(value);
            //       value;
            //     },
            //     controller: editingController,
            //     decoration: const InputDecoration(
            //         counterText: "",
            //         labelText: "Search",
            //         hintText: "Search",
            //         prefixIcon: Icon(Icons.search),
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            //   ),
            // ),
            Expanded(
                child: vehicleNumbers.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: vehicleNumbers.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(vehicleNumbers[index]),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: const Text('Vehicle no. Selection'),
                                  content: Text(
                                      "Are you sure you want to select vehicle no. ${vehicleNumbers.elementAt(index)}"),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 173, 23, 12)),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        vehicleController.text =
                                            vehicleNumbers.elementAt(index);
                                        map["VehicleId"] =
                                            vehicleNumbers.elementAt(index);

                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 173, 23, 12)),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: const Text(
                                        "No",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.popUntil(
                                            context, (route) => route.isFirst);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Container()),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 25.0),
        child: TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                  width: 1, color: Color.fromARGB(255, 173, 23, 12)),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Close",
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
