import 'package:flutter/material.dart';
import 'package:todooapp/ad_bottom_sheet/ad_bottom_sheet.dart';
import 'package:todooapp/model/user_dm.dart';
import 'package:todooapp/tabs/list_tab.dart';
import 'package:todooapp/tabs/settings_tab.dart';
import 'package:todooapp/utilits/app_colors.dart';
import 'package:todooapp/utilits/app_style.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  static const String routeName = 'myHome';

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int currentIndex = 0;
  List<Widget> tabsList = [];
  GlobalKey<ListTabState> listTabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    tabsList = [
      ListTab(
        key: listTabKey,
      ),
      SettingsTab()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome ${UserDm.currentUser!.userName}",
          style: AppStyle.appBarStyle,
        ),
      ),
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabsList[currentIndex],
    );
  }

  buildFloatingActionButton() => FloatingActionButton(
        onPressed: () async {
          await AddBottomSheet.show(context);
          listTabKey.currentState?.getTodosListFromFirestore();
        },
        backgroundColor: AppColors.primaryColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: AppColors.white,
            width: 3,
          ),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      );

  Widget buildBottomNavigationBar() => BottomAppBar(
      notchMargin: 12,
      clipBehavior: Clip.hardEdge,
      shape: CircularNotchedRectangle(),
      child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (tappedIndex) => {currentIndex = tappedIndex, setState(() {})},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ));
}
