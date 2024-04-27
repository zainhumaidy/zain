import 'package:flutter/material.dart';


class Logo extends StatelessWidget {
  const Logo ({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Container(
        alignment: Alignment.center,
        height: 200,
        width: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(100)),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.asset(
              "images/EH.jpg",
              height: 200,
            ),
          ),
        ),
      ),
    );

  }
}
