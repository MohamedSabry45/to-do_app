import 'package:flutter/material.dart';
import 'package:to_do/ui/screens/bottom_sheets/add_bottom_sheet.dart';
import 'package:to_do/ui/screens/home/tabs/menu/menu_screen.dart';
import 'package:to_do/ui/screens/home/tabs/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    MenuScreen(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Text("To Do List"),

        ),
        toolbarHeight: MediaQuery.sizeOf(context).height * .1,
      ),

      body: tabs[currentIndex],
      bottomNavigationBar:buildBottomNavigationBar(),
      floatingActionButton: buildFab() ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBottomNavigationBar() => BottomAppBar(
    notchMargin: 8,
    shape: CircularNotchedRectangle(),
    clipBehavior: Clip.hardEdge,
    child: BottomNavigationBar(
      currentIndex: currentIndex,
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label: ""),

        ]
    ),
  );
  Widget buildFab() => FloatingActionButton(
      onPressed:(){
        showModalBottomSheet(
            context: context,isScrollControlled: true, builder:(_) => Padding(

              padding: MediaQuery.of(context).viewInsets,
              child: AddBottomSheet(),
            ));
      },
    child: Icon(Icons.add),

  );
}




