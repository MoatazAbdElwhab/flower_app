// test/helpers/mocks/auth_mocks.g.dart

import 'package:mockito/annotations.dart';
import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/features/auth/domain/use_case/sign_in_use_case.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_contract.dart';

// This will generate the mocks for the classes that are annotated with @GenerateMocks

@GenerateMocks([
  SignInUseCase,
  LocalStorageClient,
  AuthLocalDataSourceContract,
])
void main() {}
