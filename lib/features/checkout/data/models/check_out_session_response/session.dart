import 'package:flower_app/features/categories/data/remote/models/category_products_model.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/adaptive_pricing.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/automatic_tax.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/collected_information.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/custom_text.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/customer_details.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/invoice_creation.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/payment_method_configuration_details.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/payment_method_options.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/phone_number_collection.dart';
import 'package:flower_app/features/checkout/data/models/check_out_session_response/total_details.dart';

class Session {
  final String? id;
  final String? object;
  final AdaptivePricing? adaptivePricing;
  final dynamic afterExpiration;
  final dynamic allowPromotionCodes;
  final int? amountSubtotal;
  final int? amountTotal;
  final AutomaticTax? automaticTax;
  final dynamic billingAddressCollection;
  final String? cancelUrl;
  final String? clientReferenceId;
  final dynamic clientSecret;
  final CollectedInformation? collectedInformation;
  final dynamic consent;
  final dynamic consentCollection;
  final int? created;
  final String? currency;
  final dynamic currencyConversion;
  // final List<dynamic>? customFields;
  final CustomText? customText;
  final dynamic customer;
  final String? customerCreation;
  final CustomerDetails? customerDetails;
  final String? customerEmail;
  // final List<dynamic>? discounts;
  final int? expiresAt;
  final dynamic invoice;
  final InvoiceCreation? invoiceCreation;
  final bool? livemode;
  final dynamic locale;
  final Metadata? metadata;
  final String? mode;
  final dynamic paymentIntent;
  final dynamic paymentLink;
  final String? paymentMethodCollection;
  final PaymentMethodConfigurationDetails? paymentMethodConfigurationDetails;
  final PaymentMethodOptions? paymentMethodOptions;
  // final List<String>? paymentMethodTypes;
  final String? paymentStatus;
  final dynamic permissions;
  final PhoneNumberCollection? phoneNumberCollection;
  final dynamic recoveredFrom;
  final dynamic savedPaymentMethodOptions;
  final dynamic setupIntent;
  final dynamic shippingAddressCollection;
  final dynamic shippingCost;
  final dynamic shippingDetails;
  // final List<dynamic>? shippingOptions;
  final String? status;
  final dynamic submitType;
  final dynamic subscription;
  final String? successUrl;
  final TotalDetails? totalDetails;
  final String? uiMode;
  final String? url;
  final dynamic walletOptions;

  const Session({
    this.id,
    this.object,
    this.adaptivePricing,
    this.afterExpiration,
    this.allowPromotionCodes,
    this.amountSubtotal,
    this.amountTotal,
    this.automaticTax,
    this.billingAddressCollection,
    this.cancelUrl,
    this.clientReferenceId,
    this.clientSecret,
    this.collectedInformation,
    this.consent,
    this.consentCollection,
    this.created,
    this.currency,
    this.currencyConversion,
    // this.customFields,
    this.customText,
    this.customer,
    this.customerCreation,
    this.customerDetails,
    this.customerEmail,
    // this.discounts,
    this.expiresAt,
    this.invoice,
    this.invoiceCreation,
    this.livemode,
    this.locale,
    this.metadata,
    this.mode,
    this.paymentIntent,
    this.paymentLink,
    this.paymentMethodCollection,
    this.paymentMethodConfigurationDetails,
    this.paymentMethodOptions,
    // this.paymentMethodTypes,
    this.paymentStatus,
    this.permissions,
    this.phoneNumberCollection,
    this.recoveredFrom,
    this.savedPaymentMethodOptions,
    this.setupIntent,
    this.shippingAddressCollection,
    this.shippingCost,
    this.shippingDetails,
    // this.shippingOptions,
    this.status,
    this.submitType,
    this.subscription,
    this.successUrl,
    this.totalDetails,
    this.uiMode,
    this.url,
    this.walletOptions,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json['id'] as String?,
        object: json['object'] as String?,
        adaptivePricing: json['adaptive_pricing'] == null
            ? null
            : AdaptivePricing.fromJson(
                json['adaptive_pricing'] as Map<String, dynamic>),
        afterExpiration: json['after_expiration'] as dynamic,
        allowPromotionCodes: json['allow_promotion_codes'] as dynamic,
        amountSubtotal: json['amount_subtotal'] as int?,
        amountTotal: json['amount_total'] as int?,
        automaticTax: json['automatic_tax'] == null
            ? null
            : AutomaticTax.fromJson(
                json['automatic_tax'] as Map<String, dynamic>),
        billingAddressCollection: json['billing_address_collection'] as dynamic,
        cancelUrl: json['cancel_url'] as String?,
        clientReferenceId: json['client_reference_id'] as String?,
        clientSecret: json['client_secret'] as dynamic,
        collectedInformation: json['collected_information'] == null
            ? null
            : CollectedInformation.fromJson(
                json['collected_information'] as Map<String, dynamic>),
        consent: json['consent'] as dynamic,
        consentCollection: json['consent_collection'] as dynamic,
        created: json['created'] as int?,
        currency: json['currency'] as String?,
        currencyConversion: json['currency_conversion'] as dynamic,
        // customFields: json['custom_fields'] as List<dynamic>?,
        customText: json['custom_text'] == null
            ? null
            : CustomText.fromJson(json['custom_text'] as Map<String, dynamic>),
        customer: json['customer'] as dynamic,
        customerCreation: json['customer_creation'] as String?,
        customerDetails: json['customer_details'] == null
            ? null
            : CustomerDetails.fromJson(
                json['customer_details'] as Map<String, dynamic>),
        customerEmail: json['customer_email'] as String?,
        // discounts: json['discounts'] as List<dynamic>?,
        expiresAt: json['expires_at'] as int?,
        invoice: json['invoice'] as dynamic,
        invoiceCreation: json['invoice_creation'] == null
            ? null
            : InvoiceCreation.fromJson(
                json['invoice_creation'] as Map<String, dynamic>),
        livemode: json['livemode'] as bool?,
        locale: json['locale'] as dynamic,
        metadata: json['metadata'] == null
            ? null
            : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
        mode: json['mode'] as String?,
        paymentIntent: json['payment_intent'] as dynamic,
        paymentLink: json['payment_link'] as dynamic,
        paymentMethodCollection: json['payment_method_collection'] as String?,
        paymentMethodConfigurationDetails:
            json['payment_method_configuration_details'] == null
                ? null
                : PaymentMethodConfigurationDetails.fromJson(
                    json['payment_method_configuration_details']
                        as Map<String, dynamic>),
        paymentMethodOptions: json['payment_method_options'] == null
            ? null
            : PaymentMethodOptions.fromJson(
                json['payment_method_options'] as Map<String, dynamic>),
        // paymentMethodTypes: json['payment_method_types'] as List<String>?,
        paymentStatus: json['payment_status'] as String?,
        permissions: json['permissions'] as dynamic,
        phoneNumberCollection: json['phone_number_collection'] == null
            ? null
            : PhoneNumberCollection.fromJson(
                json['phone_number_collection'] as Map<String, dynamic>),
        recoveredFrom: json['recovered_from'] as dynamic,
        savedPaymentMethodOptions:
            json['saved_payment_method_options'] as dynamic,
        setupIntent: json['setup_intent'] as dynamic,
        shippingAddressCollection:
            json['shipping_address_collection'] as dynamic,
        shippingCost: json['shipping_cost'] as dynamic,
        shippingDetails: json['shipping_details'] as dynamic,
        // shippingOptions: json['shipping_options'] as List<dynamic>?,
        status: json['status'] as String?,
        submitType: json['submit_type'] as dynamic,
        subscription: json['subscription'] as dynamic,
        successUrl: json['success_url'] as String?,
        totalDetails: json['total_details'] == null
            ? null
            : TotalDetails.fromJson(
                json['total_details'] as Map<String, dynamic>),
        uiMode: json['ui_mode'] as String?,
        url: json['url'] as String?,
        walletOptions: json['wallet_options'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'object': object,
        'adaptive_pricing': adaptivePricing?.toJson(),
        'after_expiration': afterExpiration,
        'allow_promotion_codes': allowPromotionCodes,
        'amount_subtotal': amountSubtotal,
        'amount_total': amountTotal,
        'automatic_tax': automaticTax?.toJson(),
        'billing_address_collection': billingAddressCollection,
        'cancel_url': cancelUrl,
        'client_reference_id': clientReferenceId,
        'client_secret': clientSecret,
        'collected_information': collectedInformation?.toJson(),
        'consent': consent,
        'consent_collection': consentCollection,
        'created': created,
        'currency': currency,
        'currency_conversion': currencyConversion,
        // 'custom_fields': customFields,
        'custom_text': customText?.toJson(),
        'customer': customer,
        'customer_creation': customerCreation,
        'customer_details': customerDetails?.toJson(),
        'customer_email': customerEmail,
        // 'discounts': discounts,
        'expires_at': expiresAt,
        'invoice': invoice,
        'invoice_creation': invoiceCreation?.toJson(),
        'livemode': livemode,
        'locale': locale,
        'metadata': metadata?.toJson(),
        'mode': mode,
        'payment_intent': paymentIntent,
        'payment_link': paymentLink,
        'payment_method_collection': paymentMethodCollection,
        'payment_method_configuration_details':
            paymentMethodConfigurationDetails?.toJson(),
        'payment_method_options': paymentMethodOptions?.toJson(),
        // 'payment_method_types': paymentMethodTypes,
        'payment_status': paymentStatus,
        'permissions': permissions,
        'phone_number_collection': phoneNumberCollection?.toJson(),
        'recovered_from': recoveredFrom,
        'saved_payment_method_options': savedPaymentMethodOptions,
        'setup_intent': setupIntent,
        'shipping_address_collection': shippingAddressCollection,
        'shipping_cost': shippingCost,
        'shipping_details': shippingDetails,
        // 'shipping_options': shippingOptions,
        'status': status,
        'submit_type': submitType,
        'subscription': subscription,
        'success_url': successUrl,
        'total_details': totalDetails?.toJson(),
        'ui_mode': uiMode,
        'url': url,
        'wallet_options': walletOptions,
      };
}
