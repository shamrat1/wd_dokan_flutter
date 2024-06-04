import 'package:cached_network_image/cached_network_image.dart';
import 'package:dokan/models/product.dart';
import 'package:dokan/states/products_provider.dart';
import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/shadows.dart';
import 'package:dokan/utils/constants/sizes.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<List<Product>> products = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 20.w),
              onPressed: () {},
              icon: const Icon(Icons.search)),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(65.h),
          child: Container(
            margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
              boxShadow: TShadows.primaryBoxShadow,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 19.w),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      CupertinoIcons.slider_horizontal_3,
                      color: TColors.grey,
                      size: TSizes.iconMd,
                    ),
                  ),
                ),
                Text(
                  "Filter",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Text(
                  "Sort By",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.w, top: 5.h, left: 3.w),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      CupertinoIcons.back,
                      color: TColors.grey,
                      size: TSizes.iconMd,
                    ),
                  ),
                ),
                Icon(
                  CupertinoIcons.list_bullet,
                  color: TColors.black,
                  size: TSizes.iconMd,
                )
              ],
            ),
          ),
        ),
      ),
      body: switch (products) {
        AsyncData(:final value) => Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: DynamicHeightGridView(
              crossAxisCount: 2,
              itemCount: value.length,
              mainAxisSpacing: 14.w,
              crossAxisSpacing: 14.w,
              builder: (context, i) {
                return _getGridItem(value[i]);
              },
            ),
          ),
        AsyncError() => const Center(child: Text("something went wrong")),
        _ => const Center(
            child: CircularProgressIndicator(),
          )
      },
    );
  }

  Widget _getGridItem(Product product) {
    return Container(
      height: 290.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
        boxShadow: TShadows.primaryBoxShadow,
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(TSizes.borderRadiusMd),
              topRight: Radius.circular(TSizes.borderRadiusMd),
            ),
            child: CachedNetworkImage(
              imageUrl: product.images?.first.src ?? "",
              width: double.infinity,
              height: 177.h,
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 177.h,
                  color: TColors.grey,
                  alignment: Alignment.center,
                  child: const Icon(Icons.error),
                );
              },
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  product.name ?? "",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (product.salePrice?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "\$ ${product.price}",
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: TColors.darkGrey,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    Text(
                      "\$ ${(product.salePrice?.isNotEmpty ?? false) ? product.salePrice : product.price}",
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    for (var i = 0; i < 5; i++)
                      Builder(builder: (context) {
                        var rating = (product.ratingCount ?? 0);
                        if (rating > 0) {
                          if (i < rating) {
                            return Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                              size: TSizes.iconSm,
                            );
                          }
                        }
                        return Icon(
                          Icons.star_outline_rounded,
                          color: Colors.grey,
                          size: TSizes.iconSm,
                        );
                      })
                  ],
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
