import 'package:animated_drawer/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late SMIBool homeTrigger;
    late SMIBool timerTrigger;
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
