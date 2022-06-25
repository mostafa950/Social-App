import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Notifications',
      style: GoogleFonts.aBeeZee(
        color: Colors.black,
      ),
    );
  }
}
