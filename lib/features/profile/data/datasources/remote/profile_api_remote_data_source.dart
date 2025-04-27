// features/profile/data/datasources/remote/profile_api_remote_data_source.dart
import 'package:flower_app/features/checkout/domain/entities/address.dart';
import 'package:flower_app/features/profile/data/datasources/remote/profile_remote_data_source.dart';
import 'package:flower_app/features/profile/data/models/profile_data_response/user_data_model.dart';
import 'package:flower_app/features/profile/data/models/reset_password/request/profile_reset_password_request.dart';
import 'package:flower_app/features/profile/data/models/reset_password/response/profile_reset_password_response.dart';
import 'package:flower_app/features/profile/data/models/update_profile_data/update_profile_request.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileApiRemoteDataSource implements ProfileRemoteDataSource {
  final GraphQLClient _graphQLClient;
  final Logger _logger;

  ProfileApiRemoteDataSource(this._graphQLClient, this._logger);

  @factoryMethod
  static ProfileRemoteDataSource create(GraphQLClient client) {
    return ProfileApiRemoteDataSource(client, Logger());
  }

  @override
  Future<UserDataModel> getUserData() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query GetUserProfile {
            getUserProfile {
              user {
                _id
                name
                email
                phone
                gender
                profileImg
                role
                createdAt
                updatedAt
                wishlist
                addresses {
                  _id
                  street
                  city
                  phone
                  lat
                  long
                }
              }
            }
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception(
            'Failed to get user profile: ${result.exception.toString()}');
      }

      final userData = result.data?['getUserProfile']?['user'];
      if (userData == null) {
        throw Exception('No user data returned from server');
      }

      return UserDataModel.fromJson(userData);
    } catch (e) {
      _logger.e('Error getting user profile: $e');
      throw Exception('Failed to get user profile: $e');
    }
  }

  @override
  Future<void> editProfileData(
      UpdateProfileRequest updateProfileRequest) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation UpdateUserProfile(\$name: String, \$email: String, \$phone: String) {
            updateUserProfile(userInput: {
              name: \$name,
              email: \$email,
              phone: \$phone
            }) {
              message
              user {
                _id
                name
                email
                phone
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'name': updateProfileRequest.firstName,
          'email': updateProfileRequest.email,
          'phone': updateProfileRequest.phone,
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception(
            'Failed to update profile: ${result.exception.toString()}');
      }
    } catch (e) {
      _logger.e('Error updating profile: $e');
      throw Exception('Failed to update profile: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation Logout {
            logout {
              message
            }
          }
        '''),
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to logout: ${result.exception.toString()}');
      }
    } catch (e) {
      _logger.e('Error logging out: $e');
      throw Exception('Failed to logout: $e');
    }
  }

  @override
  Future<ProfileResetPasswordResponse> profileResetPassword(
      ProfileResetPasswordRequest request) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation UpdatePassword(\$currentPassword: String!, \$password: String!, \$passwordConfirm: String!) {
            updatePassword(passwordInput: {
              currentPassword: \$currentPassword,
              password: \$password,
              passwordConfirm: \$passwordConfirm
            }) {
              message
              token
              user {
                _id
                name
                email
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'currentPassword': request.password,
          'password': request.newPassword,
          'passwordConfirm': request.newPassword,
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception(
            'Failed to reset password: ${result.exception.toString()}');
      }

      final data = result.data?['updatePassword'];
      return ProfileResetPasswordResponse.fromJson(data);
    } catch (e) {
      _logger.e('Error resetting password: $e');
      throw Exception('Failed to reset password: $e');
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation DeleteAddress(\$addressId: ID!) {
            deleteAddress(addressId: \$addressId) {
              message
              addresses {
                _id
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'addressId': id,
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception(
            'Failed to delete address: ${result.exception.toString()}');
      }
    } catch (e) {
      _logger.e('Error deleting address: $e');
      throw Exception('Failed to delete address: $e');
    }
  }

  @override
  Future<List<Address>> createAddress(Address address) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation CreateAddress(\$street: String!, \$city: String!, \$phone: String!, \$lat: String, \$long: String) {
            createAddress(
              addressInput: {
                street: \$street,
                city: \$city,
                phone: \$phone,
                lat: \$lat,
                long: \$long
              }
            ) {
              message
              addresses {
                _id
                street
                city
                phone
                lat
                long
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'street': address.street,
          'city': address.city,
          'phone': address.phone,
          'lat': address.lat,
          'long': address.long,
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception(
            'Failed to create address: ${result.exception.toString()}');
      }

      final addresses = result.data?['createAddress']?['addresses'];
      if (addresses == null) {
        return [];
      }

      return List<Address>.from(addresses.map((addr) => Address(
            id: addr['_id'],
            street: addr['street'],
            city: addr['city'],
            phone: addr['phone'],
            lat: addr['lat'] ?? '',
            long: addr['long'] ?? '',
            username: '',
          )));
    } catch (e) {
      _logger.e('Error creating address: $e');
      throw Exception('Failed to create address: $e');
    }
  }

  @override
  Future<List<Address>> updateAddress(Address address) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation UpdateAddress(\$addressId: ID!, \$street: String!, \$city: String!, \$phone: String!, \$lat: String, \$long: String) {
            updateAddress(
              addressId: \$addressId,
              addressInput: {
                street: \$street,
                city: \$city,
                phone: \$phone,
                lat: \$lat,
                long: \$long
              }
            ) {
              message
              addresses {
                _id
                street
                city
                phone
                lat
                long
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'addressId': address.id,
          'street': address.street,
          'city': address.city,
          'phone': address.phone,
          'lat': address.lat,
          'long': address.long,
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception(
            'Failed to update address: ${result.exception.toString()}');
      }

      final addresses = result.data?['updateAddress']?['addresses'];
      if (addresses == null) {
        return [];
      }

      return List<Address>.from(addresses.map((addr) => Address(
            id: addr['_id'],
            street: addr['street'],
            city: addr['city'],
            phone: addr['phone'],
            lat: addr['lat'] ?? '',
            long: addr['long'] ?? '',
            username: '',
          )));
    } catch (e) {
      _logger.e('Error updating address: $e');
      throw Exception('Failed to update address: $e');
    }
  }
}
