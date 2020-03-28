// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class CategoriaTableData extends DataClass
    implements Insertable<CategoriaTableData> {
  final String id;
  final String name;
  final String parent;
  CategoriaTableData({@required this.id, @required this.name, this.parent});
  factory CategoriaTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return CategoriaTableData(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}nombre']),
      parent: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}id_padre']),
    );
  }
  factory CategoriaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return CategoriaTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parent: serializer.fromJson<String>(json['parent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'parent': serializer.toJson<String>(parent),
    };
  }

  @override
  CategoriaTableCompanion createCompanion(bool nullToAbsent) {
    return CategoriaTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      parent:
          parent == null && nullToAbsent ? const Value.absent() : Value(parent),
    );
  }

  CategoriaTableData copyWith({String id, String name, String parent}) =>
      CategoriaTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        parent: parent ?? this.parent,
      );
  @override
  String toString() {
    return (StringBuffer('CategoriaTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parent: $parent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(name.hashCode, parent.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is CategoriaTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.parent == this.parent);
}

class CategoriaTableCompanion extends UpdateCompanion<CategoriaTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> parent;
  const CategoriaTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parent = const Value.absent(),
  });
  CategoriaTableCompanion.insert({
    @required String id,
    @required String name,
    this.parent = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  CategoriaTableCompanion copyWith(
      {Value<String> id, Value<String> name, Value<String> parent}) {
    return CategoriaTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parent: parent ?? this.parent,
    );
  }
}

class $CategoriaTableTable extends CategoriaTable
    with TableInfo<$CategoriaTableTable, CategoriaTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $CategoriaTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'nombre',
      $tableName,
      false,
    );
  }

  final VerificationMeta _parentMeta = const VerificationMeta('parent');
  GeneratedTextColumn _parent;
  @override
  GeneratedTextColumn get parent => _parent ??= _constructParent();
  GeneratedTextColumn _constructParent() {
    return GeneratedTextColumn(
      'id_padre',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, parent];
  @override
  $CategoriaTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'categoria';
  @override
  final String actualTableName = 'categoria';
  @override
  VerificationContext validateIntegrity(CategoriaTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (d.parent.present) {
      context.handle(
          _parentMeta, parent.isAcceptableValue(d.parent.value, _parentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriaTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return CategoriaTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(CategoriaTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<String, StringType>(d.id.value);
    }
    if (d.name.present) {
      map['nombre'] = Variable<String, StringType>(d.name.value);
    }
    if (d.parent.present) {
      map['id_padre'] = Variable<String, StringType>(d.parent.value);
    }
    return map;
  }

  @override
  $CategoriaTableTable createAlias(String alias) {
    return $CategoriaTableTable(_db, alias);
  }
}

class AudiovisualTableData extends DataClass
    implements Insertable<AudiovisualTableData> {
  final int id;
  final String titulo;
  final String sinopsis;
  final String categoria;
  final String categoria2;
  final String anno;
  final String pais;
  final String idioma;
  final String director;
  final String reparto;
  final String productora;
  final String temp;
  final String duracion;
  final String capitulos;
  final String notas;
  final String tamanno;
  final String formato;
  final String estado;
  final String fecha_reg;
  final String fecha_act;
  AudiovisualTableData(
      {@required this.id,
      @required this.titulo,
      @required this.sinopsis,
      @required this.categoria,
      @required this.categoria2,
      @required this.anno,
      @required this.pais,
      @required this.idioma,
      @required this.director,
      @required this.reparto,
      @required this.productora,
      @required this.temp,
      @required this.duracion,
      @required this.capitulos,
      @required this.notas,
      @required this.tamanno,
      @required this.formato,
      @required this.estado,
      @required this.fecha_reg,
      @required this.fecha_act});
  factory AudiovisualTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AudiovisualTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      titulo:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}titulo']),
      sinopsis: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}sinopsis']),
      categoria: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categoria']),
      categoria2: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}categoria2']),
      anno: stringType.mapFromDatabaseResponse(data['${effectivePrefix}anno']),
      pais: stringType.mapFromDatabaseResponse(data['${effectivePrefix}pais']),
      idioma:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}idioma']),
      director: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}director']),
      reparto:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}reparto']),
      productora: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}productora']),
      temp: stringType.mapFromDatabaseResponse(data['${effectivePrefix}temp']),
      duracion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}duracion']),
      capitulos: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}capitulos']),
      notas:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}notas']),
      tamanno:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tamanno']),
      formato:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}formato']),
      estado:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}estado']),
      fecha_reg: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}fecha_reg']),
      fecha_act: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}fecha_act']),
    );
  }
  factory AudiovisualTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return AudiovisualTableData(
      id: serializer.fromJson<int>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      sinopsis: serializer.fromJson<String>(json['sinopsis']),
      categoria: serializer.fromJson<String>(json['categoria']),
      categoria2: serializer.fromJson<String>(json['categoria2']),
      anno: serializer.fromJson<String>(json['anno']),
      pais: serializer.fromJson<String>(json['pais']),
      idioma: serializer.fromJson<String>(json['idioma']),
      director: serializer.fromJson<String>(json['director']),
      reparto: serializer.fromJson<String>(json['reparto']),
      productora: serializer.fromJson<String>(json['productora']),
      temp: serializer.fromJson<String>(json['temp']),
      duracion: serializer.fromJson<String>(json['duracion']),
      capitulos: serializer.fromJson<String>(json['capitulos']),
      notas: serializer.fromJson<String>(json['notas']),
      tamanno: serializer.fromJson<String>(json['tamanno']),
      formato: serializer.fromJson<String>(json['formato']),
      estado: serializer.fromJson<String>(json['estado']),
      fecha_reg: serializer.fromJson<String>(json['fecha_reg']),
      fecha_act: serializer.fromJson<String>(json['fecha_act']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titulo': serializer.toJson<String>(titulo),
      'sinopsis': serializer.toJson<String>(sinopsis),
      'categoria': serializer.toJson<String>(categoria),
      'categoria2': serializer.toJson<String>(categoria2),
      'anno': serializer.toJson<String>(anno),
      'pais': serializer.toJson<String>(pais),
      'idioma': serializer.toJson<String>(idioma),
      'director': serializer.toJson<String>(director),
      'reparto': serializer.toJson<String>(reparto),
      'productora': serializer.toJson<String>(productora),
      'temp': serializer.toJson<String>(temp),
      'duracion': serializer.toJson<String>(duracion),
      'capitulos': serializer.toJson<String>(capitulos),
      'notas': serializer.toJson<String>(notas),
      'tamanno': serializer.toJson<String>(tamanno),
      'formato': serializer.toJson<String>(formato),
      'estado': serializer.toJson<String>(estado),
      'fecha_reg': serializer.toJson<String>(fecha_reg),
      'fecha_act': serializer.toJson<String>(fecha_act),
    };
  }

  @override
  AudiovisualTableCompanion createCompanion(bool nullToAbsent) {
    return AudiovisualTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      titulo:
          titulo == null && nullToAbsent ? const Value.absent() : Value(titulo),
      sinopsis: sinopsis == null && nullToAbsent
          ? const Value.absent()
          : Value(sinopsis),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      categoria2: categoria2 == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria2),
      anno: anno == null && nullToAbsent ? const Value.absent() : Value(anno),
      pais: pais == null && nullToAbsent ? const Value.absent() : Value(pais),
      idioma:
          idioma == null && nullToAbsent ? const Value.absent() : Value(idioma),
      director: director == null && nullToAbsent
          ? const Value.absent()
          : Value(director),
      reparto: reparto == null && nullToAbsent
          ? const Value.absent()
          : Value(reparto),
      productora: productora == null && nullToAbsent
          ? const Value.absent()
          : Value(productora),
      temp: temp == null && nullToAbsent ? const Value.absent() : Value(temp),
      duracion: duracion == null && nullToAbsent
          ? const Value.absent()
          : Value(duracion),
      capitulos: capitulos == null && nullToAbsent
          ? const Value.absent()
          : Value(capitulos),
      notas:
          notas == null && nullToAbsent ? const Value.absent() : Value(notas),
      tamanno: tamanno == null && nullToAbsent
          ? const Value.absent()
          : Value(tamanno),
      formato: formato == null && nullToAbsent
          ? const Value.absent()
          : Value(formato),
      estado:
          estado == null && nullToAbsent ? const Value.absent() : Value(estado),
      fecha_reg: fecha_reg == null && nullToAbsent
          ? const Value.absent()
          : Value(fecha_reg),
      fecha_act: fecha_act == null && nullToAbsent
          ? const Value.absent()
          : Value(fecha_act),
    );
  }

  AudiovisualTableData copyWith(
          {int id,
          String titulo,
          String sinopsis,
          String categoria,
          String categoria2,
          String anno,
          String pais,
          String idioma,
          String director,
          String reparto,
          String productora,
          String temp,
          String duracion,
          String capitulos,
          String notas,
          String tamanno,
          String formato,
          String estado,
          String fecha_reg,
          String fecha_act}) =>
      AudiovisualTableData(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        sinopsis: sinopsis ?? this.sinopsis,
        categoria: categoria ?? this.categoria,
        categoria2: categoria2 ?? this.categoria2,
        anno: anno ?? this.anno,
        pais: pais ?? this.pais,
        idioma: idioma ?? this.idioma,
        director: director ?? this.director,
        reparto: reparto ?? this.reparto,
        productora: productora ?? this.productora,
        temp: temp ?? this.temp,
        duracion: duracion ?? this.duracion,
        capitulos: capitulos ?? this.capitulos,
        notas: notas ?? this.notas,
        tamanno: tamanno ?? this.tamanno,
        formato: formato ?? this.formato,
        estado: estado ?? this.estado,
        fecha_reg: fecha_reg ?? this.fecha_reg,
        fecha_act: fecha_act ?? this.fecha_act,
      );
  @override
  String toString() {
    return (StringBuffer('AudiovisualTableData(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('sinopsis: $sinopsis, ')
          ..write('categoria: $categoria, ')
          ..write('categoria2: $categoria2, ')
          ..write('anno: $anno, ')
          ..write('pais: $pais, ')
          ..write('idioma: $idioma, ')
          ..write('director: $director, ')
          ..write('reparto: $reparto, ')
          ..write('productora: $productora, ')
          ..write('temp: $temp, ')
          ..write('duracion: $duracion, ')
          ..write('capitulos: $capitulos, ')
          ..write('notas: $notas, ')
          ..write('tamanno: $tamanno, ')
          ..write('formato: $formato, ')
          ..write('estado: $estado, ')
          ..write('fecha_reg: $fecha_reg, ')
          ..write('fecha_act: $fecha_act')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          titulo.hashCode,
          $mrjc(
              sinopsis.hashCode,
              $mrjc(
                  categoria.hashCode,
                  $mrjc(
                      categoria2.hashCode,
                      $mrjc(
                          anno.hashCode,
                          $mrjc(
                              pais.hashCode,
                              $mrjc(
                                  idioma.hashCode,
                                  $mrjc(
                                      director.hashCode,
                                      $mrjc(
                                          reparto.hashCode,
                                          $mrjc(
                                              productora.hashCode,
                                              $mrjc(
                                                  temp.hashCode,
                                                  $mrjc(
                                                      duracion.hashCode,
                                                      $mrjc(
                                                          capitulos.hashCode,
                                                          $mrjc(
                                                              notas.hashCode,
                                                              $mrjc(
                                                                  tamanno
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      formato
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          estado
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              fecha_reg.hashCode,
                                                                              fecha_act.hashCode))))))))))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AudiovisualTableData &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.sinopsis == this.sinopsis &&
          other.categoria == this.categoria &&
          other.categoria2 == this.categoria2 &&
          other.anno == this.anno &&
          other.pais == this.pais &&
          other.idioma == this.idioma &&
          other.director == this.director &&
          other.reparto == this.reparto &&
          other.productora == this.productora &&
          other.temp == this.temp &&
          other.duracion == this.duracion &&
          other.capitulos == this.capitulos &&
          other.notas == this.notas &&
          other.tamanno == this.tamanno &&
          other.formato == this.formato &&
          other.estado == this.estado &&
          other.fecha_reg == this.fecha_reg &&
          other.fecha_act == this.fecha_act);
}

class AudiovisualTableCompanion extends UpdateCompanion<AudiovisualTableData> {
  final Value<int> id;
  final Value<String> titulo;
  final Value<String> sinopsis;
  final Value<String> categoria;
  final Value<String> categoria2;
  final Value<String> anno;
  final Value<String> pais;
  final Value<String> idioma;
  final Value<String> director;
  final Value<String> reparto;
  final Value<String> productora;
  final Value<String> temp;
  final Value<String> duracion;
  final Value<String> capitulos;
  final Value<String> notas;
  final Value<String> tamanno;
  final Value<String> formato;
  final Value<String> estado;
  final Value<String> fecha_reg;
  final Value<String> fecha_act;
  const AudiovisualTableCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.sinopsis = const Value.absent(),
    this.categoria = const Value.absent(),
    this.categoria2 = const Value.absent(),
    this.anno = const Value.absent(),
    this.pais = const Value.absent(),
    this.idioma = const Value.absent(),
    this.director = const Value.absent(),
    this.reparto = const Value.absent(),
    this.productora = const Value.absent(),
    this.temp = const Value.absent(),
    this.duracion = const Value.absent(),
    this.capitulos = const Value.absent(),
    this.notas = const Value.absent(),
    this.tamanno = const Value.absent(),
    this.formato = const Value.absent(),
    this.estado = const Value.absent(),
    this.fecha_reg = const Value.absent(),
    this.fecha_act = const Value.absent(),
  });
  AudiovisualTableCompanion.insert({
    @required int id,
    @required String titulo,
    @required String sinopsis,
    @required String categoria,
    @required String categoria2,
    @required String anno,
    @required String pais,
    @required String idioma,
    @required String director,
    @required String reparto,
    @required String productora,
    @required String temp,
    @required String duracion,
    @required String capitulos,
    @required String notas,
    @required String tamanno,
    @required String formato,
    @required String estado,
    @required String fecha_reg,
    @required String fecha_act,
  })  : id = Value(id),
        titulo = Value(titulo),
        sinopsis = Value(sinopsis),
        categoria = Value(categoria),
        categoria2 = Value(categoria2),
        anno = Value(anno),
        pais = Value(pais),
        idioma = Value(idioma),
        director = Value(director),
        reparto = Value(reparto),
        productora = Value(productora),
        temp = Value(temp),
        duracion = Value(duracion),
        capitulos = Value(capitulos),
        notas = Value(notas),
        tamanno = Value(tamanno),
        formato = Value(formato),
        estado = Value(estado),
        fecha_reg = Value(fecha_reg),
        fecha_act = Value(fecha_act);
  AudiovisualTableCompanion copyWith(
      {Value<int> id,
      Value<String> titulo,
      Value<String> sinopsis,
      Value<String> categoria,
      Value<String> categoria2,
      Value<String> anno,
      Value<String> pais,
      Value<String> idioma,
      Value<String> director,
      Value<String> reparto,
      Value<String> productora,
      Value<String> temp,
      Value<String> duracion,
      Value<String> capitulos,
      Value<String> notas,
      Value<String> tamanno,
      Value<String> formato,
      Value<String> estado,
      Value<String> fecha_reg,
      Value<String> fecha_act}) {
    return AudiovisualTableCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      sinopsis: sinopsis ?? this.sinopsis,
      categoria: categoria ?? this.categoria,
      categoria2: categoria2 ?? this.categoria2,
      anno: anno ?? this.anno,
      pais: pais ?? this.pais,
      idioma: idioma ?? this.idioma,
      director: director ?? this.director,
      reparto: reparto ?? this.reparto,
      productora: productora ?? this.productora,
      temp: temp ?? this.temp,
      duracion: duracion ?? this.duracion,
      capitulos: capitulos ?? this.capitulos,
      notas: notas ?? this.notas,
      tamanno: tamanno ?? this.tamanno,
      formato: formato ?? this.formato,
      estado: estado ?? this.estado,
      fecha_reg: fecha_reg ?? this.fecha_reg,
      fecha_act: fecha_act ?? this.fecha_act,
    );
  }
}

class $AudiovisualTableTable extends AudiovisualTable
    with TableInfo<$AudiovisualTableTable, AudiovisualTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AudiovisualTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  GeneratedTextColumn _titulo;
  @override
  GeneratedTextColumn get titulo => _titulo ??= _constructTitulo();
  GeneratedTextColumn _constructTitulo() {
    return GeneratedTextColumn(
      'titulo',
      $tableName,
      false,
    );
  }

  final VerificationMeta _sinopsisMeta = const VerificationMeta('sinopsis');
  GeneratedTextColumn _sinopsis;
  @override
  GeneratedTextColumn get sinopsis => _sinopsis ??= _constructSinopsis();
  GeneratedTextColumn _constructSinopsis() {
    return GeneratedTextColumn(
      'sinopsis',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoriaMeta = const VerificationMeta('categoria');
  GeneratedTextColumn _categoria;
  @override
  GeneratedTextColumn get categoria => _categoria ??= _constructCategoria();
  GeneratedTextColumn _constructCategoria() {
    return GeneratedTextColumn(
      'categoria',
      $tableName,
      false,
    );
  }

  final VerificationMeta _categoria2Meta = const VerificationMeta('categoria2');
  GeneratedTextColumn _categoria2;
  @override
  GeneratedTextColumn get categoria2 => _categoria2 ??= _constructCategoria2();
  GeneratedTextColumn _constructCategoria2() {
    return GeneratedTextColumn(
      'categoria2',
      $tableName,
      false,
    );
  }

  final VerificationMeta _annoMeta = const VerificationMeta('anno');
  GeneratedTextColumn _anno;
  @override
  GeneratedTextColumn get anno => _anno ??= _constructAnno();
  GeneratedTextColumn _constructAnno() {
    return GeneratedTextColumn(
      'anno',
      $tableName,
      false,
    );
  }

  final VerificationMeta _paisMeta = const VerificationMeta('pais');
  GeneratedTextColumn _pais;
  @override
  GeneratedTextColumn get pais => _pais ??= _constructPais();
  GeneratedTextColumn _constructPais() {
    return GeneratedTextColumn(
      'pais',
      $tableName,
      false,
    );
  }

  final VerificationMeta _idiomaMeta = const VerificationMeta('idioma');
  GeneratedTextColumn _idioma;
  @override
  GeneratedTextColumn get idioma => _idioma ??= _constructIdioma();
  GeneratedTextColumn _constructIdioma() {
    return GeneratedTextColumn(
      'idioma',
      $tableName,
      false,
    );
  }

  final VerificationMeta _directorMeta = const VerificationMeta('director');
  GeneratedTextColumn _director;
  @override
  GeneratedTextColumn get director => _director ??= _constructDirector();
  GeneratedTextColumn _constructDirector() {
    return GeneratedTextColumn(
      'director',
      $tableName,
      false,
    );
  }

  final VerificationMeta _repartoMeta = const VerificationMeta('reparto');
  GeneratedTextColumn _reparto;
  @override
  GeneratedTextColumn get reparto => _reparto ??= _constructReparto();
  GeneratedTextColumn _constructReparto() {
    return GeneratedTextColumn(
      'reparto',
      $tableName,
      false,
    );
  }

  final VerificationMeta _productoraMeta = const VerificationMeta('productora');
  GeneratedTextColumn _productora;
  @override
  GeneratedTextColumn get productora => _productora ??= _constructProductora();
  GeneratedTextColumn _constructProductora() {
    return GeneratedTextColumn(
      'productora',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tempMeta = const VerificationMeta('temp');
  GeneratedTextColumn _temp;
  @override
  GeneratedTextColumn get temp => _temp ??= _constructTemp();
  GeneratedTextColumn _constructTemp() {
    return GeneratedTextColumn(
      'temp',
      $tableName,
      false,
    );
  }

  final VerificationMeta _duracionMeta = const VerificationMeta('duracion');
  GeneratedTextColumn _duracion;
  @override
  GeneratedTextColumn get duracion => _duracion ??= _constructDuracion();
  GeneratedTextColumn _constructDuracion() {
    return GeneratedTextColumn(
      'duracion',
      $tableName,
      false,
    );
  }

  final VerificationMeta _capitulosMeta = const VerificationMeta('capitulos');
  GeneratedTextColumn _capitulos;
  @override
  GeneratedTextColumn get capitulos => _capitulos ??= _constructCapitulos();
  GeneratedTextColumn _constructCapitulos() {
    return GeneratedTextColumn(
      'capitulos',
      $tableName,
      false,
    );
  }

  final VerificationMeta _notasMeta = const VerificationMeta('notas');
  GeneratedTextColumn _notas;
  @override
  GeneratedTextColumn get notas => _notas ??= _constructNotas();
  GeneratedTextColumn _constructNotas() {
    return GeneratedTextColumn(
      'notas',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tamannoMeta = const VerificationMeta('tamanno');
  GeneratedTextColumn _tamanno;
  @override
  GeneratedTextColumn get tamanno => _tamanno ??= _constructTamanno();
  GeneratedTextColumn _constructTamanno() {
    return GeneratedTextColumn(
      'tamanno',
      $tableName,
      false,
    );
  }

  final VerificationMeta _formatoMeta = const VerificationMeta('formato');
  GeneratedTextColumn _formato;
  @override
  GeneratedTextColumn get formato => _formato ??= _constructFormato();
  GeneratedTextColumn _constructFormato() {
    return GeneratedTextColumn(
      'formato',
      $tableName,
      false,
    );
  }

  final VerificationMeta _estadoMeta = const VerificationMeta('estado');
  GeneratedTextColumn _estado;
  @override
  GeneratedTextColumn get estado => _estado ??= _constructEstado();
  GeneratedTextColumn _constructEstado() {
    return GeneratedTextColumn(
      'estado',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fecha_regMeta = const VerificationMeta('fecha_reg');
  GeneratedTextColumn _fecha_reg;
  @override
  GeneratedTextColumn get fecha_reg => _fecha_reg ??= _constructFechaReg();
  GeneratedTextColumn _constructFechaReg() {
    return GeneratedTextColumn(
      'fecha_reg',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fecha_actMeta = const VerificationMeta('fecha_act');
  GeneratedTextColumn _fecha_act;
  @override
  GeneratedTextColumn get fecha_act => _fecha_act ??= _constructFechaAct();
  GeneratedTextColumn _constructFechaAct() {
    return GeneratedTextColumn(
      'fecha_act',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        titulo,
        sinopsis,
        categoria,
        categoria2,
        anno,
        pais,
        idioma,
        director,
        reparto,
        productora,
        temp,
        duracion,
        capitulos,
        notas,
        tamanno,
        formato,
        estado,
        fecha_reg,
        fecha_act
      ];
  @override
  $AudiovisualTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'audiovisualdb';
  @override
  final String actualTableName = 'audiovisualdb';
  @override
  VerificationContext validateIntegrity(AudiovisualTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.titulo.present) {
      context.handle(
          _tituloMeta, titulo.isAcceptableValue(d.titulo.value, _tituloMeta));
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (d.sinopsis.present) {
      context.handle(_sinopsisMeta,
          sinopsis.isAcceptableValue(d.sinopsis.value, _sinopsisMeta));
    } else if (isInserting) {
      context.missing(_sinopsisMeta);
    }
    if (d.categoria.present) {
      context.handle(_categoriaMeta,
          categoria.isAcceptableValue(d.categoria.value, _categoriaMeta));
    } else if (isInserting) {
      context.missing(_categoriaMeta);
    }
    if (d.categoria2.present) {
      context.handle(_categoria2Meta,
          categoria2.isAcceptableValue(d.categoria2.value, _categoria2Meta));
    } else if (isInserting) {
      context.missing(_categoria2Meta);
    }
    if (d.anno.present) {
      context.handle(
          _annoMeta, anno.isAcceptableValue(d.anno.value, _annoMeta));
    } else if (isInserting) {
      context.missing(_annoMeta);
    }
    if (d.pais.present) {
      context.handle(
          _paisMeta, pais.isAcceptableValue(d.pais.value, _paisMeta));
    } else if (isInserting) {
      context.missing(_paisMeta);
    }
    if (d.idioma.present) {
      context.handle(
          _idiomaMeta, idioma.isAcceptableValue(d.idioma.value, _idiomaMeta));
    } else if (isInserting) {
      context.missing(_idiomaMeta);
    }
    if (d.director.present) {
      context.handle(_directorMeta,
          director.isAcceptableValue(d.director.value, _directorMeta));
    } else if (isInserting) {
      context.missing(_directorMeta);
    }
    if (d.reparto.present) {
      context.handle(_repartoMeta,
          reparto.isAcceptableValue(d.reparto.value, _repartoMeta));
    } else if (isInserting) {
      context.missing(_repartoMeta);
    }
    if (d.productora.present) {
      context.handle(_productoraMeta,
          productora.isAcceptableValue(d.productora.value, _productoraMeta));
    } else if (isInserting) {
      context.missing(_productoraMeta);
    }
    if (d.temp.present) {
      context.handle(
          _tempMeta, temp.isAcceptableValue(d.temp.value, _tempMeta));
    } else if (isInserting) {
      context.missing(_tempMeta);
    }
    if (d.duracion.present) {
      context.handle(_duracionMeta,
          duracion.isAcceptableValue(d.duracion.value, _duracionMeta));
    } else if (isInserting) {
      context.missing(_duracionMeta);
    }
    if (d.capitulos.present) {
      context.handle(_capitulosMeta,
          capitulos.isAcceptableValue(d.capitulos.value, _capitulosMeta));
    } else if (isInserting) {
      context.missing(_capitulosMeta);
    }
    if (d.notas.present) {
      context.handle(
          _notasMeta, notas.isAcceptableValue(d.notas.value, _notasMeta));
    } else if (isInserting) {
      context.missing(_notasMeta);
    }
    if (d.tamanno.present) {
      context.handle(_tamannoMeta,
          tamanno.isAcceptableValue(d.tamanno.value, _tamannoMeta));
    } else if (isInserting) {
      context.missing(_tamannoMeta);
    }
    if (d.formato.present) {
      context.handle(_formatoMeta,
          formato.isAcceptableValue(d.formato.value, _formatoMeta));
    } else if (isInserting) {
      context.missing(_formatoMeta);
    }
    if (d.estado.present) {
      context.handle(
          _estadoMeta, estado.isAcceptableValue(d.estado.value, _estadoMeta));
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (d.fecha_reg.present) {
      context.handle(_fecha_regMeta,
          fecha_reg.isAcceptableValue(d.fecha_reg.value, _fecha_regMeta));
    } else if (isInserting) {
      context.missing(_fecha_regMeta);
    }
    if (d.fecha_act.present) {
      context.handle(_fecha_actMeta,
          fecha_act.isAcceptableValue(d.fecha_act.value, _fecha_actMeta));
    } else if (isInserting) {
      context.missing(_fecha_actMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AudiovisualTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AudiovisualTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AudiovisualTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.titulo.present) {
      map['titulo'] = Variable<String, StringType>(d.titulo.value);
    }
    if (d.sinopsis.present) {
      map['sinopsis'] = Variable<String, StringType>(d.sinopsis.value);
    }
    if (d.categoria.present) {
      map['categoria'] = Variable<String, StringType>(d.categoria.value);
    }
    if (d.categoria2.present) {
      map['categoria2'] = Variable<String, StringType>(d.categoria2.value);
    }
    if (d.anno.present) {
      map['anno'] = Variable<String, StringType>(d.anno.value);
    }
    if (d.pais.present) {
      map['pais'] = Variable<String, StringType>(d.pais.value);
    }
    if (d.idioma.present) {
      map['idioma'] = Variable<String, StringType>(d.idioma.value);
    }
    if (d.director.present) {
      map['director'] = Variable<String, StringType>(d.director.value);
    }
    if (d.reparto.present) {
      map['reparto'] = Variable<String, StringType>(d.reparto.value);
    }
    if (d.productora.present) {
      map['productora'] = Variable<String, StringType>(d.productora.value);
    }
    if (d.temp.present) {
      map['temp'] = Variable<String, StringType>(d.temp.value);
    }
    if (d.duracion.present) {
      map['duracion'] = Variable<String, StringType>(d.duracion.value);
    }
    if (d.capitulos.present) {
      map['capitulos'] = Variable<String, StringType>(d.capitulos.value);
    }
    if (d.notas.present) {
      map['notas'] = Variable<String, StringType>(d.notas.value);
    }
    if (d.tamanno.present) {
      map['tamanno'] = Variable<String, StringType>(d.tamanno.value);
    }
    if (d.formato.present) {
      map['formato'] = Variable<String, StringType>(d.formato.value);
    }
    if (d.estado.present) {
      map['estado'] = Variable<String, StringType>(d.estado.value);
    }
    if (d.fecha_reg.present) {
      map['fecha_reg'] = Variable<String, StringType>(d.fecha_reg.value);
    }
    if (d.fecha_act.present) {
      map['fecha_act'] = Variable<String, StringType>(d.fecha_act.value);
    }
    return map;
  }

  @override
  $AudiovisualTableTable createAlias(String alias) {
    return $AudiovisualTableTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $CategoriaTableTable _categoriaTable;
  $CategoriaTableTable get categoriaTable =>
      _categoriaTable ??= $CategoriaTableTable(this);
  $AudiovisualTableTable _audiovisualTable;
  $AudiovisualTableTable get audiovisualTable =>
      _audiovisualTable ??= $AudiovisualTableTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoriaTable, audiovisualTable];
}
