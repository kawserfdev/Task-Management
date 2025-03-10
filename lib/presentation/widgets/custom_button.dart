import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final String text;
  final int count;
  final Color color;

  SummaryCard({required this.count, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 83,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$count",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
