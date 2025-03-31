import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';

import '../../data.dart';

class LocalDetailsProvider {
  final DatabaseConfig _databaseConfig;

  LocalDetailsProvider(this._databaseConfig);

  Future<List<DetailsEntity>> getDetails() async {
    final Database database = await _databaseConfig.database;

    final List<Map<String, Object?>> rawDetails = await database.rawQuery(
      StorageConstants.detailsSelectAllCommand,
    );

    final List<DetailsEntity> result = rawDetails.map(
      (Map<String, Object?> item) {
        return DetailsEntity(
          pizzaId: item['pizzaId'] as String? ?? ' ',
          size: item['size'] as int? ?? 0,
          ingredients: item['ingredients'] as String? ?? ' ',
        );
      },
    ).toList();

    return result;
  }

  Future<DetailsEntity?> getDetailById(String id) async {
    final Database database = await _databaseConfig.database;

    final List<Map<String, Object?>> rawDetail = await database.rawQuery(
      StorageConstants.detailSelectByIdCommand,
      <Object?>[
        id,
      ],
    );

    if (rawDetail.isEmpty) {
      return null;
    }

    final Map<String, Object?> item = rawDetail.first;

    return DetailsEntity(
      pizzaId: item['id'] as String? ?? ' ',
      size: item['size'] as int? ?? 0,
      ingredients: item['ingredients'] as String? ?? ' ',
    );
  }

  Future<void> updateDetail({
    required String id,
    int? size,
    String? ingredients,
  }) async {
    final Database database = await _databaseConfig.database;

    await database.rawUpdate(
      StorageConstants.updateDetailCommand,
      <Object?>[
        size,
        ingredients,
        id,
      ],
    );
  }

  Future<void> deleteDetail(String id) async {
    final Database database = await _databaseConfig.database;

    await database.rawDelete(
      StorageConstants.detailDeleteCommand,
      <Object?>[
        id,
      ],
    );
  }

  Future<void> addDetails({
    required String id,
    required int? size,
    required String? ingredients,
  }) async {
    final Database database = await _databaseConfig.database;

    await database.rawInsert(
      StorageConstants.detailsInsertCommand,
      <Object?>[
        id,
        size,
        ingredients,
      ],
    );
  }

  Future<void> clearDetails() async {
    final Database database = await _databaseConfig.database;

    await database.execute(StorageConstants.detailsClearCommand);
  }
}
