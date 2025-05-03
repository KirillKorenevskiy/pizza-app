import 'dart:async';

import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/cart_item_entity.dart';

class LocalCartProvider {
  final DatabaseConfig _databaseConfig;

  final StreamController<List<CartItemEntity>> _cartStreamController =
      StreamController<List<CartItemEntity>>();

  List<CartItemEntity> _currentCartItems = <CartItemEntity>[];

  Stream<List<CartItemEntity>> get cartStream => _cartStreamController.stream;

  LocalCartProvider(this._databaseConfig);

  Future<void> addToCart(CartItemEntity entity) async {
    final Database database = await _databaseConfig.database;

    await database.rawInsert(
      StorageConstants.cartInsertCommand,
      <Object?>[
        entity.id,
        1,
        entity.userId,
      ],
    );

    await _notifyCartChanged(entity.userId);
  }

  Future<List<CartItemEntity>> getCarts(String userId) async {
    final Database database = await _databaseConfig.database;
    final List<Map<String, Object?>> rawCarts = await database.rawQuery(
      StorageConstants.cartSelectAllCommand,
      <Object?>[
        userId,
      ],
    );

    final List<CartItemEntity> result = rawCarts.map(
      (Map<String, Object?> item) {
        return CartItemEntity(
          id: item['id'] as String? ?? ' ',
          quantity: item['quantity'] as int? ?? 0,
          userId: item['userId'] as String? ?? ' ',
        );
      },
    ).toList();

    _currentCartItems = result;
    _cartStreamController.add(_currentCartItems);

    return result;
  }

  Future<void> removeFromCart(String id, String userId) async {
    final Database database = await _databaseConfig.database;

    await database.rawDelete(
      StorageConstants.cartDeleteCommand,
      <Object?>[
        id,
        userId,
      ],
    );

    await _notifyCartChanged(userId);
  }

  Future<bool> isInCart(String pizzaId, String userId) async {
    final Database database = await _databaseConfig.database;
    final List<Map<String, Object?>> rawCart = await database.rawQuery(
      StorageConstants.cartSelectByIdCommand,
      <Object?>[
        pizzaId,
        userId,
      ],
    );

    return rawCart.isNotEmpty;
  }

  Future<void> updateQuantity(
    String id,
    int newQuantity,
    String userId,
  ) async {
    final Database database = await _databaseConfig.database;

    await database.rawUpdate(
      StorageConstants.quantityUpdateCommand,
      <Object?>[
        newQuantity,
        id,
        userId,
      ],
    );

    await _notifyCartChanged(userId);
  }

  Future<void> clearCart(String userId) async {
    final Database database = await _databaseConfig.database;

    await database.execute(
      StorageConstants.cartClearCommand,
      <Object?>[
        userId,
      ],
    );
  }

  Future<void> _notifyCartChanged(String userId) async {
    final List<CartItemEntity> updatedCart = await getCarts(userId);

    _cartStreamController.sink.add(updatedCart);
  }

  void dispose() {
    _cartStreamController.close();
  }
}
