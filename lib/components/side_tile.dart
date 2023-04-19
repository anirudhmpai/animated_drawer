import 'package:animated_drawer/components/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SideTile extends StatelessWidget {
  const SideTile({
    super.key,
    required this.isActive,
    required this.onPressed,
    required this.riveInit,
    required this.riveAsset,
  });
  final RiveAsset riveAsset;
  final bool isActive;
  final VoidCallback onPressed;
  final ValueChanged<Artboard> riveInit;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Padding(
        padding: EdgeInsets.only(left: 24),
        child: Divider(
          color: Colors.white24,
          height: 1,
        ),
      ),
      Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            height: 56,
            width: isActive ? drawerWidth : 0,
            left: 0,
            child: Container(
              width: drawerWidth,
              decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ListTile(
            onTap: onPressed,
            leading: SizedBox(
              height: 34,
              width: 34,
              child: RiveAnimation.asset(
                'assets/rive_animations/animated_icons.riv',
                artboard: riveAsset.artboard,
                onInit: riveInit,
              ),
            ),
            title: Text(
              riveAsset.title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      )
    ]);
  }
}
