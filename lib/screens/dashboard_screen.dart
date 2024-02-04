import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promilo/cubits/app_bar_title_cubit.dart';
import 'package:promilo/screens/account_screen.dart';
import 'package:promilo/screens/explore_screen.dart';
import 'package:promilo/screens/home_screen.dart';
import 'package:promilo/screens/meet_up_screen.dart';
import 'package:promilo/screens/prolet_screen.dart';
import 'package:promilo/utils/colors.dart';
import 'package:promilo/utils/screen_names.dart';
import 'package:promilo/widgets/icon_button.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  final PageController _pageController = PageController();
  final ValueNotifier _selectedBottomBarIndex = ValueNotifier(0);

  final titles = [
    AppScreenNames.homeScreen,
    AppScreenNames.proletScreen,
    AppScreenNames.meetupScreen,
    AppScreenNames.exploreScreen,
    AppScreenNames.accountScreen,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    _selectedBottomBarIndex.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedBottomBarIndex.value == index) {
      // If the same tab is tapped again, pop to the first route in the navigator stack
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
    } else {
      _selectedBottomBarIndex.value = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 1), curve: Curves.ease);
    }
    context.read<AppBarTitleCubit>().setTitle(titles[index]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          onPressed: () {
            if (navigatorKey.currentState!.canPop()) {
              navigatorKey.currentState?.pop();
            } else {
              exit(0);
            }
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        titleSpacing: 0,
        title: BlocBuilder<AppBarTitleCubit, String>(
          builder: (BuildContext context, state) {
            return Text(
              state,
              style: const TextStyle(color: AppColors.text100),
            );
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const HomeScreen(),
            const ProletScreen(),
            WillPopScope(
              onWillPop: () async {
                final didPop = await navigatorKey.currentState?.maybePop();
                return !didPop!;
              },
              child: Navigator(
                key: navigatorKey,
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) {
                      return const MeetUpScreen();
                    },
                  );
                },
              ),
            ),
            const ExploreScreen(),
            const AccountScreen(),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _selectedBottomBarIndex,
        builder: (BuildContext context, value, Widget? child) {
          return BottomNavigationBar(
            currentIndex: value,
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme: const IconThemeData(
              color: AppColors.selectedBottomBarItem,
            ),
            selectedLabelStyle: const TextStyle(
              color: AppColors.selectedBottomBarItem,
              fontSize: 12,
            ),
            unselectedIconTheme: const IconThemeData(
              color: AppColors.unselectedBottomBarItem,
            ),
            unselectedLabelStyle: const TextStyle(
              color: AppColors.unselectedBottomBarItem,
              fontSize: 12,
            ),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.house), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.file_copy_outlined), label: "Prolet"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.handshake_outlined), label: "Meetup"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.folder_copy_outlined), label: "Explore"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined), label: "Account"),
            ],
            onTap: (index) {
              _onItemTapped(index);
            },
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
