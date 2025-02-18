abstract class StorageConstants {
  static const String databaseName = 'pizza_app.db';

  static const String cartTableName = 'Cart';
  static const String cartIdColumn = 'id';
  static const String cartQuantityColumn = 'quantity';

  static const String cartCreateCommand = 'CREATE TABLE $cartTableName('
      '$cartIdColumn TEXT PRIMARY KEY, '
      '$cartQuantityColumn INTEGER)';

  static const String cartInsertCommand = 'INSERT INTO $cartTableName('
      '$cartIdColumn, '
      '$cartQuantityColumn) '
      'VALUES(?, ?)';

  static const String quantityUpdateCommand = 'UPDATE $cartTableName SET '
      '$cartQuantityColumn = ? WHERE $cartIdColumn = ?';

  static const String quantitySelectCommand =
      'SELECT $cartQuantityColumn FROM $cartTableName WHERE $cartIdColumn = ?';

  static const String cartSelectAllCommand = 'SELECT * FROM $cartTableName';

  static const String cartSelectByIdCommand =
      'SELECT * FROM $cartTableName WHERE $cartIdColumn = ?';

  static const String cartDeleteCommand =
      'DELETE FROM $cartTableName WHERE $cartIdColumn = ?';
}
