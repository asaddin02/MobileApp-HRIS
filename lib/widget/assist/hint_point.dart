import 'package:flutter/material.dart';
import 'package:techsolution/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class HintPointPage extends StatelessWidget {
  const HintPointPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Mutable Data &",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Text(
              "Immutable Data",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                      color: AppTheme.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      );
    }

    Widget content() {
      return Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Mutable Data",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
                const SizedBox(height: 10),
                Text(
                  "Mutable data adalah data yang tidak bisa diubah setelah di tampilkan, jadi mohon dipastikan untuk memasukkan data yang benar-benar valid dan sesuai dengan intruksi perusahaan.",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 2)),
                ),
                const SizedBox(height: 30),
                Text(
                  "Immutable Data",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 18)),
                ),
                const SizedBox(height: 10),
                Text(
                  "Immutable data adalah data yang bisa diubah setelah di tampilkan. Ubahlah data Anda apabila data tersebut tidak sesuai dengan Anda, namun tetap sesuai dengan konteks dan aturan perusahaan.",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 2)),
                ),
              ],
            ),
          ));
    }

    Widget footer() {
      return Material(
        type: MaterialType.transparency,
        child: Container(
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
        ),
      );
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.popAndPushNamed(context,'/edit-profile');
          return false;
        },
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            header(),
            const SizedBox(height: 70),
            content(),
            const SizedBox(height: 130),
            footer()
          ],
        ));
  }
}
