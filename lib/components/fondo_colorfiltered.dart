import 'package:flutter/material.dart';

class FondoColorFiltered extends StatelessWidget {
  const FondoColorFiltered({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.1), BlendMode.dstATop),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image(
          image: AssetImage("assets/splash/splash_limpio.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
