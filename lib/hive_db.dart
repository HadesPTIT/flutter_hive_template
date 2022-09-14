import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

///
/// Hive supports all primitive types, List, Map, DateTime, BigInt and Uint8List
///
/// Any object can be stored using TypeAdapters.
///
class HiveDb {
  HiveDb._();

  static final HiveDb _instance = HiveDb._();

  static HiveDb get instance => _instance;

  final String kBaseBox = 'kBaseBox';

  ///
  /// Can be used to prefix the given key.
  ///
  /// Used to difference user preferences.
  ///
  String? prefix;

  ///
  /// Initializes the Hive preferences
  ///
  Future<void> initialize() async {
    log('initializing Hive preferences...');
    await Hive.initFlutter();
    await Hive.openBox(kBaseBox);
  }

  ///
  /// Each one of the prefix symbols identifies one user
  ///
  /// If not use, it is general for all
  ///
  String _key(String key, bool usePrefix) {
    if (usePrefix && prefix?.isNotEmpty == true) {
      return '$prefix.$key';
    } else {
      return key;
    }
  }

  ///
  /// Gets the [int] for the [key] or an [defaultValue] if it doesn't exist.
  ///
  int? getInt(
    String key, {
    int? defaultValue,
    bool prefix = true,
  }) {
    try {
      final value =
          Hive.box(kBaseBox).get(_key(key, prefix), defaultValue: defaultValue);

      return value;
    } catch (e) {
      log('getInt ${_key(key, prefix)} error $e');
      return defaultValue;
    }
  }

  ///
  /// Gets the [double] for the [key] or an [defaultValue] if it doesn't exist.
  ///
  double? getDouble(
    String key, {
    double? defaultValue,
    bool prefix = true,
  }) {
    try {
      final value =
          Hive.box(kBaseBox).get(_key(key, prefix), defaultValue: defaultValue);

      return value;
    } catch (e) {
      log('getDouble ${_key(key, prefix)} error $e');
      return defaultValue;
    }
  }

  ///
  /// Gets the [string] for the [key] or an [defaultValue] if it doesn't exist.
  ///
  String? getString(
    String key, {
    String? defaultValue,
    bool prefix = true,
  }) {
    try {
      return Hive.box(kBaseBox)
          .get(_key(key, prefix), defaultValue: defaultValue);
    } catch (e) {
      log('getString ${_key(key, prefix)} error $e');
      return defaultValue;
    }
  }

  ///
  /// Gets the [bool] for the [key] or an [defaultValue] if it doesn't exist.
  ///
  bool? getBool(
    String key, {
    bool? defaultValue,
    bool prefix = true,
  }) {
    try {
      return Hive.box(kBaseBox)
          .get(_key(key, prefix), defaultValue: defaultValue);
    } catch (e) {
      log('getBool ${_key(key, prefix)} error $e');
      return defaultValue;
    }
  }

  ///
  /// Gets the string list for the [key] or an empty list if it doesn't exist.
  ///
  List<String?> getStringList(
    String key, {
    List<String?> defaultValue = const [],
    bool prefix = true,
  }) {
    try {
      return Hive.box(kBaseBox)
          .get(_key(key, prefix), defaultValue: defaultValue);
    } catch (e) {
      log('getStringList ${_key(key, prefix)} error $e');
      return [];
    }
  }

  ///
  /// Gets map for the [key] or an empty map if it doesn't exist.
  ///
  Map<String, dynamic> getMap(
    String key, {
    Map<String, dynamic> defaultValue = const {},
    bool prefix = true,
  }) {
    try {
      return Hive.box(kBaseBox)
          .get(_key(key, prefix), defaultValue: defaultValue);
    } catch (e) {
      log('getMap ${_key(key, prefix)} error $e');
      return {};
    }
  }

  ///
  /// Gets [DateTime] for the [key] or defaultValue if it doesn't exist.
  ///
  DateTime? getDateTime(
    String key, {
    DateTime? defaultValue,
    bool prefix = true,
  }) {
    try {
      return Hive.box(kBaseBox)
          .get(_key(key, prefix), defaultValue: defaultValue);
    } catch (e) {
      log('getDateTime ${_key(key, prefix)} error $e');
      return defaultValue;
    }
  }

  /// Set the [int] value
  Future<void> setInt(
    String key,
    int value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Set the [double] value
  Future<void> setDouble(
    String key,
    double value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Set the [bool] value
  Future<void> setBool(
    String key,
    bool value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Set the [string] value
  Future<void> setString(
    String key,
    String value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Set the [[string]] value
  Future<void> setStringList(
    String key,
    List<String?> value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Set the [map] value
  Future<void> setMap(
    String key,
    Map<String, dynamic> value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Set the [DateTime] value
  Future<void> setDateTime(
    String key,
    DateTime value, {
    bool prefix = true,
  }) {
    log('set ${_key(key, prefix)} to $value');
    return Hive.box(kBaseBox).put(_key(key, prefix), value);
  }

  /// Deletes the given [key] from the box.
  ///
  /// If it does not exist, nothing happens.
  Future<void> delete(
    String key, {
    bool prefix = true,
  }) {
    log('delete ${_key(key, prefix)}');
    return Hive.box(kBaseBox).delete(_key(key, prefix));
  }

  ///
  /// Removes all entries from the box.
  ///
  Future<int> clearAll() {
    log('clear all');
    return Hive.box(kBaseBox).clear();
  }

  ///
  /// Closes all open boxes.
  ///
  Future<void> close() async {
    log('close');
    await Hive.close();
  }
}
