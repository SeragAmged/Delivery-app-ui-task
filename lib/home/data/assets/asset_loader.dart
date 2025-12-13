import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

typedef FromJson<T> = T Function(Map<String, dynamic>);

@Singleton()
class AssetLoader {
  Future<List<T>> loadList<T>(
    String path,
    FromJson<T> fromJson,
  ) async {
    final jsonString = await rootBundle.loadString(path);
    final List<dynamic> rawList = json.decode(jsonString);

    return rawList
        .map((item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
