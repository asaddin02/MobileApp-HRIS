import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:techsolution/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:techsolution/view/main_page.dart';
import 'package:techsolution/service/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  TextEditingController nikController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  void showCustomSnackbar(String message) {
    _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 3000),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: AppTheme.textColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ));
  }

  void completeLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  handlelogin() async {
    var data = {'nik': nikController.text, 'password': passwordController.text};
    var res = await AuthUser().postData(data, 'login');

    if (res.statusCode == 200) {
      String responseBody = res.body;
      Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
      String token = jsonResponse['data']['token'];
      SharedPreferences pre = await SharedPreferences.getInstance();
      pre.setString("auth", token);
      completeLogin();
    } else {
      if (res.statusCode == 422) {
        showCustomSnackbar('Please fill out this field');
      } else if (res.statusCode == 401) {
        showCustomSnackbar('please enter the data correctly');
      } else {
        showCustomSnackbar('connection error, please check your connection');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget inputLogin() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.textColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Hello',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Please login to your account',
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 60),
            TextField(
              controller: nikController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 20),
                prefixIcon:
                    const Icon(Icons.person, color: AppTheme.primaryColor),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  maxHeight: 10,
                ),
                hintText: 'Enter your NIK',
                hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: passwordController,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              obscureText: obscureText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 20),
                prefixIcon:
                    const Icon(Icons.lock, color: AppTheme.primaryColor),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 35,
                  maxHeight: 10,
                ),
                suffixIcon: IconButton(
                  icon: obscureText
                      ? const Icon(Icons.visibility_off_outlined,
                          size: 25, color: AppTheme.primaryColor)
                      : const Icon(Icons.visibility_outlined,
                          size: 25, color: AppTheme.primaryColor),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 35,
                  maxHeight: 20,
                ),
                hintStyle: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.primaryColor),
                ),
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 60),
            InkWell(
                onTap: () async {
                  await launchUrl(
                      Uri.parse('http://192.168.1.43:8000/password/reset'));
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Forgot Password?',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                handlelogin();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                  minimumSize: const Size(double.infinity, 40)),
              child: Text(
                'Login',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        color: AppTheme.primaryColor,
        child: Text(
          'Powered by PT.Digiponic Maju Jaya',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: AppTheme.textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    return ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          backgroundColor: AppTheme.primaryColor,
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Image.asset("assets/logo.png", width: 80),
                const SizedBox(height: 10),
                Text(
                  'TECH SOLUTION',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: inputLogin(),
                  ),
                ),
                const SizedBox(height: 60),
                footer(),
              ],
            ),
          ),
        ));
  }
}
