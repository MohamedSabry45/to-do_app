import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/provider/list_provider.dart';
import 'package:to_do/ui/screens/home/tabs/menu/to_do_widget.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:to_do/ui/utilits/app_color.dart';

import '../../../../../models/todo_dm.dart';

class MenuScreen extends StatefulWidget {

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late ListProvider provider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.refreshTodosList();
    });
  }
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * .18,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: AppColor.primaryColor,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      color: AppColor.accentColor,
                    ),
                  )
                ],
              ),
              CalendarTimeline(
                initialDate: provider.seletedDate,
                firstDate:DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 1095)),
                onDateSelected: (date) {
                  provider.seletedDate = date;
                  provider.refreshTodosList();
                },
                leftMargin: 20,
                monthColor: AppColor.accentColor,
                dayColor: AppColor.black,
                activeDayColor: AppColor.primaryColor,
                activeBackgroundDayColor: AppColor.white,
                dotsColor: Colors.transparent,
                showYears: true,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todos.length,
              itemBuilder: (context , index) =>
                  ToDoWidget(model: provider.todos[index])
          ),
        ),
      ],
    );
  }


}
