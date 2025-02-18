import 'dart:async';

import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/cart_item_entity.dart';

class LocalCartProvider {
  final DatabaseConfig _databaseConfig;

  final StreamController<List<CartItemEntity>> _cartStreamController =
      StreamController<List<CartItemEntity>>();

  List<CartItemEntity> _currentCartItems = <CartItemEntity>[];

  Stream<List<CartItemEntity>> get cartStream =>
      _cartStreamController.stream;

  LocalCartProvider(this._databaseConfig);

  Future<void> addToCart(CartItemEntity entity) async {
    final Database database = await _databaseConfig.database;

    await database.rawInsert(
      StorageConstants.cartInsertCommand,
      <Object?>[
        entity.id,
        1,
      ],
    );

    await _notifyCartChanged();
  }

  Future<List<CartItemEntity>> getCarts() async {
    final Database database = await _databaseConfig.database;
    final List<Map<String, Object?>> rawCarts = await database.rawQuery(
      StorageConstants.cartSelectAllCommand,
    );

    final List<CartItemEntity> result = rawCarts.map(
      (Map<String, Object?> item) {
        return CartItemEntity(
          id: item['id'] as String? ?? ' ',
          quantity: item['quantity'] as int? ?? 0,
        );
      },
    ).toList();

    _currentCartItems = result;
    _cartStreamController.add(_currentCartItems);

    return result;
  }

  Future<void> removeFromCart(String id) async {
    final Database database = await _databaseConfig.database;

    await database.rawDelete(
      StorageConstants.cartDeleteCommand,
      <Object?>[
        id,
      ],
    );

    await _notifyCartChanged();
  }

  Future<bool> isInCart(String id) async {
    final Database database = await _databaseConfig.database;
    final List<Map<String, Object?>> rawCart = await database.rawQuery(
      StorageConstants.cartSelectByIdCommand,
      <Object?>[
        id,
      ],
    );

    return rawCart.isNotEmpty;
  }

  Future<void> updateQuantity(String id, int newQuantity) async {
    final Database database = await _databaseConfig.database;

    await database.rawUpdate(
      StorageConstants.quantityUpdateCommand,
      <Object?>[
        newQuantity,
        id,
      ],
    );

    await _notifyCartChanged();
  }

  Future<void> _notifyCartChanged() async {
    final List<CartItemEntity> updatedCart = await getCarts();

    _cartStreamController.sink.add(updatedCart);
  }

  void dispose() {
    _cartStreamController.close();
  }
}
