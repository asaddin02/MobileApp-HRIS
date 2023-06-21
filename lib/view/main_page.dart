import 'package:flutter/material.dart';
import 'package:techsolution/theme.dart';
import 'home.dart';
import 'notification.dart';
import 'message.dart';
import 'profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget buttonList() {
      return FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.secondaryColor,
        child: Image.asset('assets/to-do-list.png', width: 30),
      );
    }

    Widget customBottomNav() {
      return ClipRect(
          child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: AppTheme.secondaryColor,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                    top: 8.0),
                child: Image.asset(
                  'assets/home.png',
                  width: 25,
                  color: currentIndex == 0
                      ? AppTheme.primaryColor
                      : AppTheme.textColor,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 15.0),
                child: Image.asset(
                  'assets/notification.png',
                  width: 25,
                  color: currentIndex == 1
                      ? AppTheme.primaryColor
                      : AppTheme.textColor,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 15.0),
                child: Image.asset(
                  'assets/chatting.png',
                  width: 25,
                  color: currentIndex == 2
                      ? AppTheme.primaryColor
                      : AppTheme.textColor,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Image.asset(
                  'assets/profile-user.png',
                  width: 25,
                  color: currentIndex == 3
                      ? AppTheme.primaryColor
                      : AppTheme.textColor,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ));
    }

    Widget body() {
      switch (currentIndex) {
        case 0:
          return const HomePage();
        case 1:
          return const NotificationPage();
        case 2:
          return const MessagePage();
        case 3:
          return const ProfilePage();
        default:
          return const HomePage();
      }
    }

    return Scaffold(
        backgroundColor: AppTheme.primaryColor,
        floatingActionButton: buttonList(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: customBottomNav(),
        body: body());
  }
}
