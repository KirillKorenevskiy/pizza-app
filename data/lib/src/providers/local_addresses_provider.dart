import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';

import '../../data.dart';

class LocalAddressesProvider {
  final DatabaseConfig _databaseConfig;

  LocalAddressesProvider(this._databaseConfig);

  Future<void> insertAddress(AddressEntity address) async {
    final Database db = await _databaseConfig.database;
    await db.rawInsert(
      StorageConstants.addressesInsertCommand,
      <Object?>[
        address.id,
        address.address,
        address.latitude,
        address.longitude,
        address.type,
      ],
    );
  }

  Future<void> updateAddress(AddressEntity address) async {
    final Database db = await _databaseConfig.database;
    await db.rawUpdate(
      StorageConstants.addressUpdateCommand,
      <Object?>[
        address.address,
        address.latitude,
        address.longitude,
        address.type,
        address.id,
      ],
    );
  }

  Future<List<AddressEntity>> getAllAddresses() async {
    final Database db = await _databaseConfig.database;
    final List<Map<String, Object?>> maps =
        await db.rawQuery(StorageConstants.addressesSelectAllCommand);
    return maps.map(AddressEntity.fromJson).toList();
  }

  Future<AddressEntity?> getAddressById(String id) async {
    final Database db = await _databaseConfig.database;
    final List<Map<String, Object?>> result = await db.rawQuery(
      '${StorageConstants.addressesSelectAllCommand} WHERE ${StorageConstants.addressIdColumn} = ?',
      <Object?>[id],
    );
    if (result.isEmpty) return null;
    return AddressEntity.fromJson(result.first);
  }

  Future<void> deleteAddress(String id) async {
    final Database db = await _databaseConfig.database;
    await db.rawDelete(StorageConstants.addressesDeleteCommand, <Object?>[id]);
  }
}
