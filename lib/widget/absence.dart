import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techsolution/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:techsolution/service/auth_service.dart';
import 'package:techsolution/view/main_page.dart';

class AbsencePage extends StatefulWidget {
  const AbsencePage({super.key});

  @override
  State<AbsencePage> createState() => _AbsencePageState();
}

class _AbsencePageState extends State<AbsencePage> {
  bool isLoading = true;
  Map<String, dynamic> userData = {};
  Map<String, dynamic> presensiData = {};
  Map<String, dynamic> hariIni = {};
  Map<String, dynamic> riwayat = {};

  void fetchData() async {
    Map<String, dynamic> user = await AuthUser().getUser();
    setState(() {
      userData = user;
    });
  }

  void datapresensi() async {
    Map<String, dynamic> presensi = await AuthUser().getpresensi();
    setState(() {
      presensiData = presensi;
      if (presensiData['data'] is List<dynamic>) {
        final List<dynamic> filteredData = presensiData['data']
            .where((data) => data['is_hari_ini'] == true)
            .toList();
        if (filteredData.isNotEmpty) {
          final Map<String, dynamic> hariIniData = filteredData.first;
          final tanggal = hariIniData['tanggal'];
          final jamMasuk = hariIniData['jam_masuk'];
          final jamKeluar = hariIniData['jam_keluar'];
          hariIni = {
            'tanggal': tanggal,
            'jam_masuk': jamMasuk,
            'jam_keluar': jamKeluar
          };
        }
        riwayat = {};
        for (final riwayatData in presensiData['data']) {
          final tanggal = riwayatData['tanggal'];
          final jamMasuk = riwayatData['jam_masuk'];
          final jamKeluar = riwayatData['jam_keluar'];
          if (riwayatData['is_hari_ini'] == false) {
            riwayat[tanggal] = {
              'tanggal': tanggal,
              'jam_masuk': jamMasuk,
              'jam_keluar': jamKeluar
            };
          }
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    datapresensi();
    loadData();
  }

  void loadData() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppTheme.secondaryColor,
            ))
          : WillPopScope(
              onWillPop: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
                return true;
              },
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['user']?['nama'] ?? '',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 400,
                        decoration:
                            const BoxDecoration(color: AppTheme.secondaryColor),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('${hariIni['tanggal'] ?? '-'}',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 16,
                                      color: AppTheme.textColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Text("${hariIni['jam_masuk'] ?? '-'}",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: AppTheme.textColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                      Text("Masuk",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: AppTheme.textColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                          hariIni['jam_keluar'] == null
                                              ? '-'
                                              : "${hariIni['jam_keluar']}",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: AppTheme.textColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                      Text("Pulang",
                                          style: GoogleFonts.poppins(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              color: AppTheme.textColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text("Riwayat Presensi",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 16,
                              color: AppTheme.textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: riwayat.length,
                          itemBuilder: (context, index) {
                            final tanggal = riwayat.keys.elementAt(index);
                            final data = riwayat[tanggal];
                            return Card(
                              color: AppTheme.thirdColor,
                              child: ListTile(
                                leading: Text("${data['tanggal']}",
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                title: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("${data['jam_masuk']}",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: AppTheme.textColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                        Text("Masuk",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: AppTheme.textColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      children: [
                                        Text("${data['jam_keluar']}",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: AppTheme.textColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                        Text("Pulang",
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: AppTheme.textColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                    ]),
              ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () {
          Navigator.pushNamed(context, '/detail-absence');
        },
        child: const Icon(
          CupertinoIcons.location_solid,
        ),
      ),
    );
  }
}
