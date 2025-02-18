import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data.dart';

class RemotePizzaProvider {
  final CollectionReference<Map<String, dynamic>> _pizzaCollection =
      FirebaseFirestore.instance.collection('pizzas');

  Future<List<PizzaEntity>> getPizzas() async {
    try {
      return await _pizzaCollection.get().then(
          (QuerySnapshot<Map<String, dynamic>> value) => value.docs
              .map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
                  PizzaEntity.fromJson(e.data()))
              .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<PizzaEntity> getPizzaById(String id) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _pizzaCollection
              .where(
                'pizzaId',
                isEqualTo: id,
              )
              .get();
      final Map<String, dynamic> data = querySnapshot.docs.first.data();
      return PizzaEntity.fromJson(data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
