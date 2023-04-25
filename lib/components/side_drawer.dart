import 'package:animated_drawer/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'info_card.dart';
import 'side_tile.dart';

double drawerWidth = 288;

class SideDrawer extends StatefulWidget {
  const SideDrawer(
      {super.key, required this.currentIndex, required this.onClick});
  final int currentIndex;
  final ValueChanged<int> onClick;

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  late RiveAsset selectedMenu;
  @override
  void initState() {
    selectedMenu = menu1.elementAt(widget.currentIndex);
    // menu1.first;
    super.initState();
  }

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
                      widget.onClick(selectedMenu.index);
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
                      widget.onClick(selectedMenu.index);
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
  final int index;

  RiveAsset({
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    required this.index,
    this.inputValue,
  });

  set setInput(SMIBool status) {
    inputValue = status;
  }
}

List<RiveAsset> menu1 = [
  RiveAsset(
    index: 0,
    artboard: 'HOME',
    title: 'Home',
    stateMachineName: 'HOME_interactivity',
  ),
  RiveAsset(
    index: 1,
    artboard: 'SEARCH',
    title: 'Search',
    stateMachineName: 'SEARCH_Interactivity',
  ),
  RiveAsset(
    index: 2,
    artboard: 'LIKE/STAR',
    title: 'Favorites',
    stateMachineName: 'STAR_Interactivity',
  ),
  RiveAsset(
    index: 3,
    artboard: 'CHAT',
    title: 'Chat',
    stateMachineName: 'CHAT_Interactivity',
  ),
];

List<RiveAsset> menu2 = [
  RiveAsset(
    index: 4,
    artboard: 'TIMER',
    title: 'History',
    stateMachineName: 'TIMER_Interactivity',
  ),
  RiveAsset(
    index: 5,
    artboard: 'BELL',
    title: 'Notifications',
    stateMachineName: 'BELL_Interactivity',
  ),
];
