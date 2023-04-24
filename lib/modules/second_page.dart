import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverFillRemaining(
        child: Column(
          children: [
            openContainer(Colors.amber),
            openContainer(Colors.green),
            openContainer(Colors.cyan),
            openContainer(Colors.indigo),
            openContainer(Colors.teal),
            openContainer(Colors.red),
            openContainer(Colors.blueGrey),
            openContainer(Colors.brown),
            openContainer(Colors.deepOrange),
            openContainer(Colors.deepPurple),
          ],
        ),
      ),
    ]);
  }

  openContainer(MaterialColor color) {
    return Expanded(
      child: OpenContainer(
        openBuilder: (context, action) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: color,
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close,
                            color: color.computeLuminance() > 0.4
                                ? Colors.black
                                : Colors.white)),
                    Text('open',
                        style: TextStyle(
                            color: color.computeLuminance() > 0.4
                                ? Colors.black
                                : Colors.white)),
                  ],
                ),
              ),
            ),
          );
        },
        closedBuilder: (context, action) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: color,
              body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('closed',
                        style: TextStyle(
                            color: color.computeLuminance() > 0.4
                                ? Colors.black
                                : Colors.white)),
                  ],
                ),
              ),
            ),
          );
        },
        openColor: Colors.transparent,
        closedColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 250),
        transitionType: ContainerTransitionType.fade,
        useRootNavigator: true,
      ),
    );
  }
}
