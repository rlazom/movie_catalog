import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_database.g.dart';

class AudiovisualTable extends Table {
  TextColumn get id => text()();

  TextColumn get titulo => text()();

  TextColumn get sinopsis => text()();

  TextColumn get category => text().nullable()();

  TextColumn get image => text().nullable()();

  TextColumn get genre => text()();

  TextColumn get anno => text().nullable()();

  TextColumn get pais => text().nullable()();

  TextColumn get score => text().nullable()();

  TextColumn get idioma => text().nullable()();

  TextColumn get director => text().nullable()();

  TextColumn get reparto => text().nullable()();

  TextColumn get productora => text().nullable()();

  TextColumn get temp => text().nullable()();

  TextColumn get duracion => text().nullable()();

  TextColumn get capitulos => text().nullable()();

  TextColumn get fecha_reg => text().nullable()();

  TextColumn get fecha_act => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  @override
  Set<Column> get primaryKey =>
      {
      id
      };

  @override
  String get tableName => 'audiovisualdb';
}

class GameTable extends Table {
  TextColumn get id => text()();

  TextColumn get titulo => text()();

  TextColumn get sinopsis => text()();

  TextColumn get category => text().nullable()();

  TextColumn get image => text().nullable()();

  TextColumn get genre => text()();

  TextColumn get plataformas => text()();

  DateTimeColumn get fechaLanzamiento => dateTime().nullable()();

  TextColumn get score => text().nullable()();

  TextColumn get empresa => text().nullable()();

  TextColumn get fecha_reg => text().nullable()();

  TextColumn get fecha_act => text().nullable()();

  BoolColumn get isFavourite => boolean().clientDefault(() => false)();

  @override
  Set<Column> get primaryKey =>
      {
      id
      };

  @override
  String get tableName => 'game';
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'database.db'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [AudiovisualTable, GameTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future insertAudiovisual(AudiovisualTableData data) {
    return batch((b) {
      b.insert(audiovisualTable,
          data, mode: InsertMode.insertOrReplace);
    });
  }

  Future updateAudiovisual(AudiovisualTableData data) {
    return batch((b) {
      b.update(audiovisualTable,data);
    });
  }

  Future getAudiovisualById(String id) async {
    print(id);
    var query = select(audiovisualTable);
    query.where((a) => a.id.equals(id));
    var result = await query.getSingle();
    if (result == null) {
      return null;
    }
    return result;
  }
  
  Future toogleAudiovisualFavourite(String id, bool newValue) async {
    var query = select(audiovisualTable);
    query.where((a) => a.id.equals(id));
    final av = await query.getSingle();
    print(av);
    if (av != null) {
      final result = await update(audiovisualTable).replace(
          av.copyWith(isFavourite: newValue));
      return newValue;
    }
    return newValue;
  }

  Future<List<AudiovisualTableData>> findAudiovisualList(int limit, int skip,
      String category, String genre, String title) async {
    List<AudiovisualTableData> resultList = [];
    return await new Future<List<AudiovisualTableData>>(() => resultList);
  }
}
