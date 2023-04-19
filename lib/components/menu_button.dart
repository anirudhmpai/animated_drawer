import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.onPressed,
    required this.riveInit,
  });
  final VoidCallback onPressed;
  final ValueChanged<Artboard> riveInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          padding: const EdgeInsets.all(5),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 3),
                  blurRadius: 8,
                )
              ]),
          child: RiveAnimation.asset(
            'assets/rive_animations/animated_menu.riv',
            // artboard: '',
            onInit: riveInit,
          ),
        ),
      ),
    );
  }
}
