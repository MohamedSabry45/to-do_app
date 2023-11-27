import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do/ui/provider/list_provider.dart';
import 'package:to_do/ui/screens/auth/login/login_screen.dart';
import 'package:to_do/ui/screens/auth/register/register_screen.dart';
import 'package:to_do/ui/screens/home/home_screen.dart';
import 'package:to_do/ui/screens/home/tabs/menu/edit_task_screen.dart';
import 'package:to_do/ui/screens/splash/splash_screen.dart';
import 'package:to_do/ui/utilits/app_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(
      ChangeNotifierProvider(
        create: (_) {
         return ListProvider();
        },
          child: MyApp()));
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routes: {
        EditTaskScreen.routeName: (_) => EditTaskScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) =>  RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        SplashScreen.routeName: (_) => SplashScreen()

      },
      initialRoute:SplashScreen.routeName,


    );
  }
}
