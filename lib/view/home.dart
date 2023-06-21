import 'package:flutter/material.dart';
import 'package:techsolution/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime? lastPressedTime;

class _HomePageState extends State<HomePage> {
  List imageList = [
    {"id": 1, "image_path": 'assets/slide1.png'},
    {"id": 2, "image_path": 'assets/slide2.png'},
    {"id": 3, "image_path": 'assets/slide3.png'},
    {"id": 4, "image_path": 'assets/1.png'},
    {"id": 5, "image_path": 'assets/2.png'},
    {"id": 6, "image_path": 'assets/3.png'},
    {"id": 7, "image_path": 'assets/4.png'},
    {"id": 8, "image_path": 'assets/5.png'},
  ];

  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget carousel() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(300),
          child: Column(
            children: [
              Stack(
                children: [
                  InkWell(
                      onTap: () {},
                      child: CarouselSlider(
                          items: imageList
                              .map((item) => Image.asset(
                                    item['image_path'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ))
                              .toList(),
                          carouselController: carouselController,
                          options: CarouselOptions(
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            aspectRatio: 1.6,
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 1000),
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ))),
                  Positioned(
                      bottom: 15,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: imageList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () =>
                                carouselController.animateToPage(entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 12 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? AppTheme.secondaryColor
                                      : AppTheme.darksecondaryColor),
                            ),
                          );
                        }).toList(),
                      )),
                ],
              ),
            ],
          ));
    }

    Widget header() {
      return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            color: AppTheme.secondaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Center(
              child: Text(
                'Home Page',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ));
    }

    Widget content(BuildContext context) {
      List<Map<String, dynamic>> iconbutton = [
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/absentism.png',
          'text': 'Absence',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/letter.png',
          'text': 'Permission',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/salary.png',
          'text': 'Salary',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/growth.png',
          'text': 'Performance',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/trophy.png',
          'text': 'Achievement',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/clock.png',
          'text': 'Break',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/television.png',
          'text': 'Channel',
        },
        {
          'ontap': () => Navigator.pushNamed(context, '/absen-page'),
          'asset': 'assets/cafe.png',
          'text': 'Snack & Drink',
        },
      ];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: GridView.count(
          crossAxisCount: 3, // Menampilkan tiga item per baris
          shrinkWrap: true,
          children: iconbutton.map((button) {
            dynamic ontap = button['ontap'];
            String asset = button['asset'];
            String text = button['text'];

            return GestureDetector(
              onTap: ontap,
              child: Column(
                children: [
                  Image.asset(
                    asset,
                    width: 30,
                  ),
                  Text(
                    text,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: WillPopScope(
          onWillPop: () async {
            if (lastPressedTime == null ||
                DateTime.now().difference(lastPressedTime!) >
                    const Duration(seconds: 2)) {
              Fluttertoast.showToast(
                  msg: 'Klik lagi untuk keluar',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: AppTheme.secondaryColor,
                  textColor: Colors.white,
                  fontSize: 14.0);
              lastPressedTime = DateTime.now();
              return false;
            } else {
              return true;
            }
          },
          child: Column(
            children: [carousel(), header(), content(context)],
          ),
        ));
  }
}
