import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'track_order_state.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit() : super(TrackOrderInitial());
  
  StreamSubscription? _orderSubscription;
  
  void trackOrder(String orderId) {
    emit(TrackOrderLoading());
    
    try {
      final orderRef = FirebaseDatabase.instance.ref('orders/$orderId');
      
      _orderSubscription = orderRef.onValue.listen((event) {
        if (!event.snapshot.exists) {
          emit(const TrackOrderError('No Order Found'));
          return;
        }
        
        try {
          final dynamic orderData = event.snapshot.value;
          
          if (orderData is Map) {
            final status = orderData['state']?.toString() ?? 'pending';
            final step = _getStepFromStatus(status);
            
            Map<String, dynamic>? driverInfo;
            if (orderData['driver'] != null) {
              if (orderData['driver'] is Map) {
                driverInfo = Map<String, dynamic>.from(orderData['driver'] as Map);
              }
            }
            
            emit(TrackOrderSuccess(
              orderId: orderId,
              status: status,
              step: step,
              driverInfo: driverInfo,
            ));
          } else {
            emit(const TrackOrderError('Structure of order data is not valid'));
          }
        } catch (parseError) {
          emit(TrackOrderError('error : $parseError'));
        }
      }, onError: (error) {
        emit(TrackOrderError('error :$error'));
      });
    } catch (e) {
      emit(TrackOrderError('something went wrong : $e'));
    }
  }
  
  int _getStepFromStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return 0;
      case 'accepted':
        return 1;
      case 'picked_up':
        return 1;
      case 'shipped':
        return 2;
      case 'out_for_delivery':
        return 2;
      case 'delivered'|| 'arrived'|| 'delivered':
        return 3;
      default:
        return 0;
    }
  }

  //   case 'rejected':
  //         return 'your order has been rejected';
  //       case 'pending':
  //         return 'your order has been accepted';
  //       case 'accepted':
  //         return 'congrats your order has been accepted';
  //       case 'picked_up':
  //         return 'your order has been picked up';
  //       case 'out_for_delivery':
  //         return 'your order is out for delivery';
  //       case 'delivered':
  //         return 'your order has been delivered';
  //       case 'arrived':
  //         return 'your order has been arrived';
  //       default:
  //         return status;

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}
