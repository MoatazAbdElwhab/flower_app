import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/home/data/model/response/home/product.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_styles.dart';
import '../app_carousel/app_carousel.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // late bool isInCart; // to initialize in initState
  @override
  void initState() {
    /// check if is in cart then handle add to cart method
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productArgument = ModalRoute.of(context)!.settings.arguments as Product;

    ///  product dm is dummy class implemented below to show how to use it;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            /// wrapped with column to always show add to cart button
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    productArgument.images != null &&
                            productArgument.images!.isNotEmpty
                        ? AppCarousel(
                            networkImages: productArgument.images!,
                          )
                        : SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.5,
                            child: const Icon(
                              Icons.warning_amber_outlined,
                              color: AppColors.grey,
                            ),
                          ),

                    // product details
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price
                          Text(
                            "EGP ${productArgument.price?.toStringAsFixed(2) ?? ''}",
                            style: getBoldStyle(
                                color: Colors.black, fontSize: 20.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            productArgument.title ?? '',
                            style: getMediumStyle(
                                color: Colors.black, fontSize: 16.sp),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Text('Description',
                                style: getMediumStyle(
                                    color: Colors.black, fontSize: 16.sp)),
                          ),
                          Text(productArgument.description ?? '',
                              style: getRegularStyle(
                                  color: Colors.black, fontSize: 14.sp)),
                        ],
                      ),
                    ),
                    // Add to Cart Button
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ElevatedButton(
                onPressed: () {
                  //isInCart? remove: addToCart
                },
                child: Text(
                  // isInCart? 'Remove from cart':
                  'Add to cart',
                  style:
                      getMediumStyle(color: AppColors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        ));
  }
}
