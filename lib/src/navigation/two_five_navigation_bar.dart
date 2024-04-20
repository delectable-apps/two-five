import 'package:flutter/material.dart';
import 'package:two_five/src/sample_feature/sample_item_list_view.dart';
import 'package:two_five/src/settings/settings_view.dart';

class TwoFiveNavigationBar extends StatelessWidget {
  const TwoFiveNavigationBar({
    super.key,
    required ScrollController homeController,
    required this.currentIndex,
  }) : _homeController = homeController;

  final ScrollController _homeController;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (int index) {
        switch (index) {
          case 0:
            if (currentIndex == index) {
              _homeController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            } else {
              Navigator.pop(context);
            }

          case 1:
            if (currentIndex == index) {
              _homeController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
              );
            } else {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            }
        }
      },
    );
  }
}
