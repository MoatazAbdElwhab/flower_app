import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/base/base_state.dart';
import 'package:flower_app/core/common_widgets/dummy_widgets/dummy_widgets.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/features/notification/domain/entities/notification_data.dart';
import 'package:flower_app/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:flower_app/features/notification/presentation/widgets/notification_item.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyNotifications = AppDummyWidgets().dummyNotifications;

    return BlocProvider(
      create: (context) => getIt<NotificationCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            LocaleKeys.notification_title.tr(),
          ),
          surfaceTintColor: Colors.transparent,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            switch (state.getNotificationsState) {
              case BaseErrorState(errorMessage: final errorMessage):
                return Center(child: Text(errorMessage));
              case BaseLoadingState():
              case BaseSuccessState():
                return Skeletonizer(
                  enabled: state.getNotificationsState is BaseLoadingState,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.getNotificationsState is BaseSuccessState
                        ? (state.getNotificationsState as BaseSuccessState)
                            .data
                            .length
                        : dummyNotifications.length,
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        notification: state.getNotificationsState
                                is BaseSuccessState
                            ? (state.getNotificationsState as BaseSuccessState)
                                .data[index]
                            : dummyNotifications[index],
                      );
                    },
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
