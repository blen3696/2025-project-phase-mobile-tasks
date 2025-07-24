import 'package:flutter/material.dart';
import '../colors.dart';

class SizeBox extends StatelessWidget {
  final int size;
  final bool isActive;

  const SizeBox({super.key, required this.size, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? MyColors.myBlue : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isActive ? MyColors.myBlue : Colors.grey.shade200,
        ),
        boxShadow: [BoxShadow(blurRadius: 0.2, color: Colors.grey.shade50)],
      ),
      child: Text(
        size.toString(),
        style: TextStyle(
          color: isActive ? Colors.white : Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
