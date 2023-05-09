// ignore_for_file: deprecated_member_use, constant_identifier_names, unnecessary_new, sort_child_properties_last, prefer_const_constructors, duplicate_ignore, prefer_final_fields, camel_case_types, annotate_overrides, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// import 'package:polyline/polyline.dart';
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng sourceLocation = LatLng(27.3622905, 75.5172417);
  static const LatLng destination = LatLng(26.8921693, 75.8127344);
  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDqcutfIh2MTB8Bheg2ExCqGoSELwfhvew", // Your Google Map Key
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
      setState(() {});
    }
  }

  late GoogleMapController mapController;
  ScrollController scrollController = ScrollController();

  // final LatLng _center = const LatLng(45.521563, -122.677433);
  // ignore: unused_element
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final _controller1 = ScrollController();
  final _controller2 = ScrollController();

  void initState() {
    _controller1.addListener(listener1);
    _controller2.addListener(listener2);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    getLocation();
    getPolyPoints();
    super.initState();
  }

  var _flag1 = false;
  var _flag2 = false;

  void listener1() {
    if (_flag2) return;
    _flag1 = true;
    _controller2.jumpTo(_controller1.offset);
    _flag1 = false;
  }

  void listener2() {
    if (_flag1) return;
    _flag2 = true;
    _controller1.jumpTo(_controller2.offset);
    _flag2 = false;
  }

  Location currentLocation = Location();
  Set<Marker> _markers = {};
  Set<Marker> _markersSource = {};
  Set<Marker> _markersDestination = {};
  void getLocation() async {
    currentLocation.onLocationChanged.listen((LocationData loc) {
      // mapController
      //     .animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
      //   target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
      //   zoom: 12.0,
      // )));
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('Home'),
            position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
        _markersSource.add(Marker(
            markerId: MarkerId('Source'),
            position: LatLng(37.33500926, -122.03272188)));
        _markersDestination.add(Marker(
            markerId: MarkerId('Destination'),
            position: LatLng(48.8561, 2.2930)));
      });
    });
  }

  final Set<Marker> markers = {
    // List of Markers Added on Google Map
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(27.3622905, 75.5172417),
        infoWindow: InfoWindow(
          title: 'Khatushyam mandir',
        )),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(26.8598173, 75.7618073),
        infoWindow: InfoWindow(
          title: 'Source',
        )),
    Marker(
        markerId: MarkerId('3'),
        position: LatLng(26.8921693, 75.8127344),
        infoWindow: InfoWindow(
          title: 'Destination',
        )),
  };
  // ignore: prefer_typing_uninitialized_variables
  var h, w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              // ignore: prefer_const_constructors
              child: Text(
                "LOGOUT",
                style: const TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.grey.shade400),
            ),
          )
        ],
        leadingWidth: 72,
        leading: Container(
          margin: EdgeInsets.only(left: w * 0.04),
          padding: const EdgeInsets.all(6),
          height: h * 0.08,
          width: w * 0.07,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30)),
          child: Image.asset(
            "assets/62873-map-computer-location-icon-icons-free-transparent-image-hd-thumb.png",
            // width: 5,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Ivanivanov",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 173, 23, 12),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            rotateGesturesEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(48.8561, 2.2930),
              zoom: 11.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: true,
            markers: markers,
            polylines: {
              Polyline(
                polylineId: const PolylineId("route"),
                points: polylineCoordinates,
                color: const Color(0xFF7B61FF),
                width: 6,
              ),
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                height: h * 0.35,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _controller2,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: w * .18,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'S. No.',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'PU Time',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'App Time',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'PU Address',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'DO Address',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Action',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Row 1 Col 1')),
                            DataCell(Text('Row 1 Col 2')),
                            DataCell(Text('Row 1 Col 3')),
                            DataCell(Text('Row 1 Col 4')),
                            DataCell(Text('Row 1 Col 5')),
                            DataCell(Text('Row 1 Col 6')),
                            DataCell(Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                                SizedBox(width: w * .02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Row 2 Col 1')),
                            DataCell(Text('Row 2 Col 2')),
                            DataCell(Text('Row 2 Col 3')),
                            DataCell(Text('Row 2 Col 4')),
                            DataCell(Text('Row 2 Col 5')),
                            DataCell(Text('Row 2 Col 6')),
                            DataCell(Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                                SizedBox(width: w * .02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Row 3 Col 1')),
                            DataCell(Text('Row 3 Col 2')),
                            DataCell(Text('Row 3 Col 3')),
                            DataCell(Text('Row 3 Col 4')),
                            DataCell(Text('Row 3 Col 5')),
                            DataCell(Text('Row 3 Col 6')),
                            DataCell(Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                                SizedBox(width: w * .02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Row 4 Col 1')),
                            DataCell(Text('Row 4 Col 2')),
                            DataCell(Text('Row 4 Col 3')),
                            DataCell(Text('Row 4 Col 4')),
                            DataCell(Text('Row 4 Col 5')),
                            DataCell(Text('Row 4 Col 6')),
                            DataCell(Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                                SizedBox(width: w * .02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Row 5 Col 1')),
                            DataCell(Text('Row 5 Col 2')),
                            DataCell(Text('Row 5 Col 3')),
                            DataCell(Text('Row 5 Col 4')),
                            DataCell(Text('Row 5 Col 5')),
                            DataCell(Text('Row 5 Col 6')),
                            DataCell((Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                                SizedBox(width: w * .02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                              ],
                            ))),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Row 6 Col 1')),
                            DataCell(Text('Row 6 Col 2')),
                            DataCell(Text('Row 6 Col 3')),
                            DataCell(Text('Row 6 Col 4')),
                            DataCell(Text('Row 6 Col 5')),
                            DataCell(Text('Row 6 Col 6')),
                            DataCell(Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Confirm',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                                SizedBox(width: w * .02),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * .015, vertical: w * .005),
                                  child: Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color:
                                        const Color.fromARGB(255, 173, 23, 12),
                                  ),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // ListView.builder(
                //   itemCount: 5,
                //   scrollDirection: Axis.horizontal,
                //   shrinkWrap: true,
                //   itemBuilder: (context, index) {
                //     return Container(
                //       margin: EdgeInsets.all(10),
                //       height: h * 0.4,
                //       width: 300,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Colors.white,
                //           boxShadow: [
                //             BoxShadow(blurRadius: 2, color: Colors.grey)
                //           ]),
                //       child: Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               "NAME:   livanivaov",
                //               style: TextStyle(
                //                   fontSize: 18, fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               height: h * 0.01,
                //             ),
                //             Text(
                //               " Pickup Time :",
                //               style: TextStyle(
                //                   fontSize: 18, fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               height: h * 0.01,
                //             ),
                //             Text(
                //               " Appointment Time :",
                //               style: TextStyle(
                //                   fontSize: 18, fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               height: h * 0.01,
                //             ),
                //             Text(
                //               "Pickup Address :",
                //               style: TextStyle(
                //                   fontSize: 18, fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               height: h * 0.01,
                //             ),
                //             Text(
                //               "Drop-Off Address: ",
                //               style: TextStyle(
                //                   fontSize: 18, fontWeight: FontWeight.bold),
                //             ),
                //             SizedBox(
                //               height: h * 0.02,
                //             ),
                //             Row(
                //               children: [
                //                 SizedBox(
                //                   width: w * 0.3,
                //                   child: ElevatedButton(
                //                       onPressed: () {}, child: Text("Tap")),
                //                 ),
                //                 SizedBox(
                //                   width: 20,
                //                 ),
                //                 SizedBox(
                //                   width: w * 0.3,
                //                   child: ElevatedButton(
                //                       onPressed: () {}, child: Text("Tap")),
                //                 ),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: h * .285),
            // padding: EdgeInsets.only(right: w * .08),
            // height: h * .4,
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _controller1,
              child: DataTable(
                horizontalMargin: w * .11,
                columnSpacing: w * .21,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'S. No.',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '      Name',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '      PU Time',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      '   App Time',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'PU Address',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'DO Address',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Action',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
                rows: const <DataRow>[],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
