import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/app_user.dart';
import 'package:to_do/ui/provider/list_provider.dart';
import 'package:to_do/ui/screens/auth/login/login_screen.dart';

class SettingsScreen extends StatefulWidget {


  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

}

class _SettingsScreenState extends State<SettingsScreen> {
  late ListProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(30),
       child: Column(
         children: [

           InkWell(
             onTap: (){
               AppUser.currentUser = null;
               provider.todos.clear();
               Navigator.pushReplacementNamed(context, LoginScreen.routeName);
             },
             child: Row(
               children: [
                 Text("LogOut",style: TextStyle(fontSize: 18),),
                 Spacer(),
                 Icon(Icons.login,size: 24,)
               ],
             ),
           )
         ],
       ),
     )


    );
  }
}
