// features/add_edit_address/data/data_sources/add_address_remote_data_source_impl.dart
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../models/add_adress_model/add_adress_request.dart';
import 'add_address_remote_data_source.dart';

@Injectable(as: AddAddressRemoteDataSource)
class AddAddressRemoteDataSourceImpl implements AddAddressRemoteDataSource {
  final GraphQLClient _graphQLClient;
  final Logger _logger;

  AddAddressRemoteDataSourceImpl(this._graphQLClient, this._logger);

  @factoryMethod
  static AddAddressRemoteDataSource create(GraphQLClient client) {
    return AddAddressRemoteDataSourceImpl(client, Logger());
  }

  @override
  Future<void> addAddress(AddAndEditAddressRequest addAdressRequest) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation AddAddress(\$street: String!, \$city: String!, \$phone: String!, \$lat: String, \$long: String) {
            addAddress(
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
          'street': addAdressRequest.street,
          'city': addAdressRequest.city,
          'phone': addAdressRequest.phone,
          'lat': addAdressRequest.latValue,
          'long': addAdressRequest.longValue,
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to add address: ${result.exception.toString()}');
      }
    } catch (e) {
      _logger.e('Error adding address: $e');
      throw Exception('Failed to add address: $e');
    }
  }
}