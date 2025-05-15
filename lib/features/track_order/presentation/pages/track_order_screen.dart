import 'package:flower_app/core/di/injectable.dart';
import 'package:flower_app/core/theme/app_colors.dart';
import 'package:flower_app/core/theme/app_styles.dart';
import 'package:flower_app/core/utils/extentions.dart';
import 'package:flower_app/core/widget/dialog_utils.dart';
import 'package:flower_app/features/track_order/presentation/cubit/track_order_cubit.dart';
import 'package:flower_app/features/track_order/presentation/widgets/order_traker_time_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrackOrderCubit>().trackOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Order'),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios_new_rounded),
          onTap: () => context.pop(),
        ),
        leadingWidth: 25,
      ),
      body: BlocBuilder<TrackOrderCubit, TrackOrderState>(
        builder: (context, state) {
          if (state is TrackOrderLoading) {
            return  const Center(child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          }

          if (state is TrackOrderError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(state.message, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: ElevatedButton(
                      onPressed: () => context
                          .read<TrackOrderCubit>()
                          .trackOrder(widget.orderId),
                      child: const Text('try again'),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is TrackOrderSuccess) {
            return _buildTrackingUI(context, state);
          }

          return const Center(child: Text('No data available'));
        },
      ),
    );
  }

  Widget _buildTrackingUI(BuildContext context, TrackOrderSuccess state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'estimated Arrival',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "03 Sep 2024, 11:00 AM",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Divider(
          indent: 16,
          endIndent: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:16, ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.assignment_outlined,
                          color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'order status',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              state.statusText,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        _buildDriverInfo(context, state),
         const SizedBox(height: 8),
        Center(
          child: Image.asset('assets/icons/Car.png', height:80),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OrderTrackerTimeline(currentStep: state.step),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child:
              ElevatedButton(onPressed: () {}, child: const Text('Show Map')),
        ),
      ],
    );
  }

  Widget _buildDriverInfo(BuildContext context, TrackOrderSuccess state) {
    if (state.driverInfo == null || !state.hasDriver) {
      return const SizedBox.shrink();
    }

    final driverName = state.driverInfo?['name']?.toString() ?? '';
    final driverPhone = state.driverInfo?['phone']?.toString() ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // if(driverName.isNotEmpty)
              Center(
                child: Image.asset('assets/icons/Delivery Boy.png')
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      driverName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                        driverName.isEmpty ? "Some One Will Take Care Of Your Order Soon" : 'Is your delivery hero for today',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            if(driverName.isNotEmpty)
            ...[
                IconButton(
                  onPressed: () => _makePhoneCall(driverPhone),
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.primary,
                  ),
                ),
                IconButton(
                  onPressed: () => _openWhatsapp(driverPhone),
                  icon: const Icon(
                    Icons.chat,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cant make phone call')),
      );
    }
  }

  void _openWhatsapp(String phoneNumber) async {
    var whatsappUrl = "https://wa.me/$phoneNumber";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cant open WhatsApp')),
      );
    }
  }
}
