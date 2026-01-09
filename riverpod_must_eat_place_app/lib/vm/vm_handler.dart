import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_must_eat_place_app/model/address.dart';
import 'package:riverpod_must_eat_place_app/vm/database_handler.dart';

class VMNotifier extends AsyncNotifier<List<Address>> {
  final DatabaseHandler _dbHandler = DatabaseHandler();

  @override
  Future<List<Address>> build() async => _dbHandler.queryAddress();

  Future loadAddress() async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async => _dbHandler.queryAddress());
  }

  Future insertAddress(Address address) async {
    await _dbHandler.insertAddress(address);
    await loadAddress(); // 함수에 not~~이 있으니까 안써줘도 됨.
  }

  Future updateAddress(Address address) async {
    await _dbHandler.updateAddress(address);
    await loadAddress(); // 함수에 not~~이 있으니까 안써줘도 됨.
  }

  Future deleteAddress(int id) async {
    await _dbHandler.deleteAddress(id);
    await loadAddress(); // 함수에 not~~이 있으니까 안써줘도 됨.
  }
} // VMNotifier

final vmNotifierProvider = AsyncNotifierProvider<VMNotifier, List<Address>>(
  VMNotifier.new,
);
