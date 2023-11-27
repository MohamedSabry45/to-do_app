import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/app_user.dart';
import 'package:to_do/ui/provider/list_provider.dart';
import 'package:to_do/ui/utilits/app_color.dart';
import 'package:to_do/ui/utilits/app_theme.dart';
import 'package:to_do/ui/widgets/my_text_field.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late ListProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.all(18),
      child: Container(
        height: MediaQuery.of(context).size.height * .4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Add New Task",textAlign: TextAlign.center,
            style: AppTheme.bottomSheetTitleTextStyle,),
            SizedBox(height: 8),
            MyTextField(hintText: "Enter your task", controller:titleController ),
            SizedBox(height: 8),
            MyTextField(hintText: "Enter task description", controller:descriptionController),
            SizedBox(height: 30),
            Text("Select date" ,style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.w500)),
            SizedBox(height: 4),
            InkWell(
              onTap: (){
              showMyDate();
              },
              child: Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}", style: AppTheme.bottomSheetTitleTextStyle.copyWith(fontWeight: FontWeight.normal
              ,color: AppColor.grey),textAlign: TextAlign.center,),
            ),
            Spacer(),
            ElevatedButton(onPressed: (){
              addToDoFireBase();
            },
                child: Text("Add")
            )
          ],
        ),
      ),
    );

  }

  void addToDoFireBase() async {
    CollectionReference todosCollectionRef =
    AppUser.collection().doc(AppUser.currentUser!.id).collection("todos");
    DocumentReference newEmptyDoc =  todosCollectionRef.doc();

    await newEmptyDoc.set({
      "id" : newEmptyDoc.id ,
      "title" : titleController.text,
      "description" : descriptionController.text,
      "date" : selectedDate,
      "isDone" : false,
    });

    provider.refreshTodosList();
    Navigator.pop(context);
  }

  void showMyDate() async{
  selectedDate =  await showDatePicker(context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1095))) ?? selectedDate;
  setState(() {});
  }

}
