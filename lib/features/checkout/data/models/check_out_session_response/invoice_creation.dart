import 'package:flower_app/features/checkout/data/models/check_out_session_response/invoice_data.dart';

class InvoiceCreation {
  final bool? enabled;
  final InvoiceData? invoiceData;

  const InvoiceCreation({this.enabled, this.invoiceData});

  factory InvoiceCreation.fromJson(Map<String, dynamic> json) {
    return InvoiceCreation(
      enabled: json['enabled'] as bool?,
      invoiceData: json['invoice_data'] == null
          ? null
          : InvoiceData.fromJson(json['invoice_data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'invoice_data': invoiceData?.toJson(),
      };
}
