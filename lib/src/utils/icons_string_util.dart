import 'package:flutter/material.dart';

final _icons = <String, IconData>{
  'two_wheeler_outlined': Icons.two_wheeler_outlined,
  'car_repair_outlined': Icons.car_repair_outlined,
  'bedroom_child_outlined': Icons.bedroom_child_outlined,
  'tv_outlined': Icons.tv_outlined,
  'sailing_outlined': Icons.sailing_outlined,
  'point_of_sale_outlined': Icons.point_of_sale_outlined,
  'pets_outlined': Icons.pets_outlined,
  'piano_outlined': Icons.piano_outlined,
  'cake_outlined': Icons.cake_outlined
};

Icon getIcon(String iconName) {
  return Icon(_icons[iconName], color: Colors.blue);
}
