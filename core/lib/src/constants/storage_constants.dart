abstract class StorageConstants {
  static const String databaseName = 'pizza_app.db';

  static const String cartTableName = 'Cart';
  static const String userIdColumn = 'userId';
  static const String cartIdColumn = 'id';
  static const String cartQuantityColumn = 'quantity';

  static const String detailsTableName = 'Details';
  static const String pizzaIdColumn = 'pizzaId';
  static const String sizeColumn = 'size';
  static const String ingredientsColumn = 'ingredients';

  static const String addressesTableName = 'Addresses';
  static const String addressIdColumn = 'id';
  static const String addressColumn = 'address';
  static const String latitudeColumn = 'latitude';
  static const String longitudeColumn = 'longitude';
  static const String addressTypeColumn = 'type';

  static const String cartCreateCommand = 'CREATE TABLE $cartTableName('
      '$cartIdColumn TEXT, '
      '$cartQuantityColumn INTEGER, '
      '$userIdColumn TEXT, '
      'PRIMARY KEY($cartIdColumn, $userIdColumn))';

  static const String cartInsertCommand = 'INSERT INTO $cartTableName('
      '$cartIdColumn, '
      '$cartQuantityColumn,'
      '$userIdColumn) '
      'VALUES(?, ?, ?)';

  static const String quantityUpdateCommand = 'UPDATE $cartTableName SET '
      '$cartQuantityColumn = ? WHERE $cartIdColumn = ? AND $userIdColumn = ?';

  static const String quantitySelectCommand =
      'SELECT $cartQuantityColumn FROM $cartTableName WHERE $cartIdColumn = ? '
      'AND $userIdColumn = ?';

  static const String cartSelectAllCommand =
      'SELECT * FROM $cartTableName WHERE $userIdColumn = ?';

  static const String cartSelectByIdCommand =
      'SELECT * FROM $cartTableName WHERE $cartIdColumn = ? AND $userIdColumn = ?';

  static const String cartDeleteCommand =
      'DELETE FROM $cartTableName WHERE $cartIdColumn = ? AND $userIdColumn = ?';

  static const String cartClearCommand =
      'DELETE FROM $cartTableName WHERE $userIdColumn = ?';

  static const String detailsCreateCommand = 'CREATE TABLE $detailsTableName('
      '$pizzaIdColumn TEXT, '
      '$sizeColumn INTEGER, '
      '$ingredientsColumn TEXT, '
      '$userIdColumn TEXT, '
      'PRIMARY KEY(pizzaId, userId))';

  static const String detailsInsertCommand = 'INSERT INTO $detailsTableName('
      '$pizzaIdColumn, '
      '$sizeColumn, '
      '$ingredientsColumn, '
      '$userIdColumn) '
      'VALUES(?, ?, ?, ?)';

  static const String updateDetailCommand = 'UPDATE $detailsTableName '
      'SET $sizeColumn = COALESCE(?, $sizeColumn), '
      '$ingredientsColumn = COALESCE(?, $ingredientsColumn) '
      'WHERE $pizzaIdColumn = ? AND $userIdColumn = ?';

  static const String detailDeleteCommand =
      'DELETE FROM $detailsTableName WHERE $pizzaIdColumn = ? AND $userIdColumn = ?';

  static const String detailsSelectAllCommand =
      'SELECT * FROM $detailsTableName WHERE $userIdColumn = ?';

  static const String detailSelectByIdCommand =
      'SELECT * FROM $detailsTableName WHERE $pizzaIdColumn = ? AND $userIdColumn = ?';

  static const String detailsClearCommand =
      'DELETE FROM $detailsTableName WHERE $userIdColumn = ?';

  static const String addressesCreateCommand =
      'CREATE TABLE $addressesTableName('
      '$addressIdColumn TEXT PRIMARY KEY, '
      '$addressColumn TEXT, '
      '$latitudeColumn REAL, '
      '$longitudeColumn REAL, '
      '$addressTypeColumn TEXT CHECK($addressTypeColumn IN ("home", "work")))';

  static const String addressesInsertCommand =
      'INSERT INTO $addressesTableName('
      '$addressIdColumn, '
      '$addressColumn, '
      '$latitudeColumn, '
      '$longitudeColumn, '
      '$addressTypeColumn) '
      'VALUES(?, ?, ?, ?, ?)';

  static const String addressUpdateCommand = 'UPDATE $addressesTableName '
      'SET $addressColumn = COALESCE(?, $addressColumn), '
      '$latitudeColumn = COALESCE(?, $latitudeColumn), '
      '$longitudeColumn = COALESCE(?, $longitudeColumn), '
      '$addressTypeColumn = COALESCE(?, $addressTypeColumn) '
      'WHERE $addressIdColumn = ?';

  static const String addressesSelectAllCommand =
      'SELECT * FROM $addressesTableName';

  static const String addressesDeleteCommand =
      'DELETE FROM $addressesTableName WHERE $addressIdColumn = ?';
}
