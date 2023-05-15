import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:providerapp/search_vehicle_model.dart';
import 'dart:convert';
import 'map_screen.dart';
import 'search_screen.dart';

Map<String, dynamic> map = {};

TextEditingController vehicleController = TextEditingController();
// List<SearchVehicleModel> vehicleNumbers = [];
List<String> vehicleNumbers = [];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController companycontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late double h, w;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
        _onFocusChange); // searchListApi(companycontroller.text.toString().trim());
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      // Call your function when the TextFormField gets focus
      print('TextFormField focused');
    } else {
      // Call your function when the TextFormField loses focus
      searchListApi();
    }
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
              height: h * 1,
              width: w * 1,
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: h * 0.1),
                  const Text(
                    "Login to your account",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: h * 0.025),
                  Container(
                      width: w * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 15,
                                color: Colors.black.withOpacity(0.2)),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: h * 0.03125),
                            const Text(
                              "Company Code",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              keyboardAppearance: Brightness.light,
                              cursorWidth: w * 0.00277,
                              cursorColor: const Color(0xff848484),
                              controller: companycontroller,
                              focusNode: _focusNode,
                              onChanged: (value) {
                                map["CompCode"] = value;
                              },
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.5),
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: w * 0.0277),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Company Code",
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff848484),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter company code';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: h * 0.03125),
                            const Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              textCapitalization: TextCapitalization.words,
                              keyboardAppearance: Brightness.light,
                              cursorWidth: w * 0.00277,
                              cursorColor: const Color(0xff848484),
                              controller: namecontroller,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  letterSpacing: 0.5),
                              onChanged: (value) {
                                // searchListApi();
                                map["UserName"] = value;
                              },
                              // keyboardType:TextInputType.visiblePassword ,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: w * 0.0277),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Name",
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff848484),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                  )),

                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: h * 0.03125),
                            const Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              obscureText: true,
                              obscuringCharacter: "*",
                              keyboardAppearance: Brightness.light,
                              cursorWidth: w * 0.00277,
                              cursorColor: const Color(0xff848484),
                              controller: passwordcontroller,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  letterSpacing: 2),
                              onChanged: (value) {
                                map["Password"] = value;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: w * 0.0277),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Enter Password",
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff848484),
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: h * 0.03125),
                            const Text(
                              "Vehicle No.",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                                readOnly: true,
                                keyboardAppearance: Brightness.light,
                                cursorWidth: w * 0.00277,
                                cursorColor: const Color(0xff848484),
                                controller: vehicleController,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    letterSpacing: 1.5),
                                decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(left: w * 0.0277),
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Select Vehicle No.",
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff848484),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select vehicle no.';
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  // vehicleNumbers.clear();
                                  // await searchListApi();

                                  companycontroller.text.length > 2
                                      // ignore: use_build_context_synchronously
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              const SearchScreen())
                                      : const SizedBox();
                                }),
                            SizedBox(height: h * 0.05),
                            MaterialButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print("map ===========> $map");

                                  loginApi();
                                }
                              },
                              height: h * 0.0625,
                              minWidth: w * 1,
                              color: const Color(0xFF1c7fcc),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: isLoading
                                  ? const CircularProgressIndicator.adaptive(
                                      strokeWidth: 1,
                                      backgroundColor: Colors.white,
                                    )
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                            ),
                            SizedBox(height: h * 0.05),
                          ],
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }

  void loginApi() async {
    const url = 'http://adambulette.com/WebService.asmx/driverlogin';

    // Define the request body as a Map
    final data = {
      'UserName': namecontroller.text.toString().trim(),
      'Password': passwordcontroller.text.toString().trim(),
      'CompCode': companycontroller.text.toString().trim(),
      'VehicleId': int.parse(vehicleController.text.toString().trim())
    };

    // Convert the data to JSON
    final jsonData = jsonEncode(data);

    // Create the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the response JSON
      final jsonResponse = jsonDecode(response.body);

      // Access the required fields from the response
      final result = jsonResponse['d'];
      final id = result['Id'];
      final firstName = result['FirstName'];
      final lastName = result['LastName'];
      final status = result['status'];
      final message = result['message'];
      if (result['status'] == 's') {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const MapScreen()));
      }

      // Print the response data
      print('Id: $id');
      print('First Name: $firstName');
      print('Last Name: $lastName');
      print('Status: $status');
      print('Message: $message');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  // loign API
  // Future<dynamic> loginApi() async {
  //   String message = "";
  //   isLoading = true;
  //   String jsonMap = jsonEncode(map);
  //   var res = await http
  //       .post(Uri.parse("http://adambulette.com/WebService.asmx/driverlogin"),
  //           body: jsonMap)
  //       .then((value) {
  //     print("value ==================> ${value.statusCode}");
  //     print("map ===========> $jsonMap");
  //   });

  //   if (res.statusCode == 200) {
  //     isLoading = false;
  //     var data = jsonDecode(res.body);

  //     if (data['d']['status'] == "s") {
  //       isLoading = false;
  //       message = data['d']['message'];
  //       // ignore: use_build_context_synchronously
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (ctx) => const MapScreen()));
  //       setState(() {});
  //     } else {
  //       isLoading = false;
  //       debugPrint(message);
  //       setState(() {});
  //     }
  //   } else {
  //     isLoading = false;
  //     setState(() {});
  //   }
  // }

  // //search list API
  // Future<dynamic> searchListApi(String compCode) async {
  //   String message = "";
  //   print("*******************");

  //   // isLoading = true;
  //   var res = await http.post(
  //       Uri.parse(
  //           "http://adambulette.com/WebService.asmx/getVehicleByCompCode"),
  //       body: {
  //         "CompCode": compCode,
  //       });
  //   print("=====================");

  //   // if (res.statusCode == 200) {
  //   print("object");

  //   var data = jsonDecode(res.body);
  //   print("data =====> $data");

  //   if (data['d']['status'].toString() == "s") {
  //     isLoading = false;
  //     message = data['d']['message'];
  //     List vehicleList = data['d']['VehicleList'] as List;

  //     print("vehicle list ===========================> $vehicleList");

  //     for (var element in vehicleList) {
  //       vehicleNumbers.add(element);
  //     }

  //     print("list ===============> ${vehicleNumbers.length}");
  //     // for (int i = 0; i < vehicleList.length; i++) {
  //     //   vehicleNumbers.add(vehicleList[i]['Name']);
  //     // }

  //     setState(() {});
  //   } else {
  //     isLoading = false;
  //     debugPrint(message);
  //     setState(() {});
  //   }
  //   // } else {
  //   //   isLoading = false;
  //   //   setState(() {});
  //   // }
  // }

  searchListApi() async {
    const url = 'http://adambulette.com/WebService.asmx/getVehicleByCompCode';

    // Define the request body as a Map
    final data = {'CompCode': "330001"};

    // Convert the data to JSON
    final jsonData = jsonEncode(data);

    // Create the POST request
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonData,
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Parse the response JSON
      final jsonResponse = jsonDecode(response.body);

      // Access the required fields from the response
      final result = jsonResponse['d'];
      final vehicleList = result['VehicleList'];
      if (result['status'] == 's') {
        // Iterate through the vehicleList
        for (var vehicle in vehicleList) {
          final id = vehicle['Id'];
          final name = vehicle['Name'];

          // Print the vehicle details
          print('Id: $id');
          print('Name: $name');

          vehicleNumbers.add(name);
        }
        print(vehicleNumbers);
      }
      print(vehicleNumbers);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}
