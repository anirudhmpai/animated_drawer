import 'package:animated_drawer/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'info_card.dart';
import 'side_tile.dart';

double drawerWidth = 288;

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  RiveAsset selectedMenu = menu1.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: drawerWidth,
        height: double.infinity,
        color: Colors.blueGrey.shade900,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCardWidget(
                title: 'User Name',
                subtitle: 'Profession',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Browse',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...menu1.map((menu) => SideTile(
                    riveAsset: menu,
                    isActive: menu == selectedMenu,
                    onPressed: () {
                      menu.inputValue!.change(true);
                      Future.delayed(const Duration(seconds: 1))
                          .then((value) => menu.inputValue!.change(false));
                      selectedMenu = menu;
                      setState(() {});
                    },
                    riveInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.inputValue = controller.findSMI('active') as SMIBool;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'History',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...menu2.map((menu) => SideTile(
                    riveAsset: menu,
                    isActive: menu == selectedMenu,
                    onPressed: () {
                      menu.inputValue!.change(true);
                      Future.delayed(const Duration(seconds: 1))
                          .then((value) => menu.inputValue!.change(false));
                      selectedMenu = menu;
                      setState(() {});
                    },
                    riveInit: (artboard) {
                      StateMachineController controller =
                          RiveUtils.getRiveController(artboard,
                              stateMachineName: menu.stateMachineName);
                      menu.inputValue = controller.findSMI('active') as SMIBool;
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class RiveAsset {
  final String artboard, stateMachineName, title;
  late SMIBool? inputValue;

  RiveAsset({
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.inputValue,
  });

  set setInput(SMIBool status) {
    inputValue = status;
  }
}

List<RiveAsset> menu1 = [
  RiveAsset(
    artboard: 'HOME',
    title: 'Home',
    stateMachineName: 'HOME_interactivity',
  ),
  RiveAsset(
    artboard: 'SEARCH',
    title: 'Search',
    stateMachineName: 'SEARCH_Interactivity',
  ),
  RiveAsset(
    artboard: 'LIKE/STAR',
    title: 'Favorites',
    stateMachineName: 'STAR_Interactivity',
  ),
  RiveAsset(
    artboard: 'CHAT',
    title: 'Chat',
    stateMachineName: 'CHAT_Interactivity',
  ),
];

List<RiveAsset> menu2 = [
  RiveAsset(
    artboard: 'TIMER',
    title: 'History',
    stateMachineName: 'TIMER_Interactivity',
  ),
  RiveAsset(
    artboard: 'BELL',
    title: 'Notifications',
    stateMachineName: 'BELL_Interactivity',
  ),
];
