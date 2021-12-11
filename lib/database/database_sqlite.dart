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
      version: 2,
      onConfigure: (db) async {
        print('calling onConfigure');
          await db.execute(
            'PRAGMA foreign_keys = ON',
        );
      },
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

        batch.execute('''
        create table product(
          id Integer primary key autoincrement,
          name varchar(200)
        )
        ''');

        // batch.execute('''
        // create table category(
        //   id Integer primary key autoincrement,
        //   name varchar(200)
        // )
        // ''');
        batch.commit();
      },
      // only in moment: any changes incremental | 1 -> 2
      onUpgrade: (db, oldVersion, newVersion) async {
        print('calling onUpgrade');
        final batch = db.batch();
        if (oldVersion == 1) {
          batch.execute('''
        create table product(
          id Integer primary key autoincrement,
          name varchar(200)
        )
        ''');
        //   batch.execute('''
        // create table category(
        //   id Integer primary key autoincrement,
        //   name varchar(200)
        // )
        // ''');
        }
        // if (oldVersion == 2) {
        //   batch.execute('''
        // create table category(
        //   id Integer primary key autoincrement,
        //   name varchar(200)
        // )
        // ''');
        // }
        batch.commit();
      },
      // only in moment: any changes decremental | 2 -> 1
      onDowngrade: (db, oldVersion, newVersion) async {
        print('calling onDowngrade');
        final batch = db.batch();
        if (oldVersion == 3) {
          batch.execute('''
          drop table category
          ''');
        }
        batch.commit();
      },
    );
  }
}
