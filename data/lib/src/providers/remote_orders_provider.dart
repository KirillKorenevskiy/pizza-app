import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data.dart';

class RemoteOrdersProvider {
  final CollectionReference<Map<String, dynamic>> _ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  Future<void> addOrder(OrderEntity order) async {
    final DocumentReference<Map<String, dynamic>> newOrderDoc =
        _ordersCollection.doc();
    final String newOrderId = newOrderDoc.id;

    final OrderEntity updatedOrder = order.copyWith(
      id: newOrderId,
    );

    await newOrderDoc.set(updatedOrder.toJson());
  }

  Future<OrderEntity?> getOrderById(String orderId) async {
    final DocumentSnapshot<Map<String, dynamic>> doc =
        await _ordersCollection.doc(orderId).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return OrderEntity.fromJson(doc.data()!);
  }

  Future<List<OrderEntity>> getUserOrders(String userId) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _ordersCollection
        .where(
          'userId',
          isEqualTo: userId,
        )
        .get();

    if (snapshot.docs.isEmpty) {
      return <OrderEntity>[];
    }

    return snapshot.docs
        .map(
          (QueryDocumentSnapshot<Map<String, dynamic>> doc) =>
              OrderEntity.fromJson(doc.data()),
        )
        .toList();
  }
}
