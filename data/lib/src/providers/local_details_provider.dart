import 'package:core/core.dart';
import 'package:sqflite/sqflite.dart';

import '../../data.dart';

class LocalDetailsProvider {
  final DatabaseConfig _databaseConfig;

  LocalDetailsProvider(this._databaseConfig);

  Future<List<DetailsEntity>> getDetails(String userId) async {
    final Database database = await _databaseConfig.database;

    final List<Map<String, Object?>> rawDetails = await database.rawQuery(
      StorageConstants.detailsSelectAllCommand,
      <Object?>[
        userId,
      ],
    );

    final List<DetailsEntity> result = rawDetails.map(
      (Map<String, Object?> item) {
        return DetailsEntity(
          pizzaId: item['pizzaId'] as String? ?? ' ',
          userId: item['userId'] as String? ?? ' ',
          size: item['size'] as int? ?? 0,
          ingredients: item['ingredients'] as String? ?? ' ',
        );
      },
    ).toList();

    return result;
  }

  Future<DetailsEntity?> getDetailById(String id, String userId) async {
    final Database database = await _databaseConfig.database;

    final List<Map<String, Object?>> rawDetail = await database.rawQuery(
      StorageConstants.detailSelectByIdCommand,
      <Object?>[
        id,
        userId,
      ],
    );

    if (rawDetail.isEmpty) {
      return null;
    }

    final Map<String, Object?> item = rawDetail.first;

    return DetailsEntity(
      pizzaId: item['id'] as String? ?? ' ',
      userId: item['userId'] as String? ?? ' ',
      size: item['size'] as int? ?? 0,
      ingredients: item['ingredients'] as String? ?? ' ',
    );
  }

  Future<void> updateDetail({
    required String id,
    required String userId,
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
        userId,
      ],
    );
  }

  Future<void> deleteDetail(String id, String userId) async {
    final Database database = await _databaseConfig.database;

    await database.rawDelete(
      StorageConstants.detailDeleteCommand,
      <Object?>[
        id,
        userId,
      ],
    );
  }

  Future<void> addDetails({
    required String id,
    required String userId,
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
        userId,
      ],
    );
  }

  Future<void> clearDetails() async {
    final Database database = await _databaseConfig.database;

    await database.execute(StorageConstants.detailsClearCommand);
  }
}
