import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techsolution/theme.dart';
import 'chat_bubble.dart';

class DetailChatPage extends StatelessWidget {
  const DetailChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: AppTheme.primaryColor,
          centerTitle: false,
          title: Row(
            children: [
              Image.asset('assets/profile.png', width: 50),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Pengirim',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                  ),
                  Text(
                    'Status',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget detailchat() {
      return Container(
          margin: const EdgeInsets.all(20),
          child: Row(children: [
            Expanded(
                child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.thirdColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                  child: TextFormField(
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textColor,
                        fontWeight: FontWeight.normal)),
                decoration: InputDecoration.collapsed(
                    hintText: 'Type Message...',
                    hintStyle: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.textColor,
                            fontWeight: FontWeight.w400))),
              )),
            )),
            const SizedBox(width: 15),
            Image.asset('assets/send.png', width: 48)
          ]));
    }

    Widget content() {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: const [
          ChatBubble(
            isSender: true,
            text: 'Hallo Semuanya',
          ),
          ChatBubble(
              isSender: false,
              text:
                  'Hai Apakah kamu anu itu? aku tidak menyangka akan bertemu dengamu saat ini')
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: header(),
      bottomNavigationBar: detailchat(),
      body: content(),
    );
  }
}
