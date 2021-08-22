import 'package:cuisine_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';

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
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: ontap,
          leading: Theme(data: Theme.of(context).copyWith(), child: Icon(icon)),
          title: Text(
            title,
            style: GoogleFonts.lato(
              // color: const Color(0xFFB2B1B6),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
