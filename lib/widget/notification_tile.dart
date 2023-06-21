import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:techsolution/theme.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail-notif');
      },
      child: Container(
        margin: const EdgeInsets.only(top: 33),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/megaphone.png', width: 54),
                const SizedBox(width: 12),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Announcement',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'Belilah anu baru di sini',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
                Text(
                  'Now',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.textColor,
                          fontWeight: FontWeight.w200)),
                )
              ],
            ),
            const SizedBox(height: 12),
            const Divider(
              thickness: 1,
              color: Color(0xff152622),
            )
          ],
        ),
      ),
    );
  }
}
