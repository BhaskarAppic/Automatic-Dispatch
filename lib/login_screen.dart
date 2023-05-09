import 'package:flutter/material.dart';

import 'map_screen.dart';
import 'search_screen.dart';

TextEditingController vehicleController = TextEditingController();

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

  late double h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
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
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select vehicle no.';
                                }
                                return null;
                              },
                              onTap: () {
                                companycontroller.text.length > 2
                                    ? showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const SearchScreen())
                                    : Container();
                              }),
                          SizedBox(height: h * 0.05),
                          MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => const MapScreen()));
                              }
                            },
                            height: h * 0.0625,
                            minWidth: w * 1,
                            color: const Color(0xFF1c7fcc),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              "Login",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: h * 0.05),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }
}
