import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

import '../../data.dart';


class PizzaProvider {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  Future<List<Pizza>> getPizzas() async {
    try {
      return await pizzaCollection
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) => value.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) => 
          PizzaMapper.fromEntity(PizzaEntity.fromJson(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}