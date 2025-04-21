import 'package:easy_localization/easy_localization.dart';
import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/resources/app_icon.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:flower_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/base/base_state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_styles.dart';
import '../../../bloc/cart_state.dart';
import '../../../bloc/event.dart';

class CartProductTitleAndRemoveIcon extends StatelessWidget {
  final String title;
  final String id;
  final bool isDummy;

  const CartProductTitleAndRemoveIcon({
    super.key,
    required this.title,
    required this.id,
    required this.isDummy,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: getBoldStyle(
              fontSize: 16.sp,
              color: Colors.black,
            ).copyWith(
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
            height: 30,
            width: 30,
            child: InkWell(
              onTap: () => bloc.add(CartRemoveProductEvent(productId: id)),
              child: isDummy
                  ?  Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20.sp,
                    )
                  : BlocConsumer<CartBloc, CartState>(
                      listenWhen: (previous, current) =>
                          previous.removeFromCartState !=
                          current.removeFromCartState,
                      listener: (context, state) {
                        final utils = getIt<DialogUtils>();
                        if (state.removeFromCartState is BaseSuccessState) {
                          utils.showSnackBar(
                              textColor: Colors.green,
                              message: LocaleKeys.cart_successfullyRemoved.tr(),
                              context: context);
                        } else if (state.removeFromCartState
                            is BaseErrorState) {
                          utils.showSnackBar(
                              textColor: Colors.red,
                              message:
                                  '${LocaleKeys.cart_failedToRemove.tr()}\n'
                                  '${((state.removeFromCartState) as BaseErrorState).errorMessage}',
                              context: context);
                        }
                      },
                      buildWhen: (p, c) =>
                          p.removeFromCartState != c.removeFromCartState,
                      builder: (context, state) =>
                          state.removeFromCartState is BaseLoadingState &&
                                  state.activeCartItemId == id
                              ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 4.w),
                                child: const LinearProgressIndicator(),
                              )
                              : SvgPicture.asset(
                                  AppIcon.delete),
                    ),
            )),
      ],
    );
  }
}
