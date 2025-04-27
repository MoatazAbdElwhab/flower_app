// features/checkout/data/datasources/remote/checkout_api_remote_data_source.dart

import 'package:flower_app/core/app_data/api/graphql/graphql_client.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/core/logger/app_logger.dart';
import 'package:flower_app/features/checkout/data/datasources/remote/checkout_remote_data_source.dart';
import 'package:flower_app/features/checkout/data/models/addresses_response/address_model.dart';
import 'package:flower_app/features/checkout/data/models/check_out_requset.dart';
import 'package:flower_app/features/checkout/data/models/payment_success_response.dart';
import 'package:flower_app/features/checkout/payment_type/payment_types.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: CheckoutRemoteDataSource)
class CheckoutApiRemoteDataSource implements CheckoutRemoteDataSource {
  final GraphQLClient _graphQLClient;
  final Logger _logger;

  CheckoutApiRemoteDataSource(this._graphQLClient, this._logger);

  /// Factory constructor for dependency injection
  @factoryMethod
  static CheckoutRemoteDataSource create(GraphQLClient client) {
    return CheckoutApiRemoteDataSource(client, Logger());
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql('''
          query GetUserAddresses {
            addresses {
              street
              phone
              city
              lat
              long
              username
              _id
            }
          }
        '''),
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final result = await _graphQLClient.query(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to get addresses: ${result.exception.toString()}');
      }

      final data = result.data?['addresses'];
      if (data == null) {
        return [];
      }

      return List<AddressModel>.from(
        data.map((address) => AddressModel.fromJson(address)));
    } catch (e) {
      _logger.e('Error getting addresses: $e');
      throw Exception('Failed to get addresses: $e');
    }
  }

  @override
  Future<PaymentSuccessResponse> createCheckoutSession(
      CheckOutRequest checkOutRequest) async {
    switch (checkOutRequest.paymentMethod) {
      case PaymentMethodsType.card:
        return _createCardCheckoutSession(checkOutRequest);
      case PaymentMethodsType.cash:
        return _createCashOrder(checkOutRequest);
      default:
        throw ApiException(message: 'Unknown payment method');
    }
  }

  Future<CashPaymentSuccess> _createCashOrder(
      CheckOutRequest checkOutRequest) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation CreateCashOrder(\$shippingAddress: ShippingAddressInput!) {
            createCashOrder(shippingAddress: \$shippingAddress) {
              status
              message
              order {
                _id
                totalOrderPrice
                paymentMethodType
                shippingAddress {
                  street
                  city
                  phone
                }
                user
                createdAt
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'shippingAddress': {
            'street': checkOutRequest.street,
            'phone': checkOutRequest.phone,
            'city': checkOutRequest.city,
            'lat': checkOutRequest.lat,
            'long': checkOutRequest.long,
          },
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to create cash order: ${result.exception.toString()}');
      }

      return CashPaymentSuccess();
    } catch (e) {
      _logger.e('Error creating cash order: $e');
      throw Exception('Failed to create cash order: $e');
    }
  }

  Future<OnlinePaymentSuccess> _createCardCheckoutSession(
      CheckOutRequest checkOutRequest) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql('''
          mutation CreateCheckoutSession(\$shippingAddress: ShippingAddressInput!) {
            createCheckoutSession(shippingAddress: \$shippingAddress) {
              status
              session {
                url
                success_url
                cancel_url
              }
            }
          }
        '''),
        variables: <String, dynamic>{
          'shippingAddress': {
            'street': checkOutRequest.street,
            'phone': checkOutRequest.phone,
            'city': checkOutRequest.city,
            'lat': checkOutRequest.lat,
            'long': checkOutRequest.long,
          },
        },
      );

      final result = await _graphQLClient.mutate(options);

      if (result.hasException) {
        _logger.e('GraphQL error: ${result.exception.toString()}');
        throw Exception('Failed to create checkout session: ${result.exception.toString()}');
      }

      final sessionData = result.data?['createCheckoutSession']?['session'];
      
      return OnlinePaymentSuccess(
        sessionUrl: sessionData['url'],
        successUrl: sessionData['success_url'],
        cancelUrl: sessionData['cancel_url'],
      );
    } catch (e) {
      _logger.e('Error creating checkout session: $e');
      throw Exception('Failed to create checkout session: $e');
    }
  }
}
