import 'package:dio/dio.dart';
import 'package:vm_app/src/feature/event/model/event.dart';

abstract interface class IVmEventRepository {
  Future<List<VmEvent>> getEvents({int page = 0});

  Future<VmEvent> fetchByID(VmEventID id);

  Future<VmEvent> create(VmEvent event);

  Future<VmEvent> update(VmEvent event);

  Future<void> delete(VmEventID id);
}

final class VmEventRepository implements IVmEventRepository {
  final Dio _client;

  VmEventRepository({required Dio client}) : _client = client;

  @override
  Future<List<VmEvent>> getEvents({int page = 0}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<VmEvent> fetchByID(VmEventID id) {
    // TODO: implement fetchbyID
    throw UnimplementedError();
  }

  @override
  Future<VmEvent> create(VmEvent event) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<VmEvent> update(VmEvent event) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(VmEventID id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
