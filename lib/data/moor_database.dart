import 'dart:io';

import 'package:catalogo/graphql/queries.dart';
import 'package:catalogo/model/audiovisual/AudiovisualModel.dart';
import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'moor_database.g.dart';

class AudiovisualTable extends Table {
  IntColumn get id => integer()();

  TextColumn get titulo => text()();

  TextColumn get sinopsis => text()();

  TextColumn get categoria => text()();

  TextColumn get categoria2 => text()();

  TextColumn get anno => text()();

  TextColumn get pais => text()();

  TextColumn get idioma => text()();

  TextColumn get director => text()();

  TextColumn get reparto => text()();

  TextColumn get productora => text()();

  TextColumn get temp => text()();

  TextColumn get duracion => text()();

  TextColumn get capitulos => text()();

  TextColumn get notas => text()();

  TextColumn get tamanno => text()();

  TextColumn get formato => text()();

  TextColumn get estado => text()();

  TextColumn get fecha_reg => text()();

  TextColumn get fecha_act => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'audiovisualdb';
}

class CategoriaTable extends Table {
  TextColumn get id => text()();

  TextColumn get name => text().named('nombre')();

  TextColumn get parent => text().named('id_padre').nullable()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  String get tableName => 'categoria';
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

@UseMoor(tables: [CategoriaTable, AudiovisualTable])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<CategoriaTableData>> getAllCategorias() =>
      select(categoriaTable).get();

  Future insertCategoria(List<CategoriaTableData> categoriaTableDataList) {
    return batch((b) {
      b.insertAll(categoriaTable,
          categoriaTableDataList, mode: InsertMode.insertOrReplace);
    });
  }

  Future<int> findAudiovisualCount(String category, {String genre}) async {
    int resultCount = -1;
    try {
      var query;

      if (genre != null) {
        query = customSelectQuery(
            'select count(*) as count from ${audiovisualTable.actualTableName} '
                'where ${audiovisualTable.categoria.escapedName} = $category ');
      } else {
        query = customSelectQuery(
            'select count(*) as count from ${audiovisualTable.actualTableName} '
                'where ${audiovisualTable.categoria.escapedName} = $category '
                ' and ${audiovisualTable.categoria2.escapedName} = $genre');
      }

      resultCount = query[0].data['count'];
    } catch (e) {
      print(e);
    }
    return await new Future<int>(() => resultCount);
  }

  Future<List<AudiovisualModel>> findAudiovisualList(int limit, int skip,
      String category, String genre, String title) async {
    List<AudiovisualModel> resultList = [];
    try {
      var categoryWhere = audiovisualTable.categoria.like('%%');
      var genreWhere = audiovisualTable.categoria2.like('%%');
      var tituloWhere = audiovisualTable.titulo.like('%%');

      var joiners = [];
//type 'List<dynamic>' is not a subtype of type 'List<Join<Table, DataClass>>'
      if (category != null && category.isNotEmpty) {
        categoryWhere = audiovisualTable.categoria.equals(category);
        joiners.add(innerJoin(
            categoriaTable, categoriaTable.id.equals(category)));
      }
      if (genre != null && genre.isNotEmpty) {
        genreWhere = audiovisualTable.categoria2.equals(genre);
        joiners.add(innerJoin(
            categoriaTable, categoriaTable.id.equals(genre)));
      }
      if (title != null && title.isNotEmpty) {
        tituloWhere = audiovisualTable.titulo.like('%$title%');
      }

      var query = select(audiovisualTable);
      query.limit(limit, offset: skip);
      query.where((a) => and(categoryWhere, and(genreWhere, tituloWhere)));

      var results = await query.join([
        innerJoin(
            categoriaTable, categoriaTable.id.equals(category)),
//        innerJoin(categoriaTable, categoriaTable.id.equals(int.parse(genre)))
      ]).get();
//      query.orderBy(([
//        (r) => OrderingTerm(expression: r.titulo, mode: OrderingMode.asc),
//      ]));

//      var results = await query.get();
      return results.map((row) {
        final a = row.readTable(audiovisualTable);
        final c = row.readTable(categoriaTable);
        return AudiovisualModel.build(
            anno: a.anno,
//          genre:
            capitulos: a.capitulos,
            director: a.director,
            duracion: a.duracion,
            formato: a.formato,
            idioma: a.idioma,
            pais: a.pais,
            productora: a.productora,
            reparto: a.reparto,
            sinopsis: a.sinopsis,
            tamanno: a.tamanno,
            titulo: a.titulo);
      }).toList();
      print(results);
    } catch (e) {
      print(e);
    }
    return await new Future<List<AudiovisualModel>>(() => resultList);
  }
}
