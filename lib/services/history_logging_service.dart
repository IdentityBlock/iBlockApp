import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

const String table = 'history';
const String txhashColumn = 'txhash';
const String verifierNameColumn = 'verifierName';
const String verifierContractAddressColumn = 'verifierContractAddress';

class HistoryRecord {
  String txhash = '';
  String verifierName = '';
  String verifierContractAddress = '';

  Map<String, String> toMap() {
    var map = <String, String>{
      txhashColumn: txhash,
      verifierNameColumn: verifierName,
      verifierContractAddressColumn: verifierContractAddress
    };
    return map;
  }

  HistoryRecord({this.txhash="", this.verifierName = "", this.verifierContractAddress=""});

  HistoryRecord fromMap(Map<dynamic, dynamic> map) {
    txhash = map[txhashColumn] as String;
    verifierName = map[verifierNameColumn] as String;
    verifierContractAddress = map[verifierContractAddressColumn] as String;
    return this;
  }
}

class HistoryLoggingService {
  late Database db;

  Future open() async {
    WidgetsFlutterBinding.ensureInitialized();
    var path = 'assets/db/log.db';
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table if not exists $table ( 
  $txhashColumn text primary key, 
  $verifierNameColumn text not null,
  $verifierContractAddressColumn text not null)
''');
    });
  }

  Future<int> insert(HistoryRecord record) async {
    int id = await db.insert(table, record.toMap());
    return id;
  }

  Future<int> delete(String tx) async {
    return await db.delete(table, where: '$txhashColumn = ?', whereArgs: [tx]);
  }

  Future<List<HistoryRecord>> getAll() async {
    List<Map> maps = await db.query(table, columns: [
      txhashColumn,
      verifierNameColumn,
      verifierContractAddressColumn
    ]);

    return maps.map((e) {
      HistoryRecord record = HistoryRecord();
      record.fromMap(e);
      return record;
    }).toList();
  }

  Future close() async => db.close();
}
