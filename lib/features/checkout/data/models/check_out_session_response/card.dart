class Card {
  final String? requestThreeDSecure;

  const Card({this.requestThreeDSecure});

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        requestThreeDSecure: json['request_three_d_secure'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'request_three_d_secure': requestThreeDSecure,
      };
}
