import 'package:flutter/material.dart';
import 'package:techsolution/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:techsolution/service/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  Map<String, dynamic> userData = {};
  void fetchData() async {
    Map<String, dynamic> user = await AuthUser().getUser();
    setState(() {
      userData = user;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
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
    Widget header() {
      return AppBar(
        backgroundColor: AppTheme.primaryColor,
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(30),
          child: Row(
            children: [
              ClipOval(
                child: Image.asset('assets/profile.png', width: 80),
              ),
              const SizedBox(width: 16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${userData['user']?['nama']}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${userData['user']?['nik']}',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        )),
      );
    }

    Widget menuItems(IconData icon, String text) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          children: [
            const SizedBox(width: 15),
            Icon(icon, color: AppTheme.textColor, size: 20),
            const SizedBox(width: 10),
            Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget logout() {
      return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: AppTheme.thirdColor,
                title: Text('Logout Confirmation',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    )),
                content: Text('Are you sure you want to logout?',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppTheme.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    )),
                actions: <Widget>[
                  TextButton(
                    child: Text('Batal',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Logout',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        )),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: menuItems(Icons.logout, 'Logout'),
      );
    }

    Widget content() {
      return Expanded(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Account',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/edit-profile');
              },
              child: menuItems(Icons.edit, 'Profile'),
            ),
            GestureDetector(
              onTap: () {},
              child: menuItems(Icons.lock, 'Password'),
            ),
            const SizedBox(height: 30),
            Text(
              'Extra',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16,
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: menuItems(Icons.settings, 'Setting'),
            ),
            GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse('http://192.168.1.8:8000'));
              },
              child: menuItems(Icons.info, 'About us'),
            ),
            GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse('http://192.168.1.8:8000'));
              },
              child: menuItems(CupertinoIcons.globe, 'More Info'),
            ),
            logout()
          ],
        ),
      ));
    }

    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppTheme.secondaryColor,
              ))
            : WillPopScope(
                onWillPop: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                  return true;
                },
                child: Column(
                  children: <Widget>[header(), content()],
                )));
  }
}
