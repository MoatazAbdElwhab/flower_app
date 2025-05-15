import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/routes/routes.dart';
import 'package:flower_app/core/utils/extentions.dart';
import 'package:flower_app/features/profile/domain/entities/user_orders/user_orders_entitiy.dart';
import 'package:flower_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flower_app/features/profile/presentation/widgets/user_oders_loading_widget.dart';
import 'package:flower_app/features/profile/presentation/widgets/user_orders_tabbar.dart';
import 'package:flower_app/features/profile/presentation/widgets/user_orders_widget.dart';
import 'package:flower_app/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:flower_app/features/track_order/presentation/pages/track_order_screen.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class UserOrdersScreen extends StatelessWidget {
  final ProfileCubit cubit;
  const UserOrdersScreen({
    super.key,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    cubit.getUserOrders();
    return BlocProvider.value(
      value: cubit,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.myOrders_title.tr()),
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
            leadingWidth: 25,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(WidthExtension(50).w),
                child: const UserOrdersTabbar()),
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.getUserOrdersState is BaseLoadingState) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: const UserOdersLoadingWidget(),
                );
              }
              if (state.getUserOrdersState is BaseErrorState) {
                return Center(
                  child: Text(
                    (state.getUserOrdersState as BaseErrorState).errorMessage,
                  ),
                );
              }
              if (state.getUserOrdersState
                  is BaseSuccessState<UserOrdersEntitiy>) {
                final data = (state.getUserOrdersState
                        as BaseSuccessState<UserOrdersEntitiy>)
                    .data;

                final activeOrders = data?.orders
                        .where((order) =>
                            (order.state?.toLowerCase() ?? '') == 'active' ||
                            (order.state?.toLowerCase() ?? '') == 'pending' ||
                            (order.state?.toLowerCase() ?? '') == 'in progress')
                        .toList() ??
                    [];

                final completedOrders = data?.orders
                        .where((order) =>
                            (order.state?.toLowerCase() ?? '') == 'completed')
                        .toList() ??
                    [];

                return TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // Active Orders Tab
                    activeOrders.isEmpty
                        ? Center(
                            child: Text(LocaleKeys.myOrders_noOrders.tr()),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(WidthExtension(16).w),
                            itemCount: activeOrders.length,
                            itemBuilder: (context, index) {
                              debugPrint(
                                  'activeOrders: ${activeOrders.length}');
                              // final order = activeOrders[index];
                              return UserOrdersWidget(
                                imageUrl: activeOrders[index]
                                            .orderItems
                                            ?.isNotEmpty ==
                                        true
                                    ? activeOrders[index]
                                            .orderItems![0]
                                            .product
                                            ?.imgCover ??
                                        ''
                                    : '',
                                title: activeOrders[index]
                                            .orderItems
                                            ?.isNotEmpty ==
                                        true
                                    ? activeOrders[index]
                                            .orderItems![0]
                                            .product
                                            ?.title ??
                                        ''
                                    : '',
                                order: activeOrders[index],
                                onPressed: () {
                                  print(
                                      'activeOrders: ${activeOrders[index].id}');
                                  context.push(BlocProvider(
                                    create: (context) =>
                                        getIt<TrackOrderCubit>(),
                                    child: TrackOrderScreen(
                                        orderId: activeOrders[index].id ?? ''),
                                  ));
                                },
                                orderStatus:
                                    LocaleKeys.myOrders_TrackOrder.tr(),
                                index: index,
                              );
                            },
                          ),
                    // Completed Orders Tab
                    completedOrders.isEmpty
                        ? Center(
                            child: Text(LocaleKeys.myOrders_noOrders.tr()),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: completedOrders.length,
                            itemBuilder: (context, index) {
                              debugPrint(
                                  'activeOrders: ${completedOrders.length}');
                              // final order = completedOrders[index];
                              return UserOrdersWidget(
                                imageUrl: completedOrders[index]
                                            .orderItems
                                            ?.isNotEmpty ==
                                        true
                                    ? completedOrders[index]
                                            .orderItems![0]
                                            .product
                                            ?.imgCover ??
                                        ''
                                    : '',
                                title: completedOrders[index]
                                            .orderItems
                                            ?.isNotEmpty ==
                                        true
                                    ? completedOrders[index]
                                            .orderItems![0]
                                            .product
                                            ?.title ??
                                        ''
                                    : '',
                                order: completedOrders[index],
                                orderStatus: LocaleKeys.myOrders_reOrder.tr(),
                                index: index,
                              );
                            },
                          ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
