import 'package:flutter/material.dart';

import 'database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _database();
  }

  void _database() async {
    var database = await DatabaseSqLite().oppenConnection();
    // database.insert(
    //   'user',
    //   {
    //     'name': 'Felipe',
    //   },
    // );
    // database.delete(
    //   'user',
    //   where: 'name = ?',
    //   whereArgs: ['Felipe'],
    // );
    // database.update(
    //   'user',
    //   {
    //     'name': 'Felipe Sales',
    //   },
    //   whereArgs: ['Felipe'],
    // );
    // var result = database.query('user');
    // print(result);
    // database.rawInsert(
    //   'insert into user values(null ?)',
    //   ['Felipe'],
    // );
    // database.rawUpdate(
    //   'update user set name = ? where id = ?',
    //   ['Felipe Sales', 1],
    // );
    // database.rawDelete(
    //   'delete from user where id = ?',
    //   [1],
    // );
    database.rawQuery('select * from user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: Container(),
    );
  }
}
