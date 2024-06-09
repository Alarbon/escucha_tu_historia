
import 'package:flutter/material.dart';

class CustomAppbarIcon extends StatelessWidget {
  const CustomAppbarIcon({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.94,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/icon/icon.png',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: size.width * 0.25,
            child: Image.asset(
              'assets/images/escudo_de_martos.png',
              fit: BoxFit.cover,
              scale: 100,
            ),
          ),
        ],
      ),
    );
  }
}
