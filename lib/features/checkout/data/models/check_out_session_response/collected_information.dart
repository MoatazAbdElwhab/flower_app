class CollectedInformation {
  final dynamic shippingDetails;

  const CollectedInformation({this.shippingDetails});

  factory CollectedInformation.fromJson(Map<String, dynamic> json) {
    return CollectedInformation(
      shippingDetails: json['shipping_details'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        'shipping_details': shippingDetails,
      };
}
