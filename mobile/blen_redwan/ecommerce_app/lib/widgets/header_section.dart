import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "July 14, 2023", // You can make this dynamic later
                  style: TextStyle(fontSize: 12, color: Colors.grey[400]),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, ",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Text("Yohannes", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),

        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.notifications),
        ),
      ],
    );
  }
}
