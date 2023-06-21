import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:techsolution/theme.dart';
import 'package:techsolution/service/auth_service.dart';

class DetailAbsenPage extends StatefulWidget {
  const DetailAbsenPage({super.key});

  @override
  State<DetailAbsenPage> createState() => _DetailAbsenPageState();
}

class _DetailAbsenPageState extends State<DetailAbsenPage> {
  Future<LocationData?> _currenctLocation() async {
    bool serviceEnable;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnable = await location.serviceEnabled();

    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  Map<String, dynamic> userData = {};
  void fetchData() async {
    Map<String, dynamic> user = await AuthUser().getUser();
    setState(() {
      userData = user;
    });
  }

  void completeedit() {
    Navigator.popAndPushNamed(context, '/absen-page');
  }

  handlepresensi() async {
    LocationData? currentLocation = await _currenctLocation();
    var data = {
      'latitude': currentLocation!.latitude.toString(),
      'longitude': currentLocation.longitude.toString(),
    };
    var res = await AuthUser().postPresensi(data);
    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
      print(res.body);
      completeedit();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.secondaryColor,
        title: Text("ABSENSI",
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 20,
                color: AppTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppTheme.primaryColor,
      body: FutureBuilder<LocationData?>(
          future: _currenctLocation(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final LocationData currentLocation = snapshot.data;
              return SafeArea(
                  child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: SfMaps(
                      layers: [
                        MapTileLayer(
                            initialFocalLatLng: MapLatLng(
                              currentLocation.latitude!,
                              currentLocation.longitude!,
                            ),
                            initialZoomLevel: 15,
                            initialMarkersCount: 1,
                            urlTemplate:
                                "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                            markerBuilder: (BuildContext context, int index) {
                              return MapMarker(
                                latitude: currentLocation.latitude!,
                                longitude: currentLocation.longitude!,
                                child: const Icon(Icons.location_on,
                                    color: Colors.red, size: 40),
                              );
                            }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      handlepresensi();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.secondaryColor),
                        textStyle: MaterialStateProperty.all(
                          const TextStyle(
                            fontSize: 20,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(16))),
                    child: Text("Simpan Presensi",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ],
              ));
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppTheme.secondaryColor,
              ));
            }
          }),
    );
  }
}
