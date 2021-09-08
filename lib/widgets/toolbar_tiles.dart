import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';

import '../constants.dart';

/// Used in drawer section of homepage and custom drawer
class ToolBarTile extends StatelessWidget {
  const ToolBarTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.ontap,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    // Color color = (appTheme == Brightness.light) ? Colors.black : Colors.white;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: ontap,
        leading: Theme(data: Theme.of(context).copyWith(), child: Icon(icon)),
        title: Text(
          title,
          style: GoogleFonts.lato(
            // color: const Color(0xFFB2B1B6),
            fontSize: 18,
            // color: color,
          ),
        ),
      ),
    );
  }
}
