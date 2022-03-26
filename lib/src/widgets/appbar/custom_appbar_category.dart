import 'package:flutter/material.dart';

class CustomAppBarForCategory extends StatelessWidget
    implements PreferredSizeWidget {
  final String categoryName;
  const CustomAppBarForCategory({Key? key, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: const Color.fromRGBO(3, 9, 23, 1),
      title: Text(categoryName),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}
