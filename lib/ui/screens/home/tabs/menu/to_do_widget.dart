import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/app_user.dart';
import 'package:to_do/models/todo_dm.dart';
import 'package:to_do/ui/provider/list_provider.dart';
import 'package:to_do/ui/screens/home/tabs/menu/edit_task_screen.dart';
import 'package:to_do/ui/utilits/app_color.dart';
import 'package:to_do/ui/utilits/app_theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoWidget extends StatefulWidget {
TodoDM model;
ToDoWidget({required this.model});

  @override
  State<ToDoWidget> createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24,vertical: 18 ),
   child: Slidable(
        startActionPane: ActionPane(
            motion: StretchMotion(),
            extentRatio: .3,
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
                onPressed: (_){
                 AppUser.collection().
                 doc(AppUser.currentUser!.id).
                  collection("todos").
                 doc(widget.model.id).
                 delete().
                 then((_) {
                    provider.refreshTodosList();
                 } );
                },
                backgroundColor: Colors.red ,
                foregroundColor: AppColor.white,
                icon: Icons.delete,
                label: 'Delete',
                  )
            ]
        ),
        endActionPane:ActionPane(
            motion: StretchMotion(),
            extentRatio: .3,
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(12),
                onPressed: (_){
                  Navigator.pushNamed(context, EditTaskScreen.routeName,arguments: widget.model );
                },
                backgroundColor: AppColor.primaryColor,
                foregroundColor: AppColor.white,
                icon: Icons.edit,
                label: 'Edit',
              )
            ]
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical:20 ,horizontal: 16 ),
          height: MediaQuery.of(context).size.height * .13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color:  AppColor.white
          ),
          child: Row(
            children: [
              widget.model.isDone ? VerticalDivider(color:AppColor.selectedColor)
                  : VerticalDivider(),
              SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.model.title,style:widget.model.isDone ?AppTheme.doneTitleStyle
                  :AppTheme.tackTitleTextStyle,),
                  SizedBox(height: 6),
                  Text(widget.model.description,style: AppTheme.tackDescriptionTextStyle,textAlign: TextAlign.start,)
                ],
              ),
              Spacer(),
              InkWell(
                onTap: (){
                  widget.model.isDone = true;
                  provider.updateTask(widget.model);
                },
                child: widget.model.isDone ? Text("Done!",style: AppTheme.doneTitleStyle,) : Container(
                  padding: EdgeInsets.symmetric(vertical: 6,horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child:
                  Icon(Icons.check,color: AppColor.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
