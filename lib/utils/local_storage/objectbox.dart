// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:hashmicro/objectbox.g.dart';

import 'entity/outlet_entity.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;
  late final Store _store;
  late final Box<LocalOutlet> _localOutletBox;

  LocalStorage._internal();

  Future<void> init() async {
    final rootDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(rootDirectory.path, "local-storage");
    _store = openStore(directory: path);

    _localOutletBox = _store.box<LocalOutlet>();
  }

  // ============== local storage
  Future<void> insertLocalOutlet(LocalOutlet outlet) async {
    await _localOutletBox.putAsync(outlet);
  }

  Future<List<LocalOutlet>> getOutletByUserId({
    required int userId,
  }) async {
    final query =
        _localOutletBox.query(LocalOutlet_.userId.equals(userId)).build();

    try {
      return query.find();
    } finally {
      query.close();
    }
  }

  Future<void> outletClockIn({
    required int userId,
    required String nameOutlet,
    required String imageUrl,
    required double userLatitude,
    required double userLongitude,
  }) async {
    final query = _localOutletBox
        .query(LocalOutlet_.userId
            .equals(userId)
            .and(LocalOutlet_.nameOutlet.equals(
              nameOutlet.trim().toLowerCase(),
            )))
        .build();

    try {
      final outlet = query.findFirst();

      if (outlet == null) {
        throw Exception('Outlet tidak ditemukan');
      }

      outlet.clockIn = DateTime.now().toIso8601String();
      outlet.imageUrl = imageUrl;
      outlet.userLatitude = userLatitude.toString();
      outlet.userLongitude = userLongitude.toString();

      await _localOutletBox.putAsync(outlet);
    } catch (_) {
      query.close();
    }
  }

  Future<void> outletClockOut({
    required int userId,
    required String nameOutlet,
  }) async {
    final query = _localOutletBox
        .query(LocalOutlet_.userId
            .equals(userId)
            .and(LocalOutlet_.nameOutlet.equals(
              nameOutlet.trim().toLowerCase(),
            )))
        .build();

    try {
      final outlet = query.findFirst();

      if (outlet == null) {
        throw Exception('Outlet tidak ditemukan');
      }

      outlet.clockOut = DateTime.now().toIso8601String();

      await _localOutletBox.putAsync(outlet);
    } catch (_) {
      query.close();
    }
  }

  Future<bool> isOutletNameExists({
    required int userId,
    required String nameOutlet,
  }) async {
    final query = _localOutletBox
        .query(
          LocalOutlet_.userId.equals(userId).and(LocalOutlet_.nameOutlet.equals(
                nameOutlet.trim().toLowerCase(),
              )),
        )
        .build();

    try {
      return query.findFirst() != null;
    } finally {
      query.close();
    }
  }

  Future<void> deleteLocalOutletByName({
    required String nameOutlet,
  }) async {
    final query = _localOutletBox
        .query(
          LocalOutlet_.nameOutlet.equals(
            nameOutlet.trim().toLowerCase(),
          ),
        )
        .build();

    final datas = query.find();
    query.close();
    for (var data in datas) {
      _localOutletBox.remove(data.userId ?? 0);
    }
  }

  Future<void> clearDataLocal() async {
    _localOutletBox.removeAll();
  }

  Future<void> close() async {
    _store.close();
  }
}

LocalStorage get localStorage => LocalStorage();
