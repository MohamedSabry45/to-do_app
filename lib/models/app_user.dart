import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  static const collectionName = "users";
  static AppUser? currentUser;
  String? id;
  String? email;
  String? username;

  AppUser({required this.id,required this.email,required this.username});

  AppUser.fromJson(Map json){
    id = json["id"];
    email = json["email"];
    username = json["username"];

  }

  Map<String , Object?> toJson(){
    return {
      "id" : id,
      "email" : email,
      "username" : username,
    };
  }

  static CollectionReference<AppUser> collection(){
    return FirebaseFirestore.instance.collection(AppUser.collectionName).
      withConverter<AppUser>(
     fromFirestore: (snapshot ,_){
      Map json = snapshot.data() as Map;
      AppUser user = AppUser.fromJson(json);
      return user;
    },
    toFirestore: (user,_){
      return user.toJson();
    }
);
  }

}