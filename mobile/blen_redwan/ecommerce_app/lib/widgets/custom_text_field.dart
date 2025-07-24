import 'package:ecommerce_app/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isPrice;
  final int maxLines;
  const CustomTextField({
    super.key,
    required this.label,
    this.isPrice = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12)),
          SizedBox(height: 8),
          TextField(
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
