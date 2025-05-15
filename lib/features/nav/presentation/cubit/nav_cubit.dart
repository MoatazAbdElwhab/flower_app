import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/core/sharedModels/fire_base_order_model.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flower_app/features/profile/domain/usecases/get_user_oders_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_app/features/nav/data/firebase_ioslate_helper.dart'; 

import '../../../home/domain/entities/category_occasion_entity.dart';
import 'nav_state.dart';

@lazySingleton
class NavCubit extends Cubit<NavState> {
  NavCubit(
    // this._firebaseService,
    this._getUserOdersUseCase,
  ) : super(const NavState(tabIndex: 0));

  // final FirebaseService _firebaseService;
  final GetUserOdersUseCase _getUserOdersUseCase;

  void changeTab(int index, {int? selectedCategoryIndex}) {
    emit(state.copyWith(
      tabIndex: index,
      selectedCategoryIndex: selectedCategoryIndex,
    ));
  }

  void getCategories(List<CategoryOccasionEntity> categories) {
    emit(state.copyWith(categories: categories));
  }

  UserDataModel getUserdataAfterCheckOut(
    UserDataModel userDataModel,
  ) {
   emit(state.copyWith(userDataModel: userDataModel));
    return state.userDataModel!;
  }

  Future<Either<ApiException, UserOrdersEntitiy>> getUserOrders() async {
    return await (_getUserOdersUseCase());
  }

  Future<void> syncUserOrdersToFirebase() async {
    try {
      final result = await getUserOrders();

      result.fold(
        (error) {
          debugPrint('Error fetching orders for sync: ${error.message}');
        },
        (ordersData) async {
          if (ordersData.orders.isNotEmpty) {
            await FirebaseIsolateHelper.syncOrdersInIsolate(ordersData, state.userDataModel!);
          }
        },
      );
    } catch (e) {
      debugPrint('Silent sync error: $e');
    }
  }

//   void saveOrdersAfterCheckOut(List<Order> completedOrders) {
//     bool isOrderAdded = false;

// }
  // void adOrderToFireBase() {
  //   _firebaseService.addOrderToRTDB(
  //       orderId: orderId,
  //       userId: userId,
  //       status: status,
  //       estimatedArrival: estimatedArrival);
  // }
}
