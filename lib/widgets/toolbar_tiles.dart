import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      child: ListTile(
        onTap: ontap,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
