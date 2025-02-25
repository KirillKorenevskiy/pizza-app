import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data.dart';

class RemoteIngredientsProvider {
  final CollectionReference<Map<String, dynamic>> _ingredientsCollection =
      FirebaseFirestore.instance.collection('ingredients');

  Future<List<IngredientEntity>> getIngredients() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> ingredients =
          await _ingredientsCollection.get();

      return ingredients.docs
          .map(
            (QueryDocumentSnapshot<Map<String, dynamic>> e) =>
                IngredientEntity.fromJson(e.data()),
          )
          .toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<IngredientEntity> getIngredientById(String id) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _ingredientsCollection
              .where(
                'id',
                isEqualTo: id,
              )
              .get();
      final Map<String, dynamic> data = querySnapshot.docs.first.data();
      return IngredientEntity.fromJson(data);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
