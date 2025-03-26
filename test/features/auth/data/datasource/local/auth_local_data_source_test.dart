// test/features/auth/data/datasource/local/auth_local_data_source_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flower_app/features/auth/data/datasource/local_data_source/auth_local_data_source_impl.dart';
import '../../../../../helpers/mock_data/auth_mock_data.dart';

@GenerateMocks([LocalStorageClient])
import 'auth_local_data_source_test.mocks.dart';

void main() {
  late AuthLocalDataSourceImpl authLocalDataSource;
  late MockLocalStorageClient mockLocalStorageClient;

  setUp(() {
    mockLocalStorageClient = MockLocalStorageClient();
    authLocalDataSource = AuthLocalDataSourceImpl(mockLocalStorageClient);
  });

  group('AuthLocalDataSource Tests', () {
    group('Token Management', () {
      test('should save token', () async {
        when(mockLocalStorageClient.saveSecuredData('token', AuthMockData.mockToken))
            .thenAnswer((_) => Future<void>.value());

        await authLocalDataSource.cacheToken(AuthMockData.mockToken);

        verify(mockLocalStorageClient.saveSecuredData('token', AuthMockData.mockToken))
            .called(1);
      });

      test('should retrieve token', () async {
        when(mockLocalStorageClient.getSecuredData('token'))
            .thenAnswer((_) async => AuthMockData.mockToken);

        final result = await authLocalDataSource.getToken();

        expect(result, AuthMockData.mockToken);
        verify(mockLocalStorageClient.getSecuredData('token')).called(1);
      });

      test('should handle null token', () async {
        when(mockLocalStorageClient.getSecuredData('token'))
            .thenAnswer((_) async => null);

        final result = await authLocalDataSource.checkSavedToken();

        expect(result, null);
      });

      test('should delete token', () async {
        when(mockLocalStorageClient.deleteSecuredData('token'))
            .thenAnswer((_) => Future<void>.value());

        await authLocalDataSource.deleteToken();

        verify(mockLocalStorageClient.deleteSecuredData('token')).called(1);
      });
    });

    group('Remember Me', () {
      test('should save remember me state', () async {
        when(mockLocalStorageClient.saveData('rememberMe', 'true'))
            .thenAnswer((_) async => true);

        await authLocalDataSource.cacheRememberMe(true);

        verify(mockLocalStorageClient.saveData('rememberMe', 'true')).called(1);
      });

      test('should get remember me state - true', () {
        when(mockLocalStorageClient.getData('rememberMe'))
            .thenReturn('true');

        final result = authLocalDataSource.getRememberMe();

        expect(result, true);
        verify(mockLocalStorageClient.getData('rememberMe')).called(1);
      });

      test('should get remember me state - false', () {
        when(mockLocalStorageClient.getData('rememberMe'))
            .thenReturn('false');

        final result = authLocalDataSource.getRememberMe();

        expect(result, false);
        verify(mockLocalStorageClient.getData('rememberMe')).called(1);
      });

      test('should get remember me state - null (defaults to false)', () {
        when(mockLocalStorageClient.getData('rememberMe'))
            .thenReturn(null);

        final result = authLocalDataSource.getRememberMe();

        expect(result, false);
        verify(mockLocalStorageClient.getData('rememberMe')).called(1);
      });

      test('should delete remember me state', () async {
        when(mockLocalStorageClient.deleteData('rememberMe'))
            .thenAnswer((_) => Future<void>.value());

        await authLocalDataSource.deleteRememberMe();

        verify(mockLocalStorageClient.deleteData('rememberMe')).called(1);
      });
    });
  });
}
