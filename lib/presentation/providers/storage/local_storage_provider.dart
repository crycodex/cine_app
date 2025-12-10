import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cine_app/infraestructure/datasource/drift_datasource.dart';
import 'package:cine_app/infraestructure/repositories/local_storage_repository.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImp(datasource: DriftDatasource());
});
