//Bu class projeye özgü bir AppBar oluşturmak amacıyla kuruldu.

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget appBarOutlinedcon;
  final Color customBlue = Color.fromRGBO(38, 65, 125, 1);
  CustomAppBar({
    Key? key,
    this.appBarOutlinedcon = const Icon(Icons.account_circle_outlined),
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white70,
      title: Text("Ormanlar Nefesimizdir", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: customBlue)),
    );
  }
}
