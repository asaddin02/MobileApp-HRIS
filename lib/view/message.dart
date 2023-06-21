import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techsolution/theme.dart';
import 'package:techsolution/widget/chat_tile.dart';
import 'main_page.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        title: Text(
          'Message',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontSize: 20,
              color: AppTheme.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget emptychat() {
      return Expanded(
          child: Container(
        width: double.infinity,
        color: AppTheme.primaryColor,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/chatempty.png', width: 100),
          const SizedBox(height: 10),
          Text(
            'No message yet',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18,
                color: AppTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Try chatting someone?',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 14,
                color: AppTheme.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 44,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  backgroundColor: AppTheme.secondaryColor),
              child: Text(
                'Send Message',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ]),
      ));
    }

    Widget content() {
      return Expanded(
          child: Container(
              width: double.infinity,
              color: AppTheme.primaryColor,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                children: const [ChatTile()],
              )));
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()));
          return true;
        },
        child: Column(
          children: [header(), content()],
        ));
  }
}
