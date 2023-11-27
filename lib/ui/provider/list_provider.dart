import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/app_user.dart';
import '../../models/todo_dm.dart';

class ListProvider extends ChangeNotifier {
  List<TodoDM> todos = [];
  DateTime seletedDate = DateTime.now();

  refreshTodosList() async {
    CollectionReference<TodoDM> todosCollection =
    AppUser.collection().doc(AppUser.currentUser!.id).collection("todos")
        .withConverter<TodoDM>(
        fromFirestore: (docSnapshot, _) {
          Map json = docSnapshot.data() as Map;
          TodoDM todo = TodoDM.fromJson(json);
          return todo;
        },
        toFirestore: (todoDm, _) {
          return todoDm.toJson();
        });
    QuerySnapshot<TodoDM> todosSnapshot = await todosCollection.orderBy("date")
        .get();
    List<QueryDocumentSnapshot<TodoDM>> docs = todosSnapshot.docs;
    todos = docs.map((docSnapshot) {
      return docSnapshot.data();
    }).toList();

    todos = todos.where((todo) {
      if (todo.date.day != seletedDate.day ||
          todo.date.month != seletedDate.month ||
          todo.date.year != seletedDate.year) {
        return false;
      } else {
        return true;
      }
    }).toList();
    notifyListeners();
  }

  updateTask(TodoDM todoDM)async{
    CollectionReference todosCollection =
    AppUser.collection().doc(AppUser.currentUser!.id).collection("todos");
    todosCollection.doc(todoDM.id)
        .update(todoDM.toJson()).then((value) {
          refreshTodosList();
          notifyListeners();
  });
  }
}