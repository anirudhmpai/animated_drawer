import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                body: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Hero(
                    tag: 'logo',
                    child: FlutterLogo(
                      size: 800,
                    ),
                  ),
                ),
              ),
            );
          },
        ));
      },
      child: const Hero(
        tag: 'logo',
        child: FlutterLogo(
          size: 300,
        ),
      ),
    );
  }
}
