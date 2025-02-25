abstract class StorageConstants {
  static const String databaseName = 'pizza_app.db';

  static const String cartTableName = 'Cart';
  static const String cartIdColumn = 'id';
  static const String cartQuantityColumn = 'quantity';

  static const String detailsTableName = 'Details';
  static const String pizzaIdColumn = 'pizzaId';
  static const String sizeColumn = 'size';
  static const String ingredientsColumn = 'ingredients';

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

  static const String detailsCreateCommand = 'CREATE TABLE $detailsTableName('
      '$pizzaIdColumn TEXT PRIMARY KEY, '
      '$sizeColumn INTEGER, '
      '$ingredientsColumn TEXT)';

  static const String detailsInsertCommand = 'INSERT INTO $detailsTableName('
      '$pizzaIdColumn, '
      '$sizeColumn, '
      '$ingredientsColumn) '
      'VALUES(?, ?, ?)';

  static const String updateDetailCommand = 'UPDATE $detailsTableName '
      'SET $sizeColumn = COALESCE(?, $sizeColumn), '
      '$ingredientsColumn = COALESCE(?, $ingredientsColumn) '
      'WHERE $pizzaIdColumn = ?';

  static const String detailDeleteCommand =
      'DELETE FROM $detailsTableName WHERE $pizzaIdColumn = ?';

  static const String detailsSelectAllCommand =
      'SELECT * FROM $detailsTableName';

  static const String detailSelectByIdCommand =
      'SELECT * FROM $detailsTableName WHERE $pizzaIdColumn = ?';
}
