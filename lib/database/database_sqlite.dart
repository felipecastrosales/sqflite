import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  Future<void> oppenConnection() async {
    final databasePath = await getDatabasesPath();
    final databaseFinalPath = join(
      databasePath,
      'SQLITE_EXAMPLE',
    );

    print(databasePath);
    print(databaseFinalPath);
    await openDatabase(
      databaseFinalPath,
      version: 1,
      // only in moment: creation and loading app
      onCreate: (db, version) async {
        print('calling onCreate');
        final batch = db.batch();
        batch.execute('''
        create table teste(
          id Integer primary key autoincrement,
          name varchar(200)
        )
        ''');
      },
      // only in moment: any changes incremental | 1 -> 2
      onUpgrade: (db, oldVersion, newVersion) async {
        print('calling onUpgrade');
      },
      // only in moment: any changes decremental | 2 -> 1
      onDowngrade: (db, oldVersion, newVersion) async {
        print('calling onDowngrade');
      },
    );
  }
}
