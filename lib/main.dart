import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/shadows.dart';
import 'package:dokan/utils/constants/sizes.dart';
import 'package:dokan/utils/theme/theme.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 801),
      splitScreenMode: false,
      minTextAdapt: true,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dokan',
          theme: TAppTheme.lightTheme,
          home: const MyHomePage(title: 'Product List'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
        child: DynamicHeightGridView(
          crossAxisCount: 2,
          itemCount: 5,
          mainAxisSpacing: 14.w,
          crossAxisSpacing: 14.w,
          builder: (context, i) {
            return _getGridItem();
          },
        ),
      ),
    );
  }

  Widget _getGridItem() {
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
            child: Image.network(
              "https://picsum.photos/id/0/5000/3333",
              width: double.infinity,
              height: 177.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
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
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Name of the Product which  is too long for the small screen",
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        "\$ 10",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: TColors.darkGrey,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      "\$ 8.99",
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                Row(
                  children: [
                    for (var i = 0; i < 5; i++)
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: TSizes.iconSm,
                      )
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
