import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_dm.dart';
import 'package:to_do/ui/provider/list_provider.dart';
import 'package:to_do/ui/screens/home/home_screen.dart';
import 'package:to_do/ui/utilits/app_color.dart';
import 'package:to_do/ui/utilits/app_theme.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = "editTask";

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    Size size = MediaQuery.of(context).size;
    TodoDM todoDM = ModalRoute.of(context)!.settings.arguments as TodoDM;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              AppBar(
                title: Text("To Do List"),
                flexibleSpace: SizedBox(height: size.height * .2),
              ),
            ],
          ),
          Center(
            child: Container(
              height: size.height * .7,
              width:  size.width * .8,
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Edit Task",style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,),
                    SizedBox(height: 18),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your title"
                      ),
                      initialValue: todoDM.title ,
                      onChanged: (vaule){
                        todoDM.title = vaule;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Enter your description"
                      ),
                      initialValue: todoDM.description ,
                      onChanged: (vaule){
                        todoDM.description = vaule;
                      },
                    ),
                    SizedBox(height: 18,),
                    Text("Select time",style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.w400),),
                    SizedBox(height: 12),
                    InkWell(
                      onTap: (){
                        showDate(todoDM);
                      },
                        child: Text("${todoDM.date.day}-${todoDM.date.month}-${todoDM.date.year}"
                        ,textAlign: TextAlign.center,style : TextStyle(fontSize: 18,
                                fontWeight: FontWeight.w400,color: AppColor.grey))),
                    SizedBox(height: 20),
                    ElevatedButton(onPressed: (){
                      provider.updateTask(todoDM);
                      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                    }, child: Text("Save Changes"))

                  ],
                ),
              ),
            ),

          )
        ]
      ),

    );
  }

  void showDate(TodoDM myToDo) async{
    myToDo.date =  await showDatePicker(context: context,
        initialDate:  myToDo.date,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 1095))) ??  myToDo.date;
    setState(() {});
  }
}
