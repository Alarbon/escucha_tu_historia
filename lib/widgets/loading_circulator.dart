
import 'package:flutter/material.dart';

class LoadingCirculator extends StatelessWidget {
  const LoadingCirculator({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
          width: size.width * 0.25,
          height: size.width * 0.25,
          child: const CircularProgressIndicator(
            backgroundColor: Colors.black38,
            strokeWidth: 6,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white,
            ),
          ),
        ),
      );
  }
}
