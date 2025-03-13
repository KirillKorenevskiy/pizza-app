import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data.dart';

class RemotePizzeriasProvider {
  final CollectionReference<Map<String, dynamic>> _pizzerriasCollection =
      FirebaseFirestore.instance.collection('pizzerias');

  Future<List<AddressEntity>> getPizzeriasAddresses() async {
    final QuerySnapshot<Map<String, dynamic>> pizzerias =
        await _pizzerriasCollection.get();

    return pizzerias.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> e) =>
              AddressEntity.fromJson(e.data()),
        )
        .toList();
  }
}
