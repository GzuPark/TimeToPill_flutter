import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_to_pill/components/project_colors.dart';
import 'package:time_to_pill/components/project_constants.dart';
import 'package:time_to_pill/components/project_page_route.dart';
import 'package:time_to_pill/pages/add/add_pill_page.dart';
import 'package:time_to_pill/pages/history/history_page.dart';
import 'package:time_to_pill/pages/today/today_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _pages = <Widget>[
    TodayPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: pagePadding,
        child: SafeArea(
          child: _pages[_currentIndex],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: _onRouteAddPage,
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildCupertinoButton(0, CupertinoIcons.checkmark),
              buildCupertinoButton(1, CupertinoIcons.text_badge_checkmark),
            ],
          ),
        ),
      ),
    );
  }

  CupertinoButton buildCupertinoButton(int index, IconData icon) {
    return CupertinoButton(
      child: Icon(
        icon,
        color: _currentIndex == index ? ProjectColors.primaryColor : Colors.grey.shade300,
      ),
      onPressed: () {
        setState(() => _currentIndex = index);
      },
    );
  }

  void _onRouteAddPage() {
    Navigator.push(
      context,
      FadePageRoute(page: const AddPillPage()),
    );
  }
}
