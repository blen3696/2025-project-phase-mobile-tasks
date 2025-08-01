import '../../../../colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPrice;
  final int maxLines;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.label,
    this.isPrice = false,
    this.maxLines = 1,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            keyboardType: isPrice ? TextInputType.number : TextInputType.text,
            maxLines: maxLines,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: isPrice ? const Icon(Icons.attach_money_sharp) : null,
              filled: true,
              fillColor: MyColors.myLightGrey,
            ),
          ),
        ],
      ),
    );
  }
}
