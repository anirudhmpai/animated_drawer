import 'dart:math';

import 'package:animated_drawer/components/menu_button.dart';
import 'package:animated_drawer/components/side_drawer.dart';
import 'package:animated_drawer/components/swipe_detector.dart';
import 'package:animated_drawer/rive_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int indexCurrent = 0;
  late SMIBool homeTrigger;
  late SMIBool timerTrigger;
  late SMIBool isDrawerOpen;
  late bool isSideMenuOpen = false;

  late AnimationController drawerAnimationController;
  late Animation drawerAnimation;
  late Animation scaleAnimation;

  @override
  void initState() {
    drawerAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });
    drawerAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: drawerAnimationController,
      curve: Curves.fastOutSlowIn,
    ));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
      parent: drawerAnimationController,
      curve: Curves.fastOutSlowIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    drawerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade900,
        resizeToAvoidBottomInset: false,
        extendBody: true,
        bottomNavigationBar: AnimatedOpacity(
          duration: const Duration(milliseconds: 100),
          opacity: isSideMenuOpen ? drawerAnimation.value / 100 : 1,
          child: Transform.translate(
            offset: Offset(0, drawerAnimation.value * 100),
            child: SafeArea(
              child: BottomNavigationBar(
                  currentIndex: indexCurrent,
                  onTap: (value) {
                    indexCurrent = value;
                    setState(() {});
                  },
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.grey,
                  items: const [
                    BottomNavigationBarItem(
                        label: '0',
                        icon: Icon(
                          Icons.abc,
                        )),
                    BottomNavigationBarItem(
                        label: '1',
                        icon: Icon(
                          Icons.ac_unit,
                        )),
                    BottomNavigationBarItem(
                        label: '2',
                        icon: Icon(
                          Icons.access_alarm,
                        )),
                    BottomNavigationBarItem(
                        label: '3',
                        icon: Icon(
                          Icons.access_time,
                        )),
                  ]),
            ),
          ),
        ),
        body: SwipeDetector(
          onSwipeRight: () => toggleDrawer(),
          onSwipeLeft: () => toggleDrawer(),
          child: Stack(
            children: [
              AnimatedPositioned(
                width: drawerWidth,
                height: MediaQuery.of(context).size.height,
                left: isSideMenuOpen ? 0 : -drawerWidth,
                duration: const Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
                child: const SideDrawer(),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(drawerAnimation.value -
                      30 * drawerAnimation.value * pi / 180),
                child: Transform.translate(
                  offset: Offset(drawerAnimation.value * 265, 0),
                  child: Transform.scale(
                      scale: scaleAnimation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(isSideMenuOpen
                            ? double.parse(
                                (24 * drawerAnimation.value).toString())
                            : 0),
                        child: bodyContent(),
                      )),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 200),
                top: 16,
                left: isSideMenuOpen ? 220 : 0,
                curve: Curves.fastOutSlowIn,
                child: MenuButton(
                  onPressed: () => toggleDrawer(),
                  riveInit: (artboard) {
                    StateMachineController controller =
                        RiveUtils.getRiveController(artboard,
                            stateMachineName: 'switch');
                    isDrawerOpen = controller.findSMI('toggleX') as SMIBool;
                    setState(() {});
                    debugPrint(isDrawerOpen.value.toString());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toggleDrawer() {
    isDrawerOpen.value = !isDrawerOpen.value;
    isSideMenuOpen = !isSideMenuOpen;
    setState(() {});
    debugPrint(isDrawerOpen.value.toString());
    if (isSideMenuOpen) {
      drawerAnimationController.forward();
    } else {
      drawerAnimationController.reverse();
    }
  }

  Container bodyContent() {
    return Container(
      color: Colors.blueGrey.shade500,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const Text('----------------Animated Sidebar---------------'),
            InkWell(
              onTap: () {
                homeTrigger.change(true);
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => homeTrigger.change(false));
              },
              child: SizedBox(
                  height: 36,
                  width: 36,
                  child: RiveAnimation.asset(
                    'assets/rive_animations/animated_icons.riv',
                    artboard: 'HOME',
                    onInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: 'HOME_interactivity');
                      homeTrigger = controller.findSMI("active") as SMIBool;
                    },
                  )),
            ),
            InkWell(
              onTap: () {
                timerTrigger.change(true);
                Future.delayed(const Duration(seconds: 1))
                    .then((value) => timerTrigger.change(false));
              },
              child: SizedBox(
                  height: 36,
                  width: 36,
                  child: RiveAnimation.asset(
                    'assets/rive_animations/animated_icons.riv',
                    artboard: 'TIMER',
                    onInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: 'TIMER_Interactivity');
                      timerTrigger = controller.findSMI("active") as SMIBool;
                    },
                  )),
            )
          ],
        ),
      ),
    );
  }
}
