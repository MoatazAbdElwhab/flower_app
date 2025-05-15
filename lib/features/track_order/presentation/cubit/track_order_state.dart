part of 'track_order_cubit.dart';

abstract class TrackOrderState extends Equatable {
  const TrackOrderState();

  @override
  List<Object?> get props => [];
}

class TrackOrderInitial extends TrackOrderState {}

class TrackOrderLoading extends TrackOrderState {}

class TrackOrderSuccess extends TrackOrderState {
  final String orderId;
  final String status;
  final int step;
  final Map<String, dynamic>? driverInfo;

  const TrackOrderSuccess({
    required this.orderId,
    required this.status,
    required this.step,
    this.driverInfo,
  });

  @override
  List<Object?> get props => [orderId, status, step, driverInfo];

  // bool get hasDriver =>
  //   driverInfo != null &&
  //   driverInfo!['name'] != null &&
  //   driverInfo!['name'] != 'Null' &&
  //   driverInfo!['phone'] != null &&
  //   driverInfo!['phone'] != 'Null';

  String get statusText {
    switch (status.toLowerCase()) {
      case 'rejected':
        return 'your order has been rejected';
      case 'pending':
        return 'processing your order';
      case 'accepted':
        return 'congrats your order has been accepted';
      case 'picked_up':
        return 'your order has been picked up';
      case 'out_for_delivery':
        return 'your order is out for delivery';
      case 'delivered':
        return 'your order has been delivered';
      case 'arrived':
        return 'your order has been arrived';
      default:
        return status;
    }
  }

  bool get hasDriver {
    if (driverInfo == null) return false;

    final driverId = driverInfo!['id'];
    final name = driverInfo!['name'];
    final phone = driverInfo!['phone'];

    return driverId != null &&
        driverId != 'Null' &&
        name != null &&
        name != 'Null' &&
        phone != null &&
        phone != 'Null';
  }
}

class TrackOrderError extends TrackOrderState {
  final String message;

  const TrackOrderError(this.message);

  @override
  List<Object> get props => [message];
}
