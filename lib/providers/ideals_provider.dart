import 'dart:convert';

import 'package:big_ideal_app/models/ideal.dart';
import 'package:big_ideal_app/sqlite_helper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';

part 'ideals_provider.g.dart';

@Riverpod()
class Ideals extends _$Ideals {
  @override
  FutureOr<List<Ideal>> build() async {
    Database? db = await SqliteHelper.instance.database;
    final allRows = await db!.query('ideal', orderBy: 'createdAt DESC');
    List<Ideal> ideas = [];
    for (var row in allRows) {
      ideas.add(Ideal.fromJson(row));
    }
    return ideas;
  }

  Future<void> insert(String body, int crime, String color) async {
    Database? db = await SqliteHelper.instance.database;
    DateTime createdAt = DateTime.now();
    String md5Value = md5.convert(utf8.encode(body)).toString();
    await db!.insert('ideal', {
      'body': body,
      'color': color,
      'md5': md5Value,
      'createdAt': createdAt.toIso8601String(),
      'crime': crime,
    });

    state = await AsyncValue.guard(
      () async {
        List<Ideal> items = state.value ?? [];
        items.insert(
          0,
          Ideal(
              id: 0,
              crime: crime,
              body: body,
              md5: md5Value,
              createdAt: createdAt,
              color: color),
        );
        return items;
      },
    );
  }
}
