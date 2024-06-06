import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:dokan/pages/category.dart';
import 'package:dokan/pages/home.dart';
import 'package:dokan/pages/profile.dart';
import 'package:dokan/pages/shopping_cart.dart';
import 'package:dokan/pages/signin.dart';
import 'package:dokan/pages/signup.dart';
import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/sizes.dart';
import 'package:dokan/utils/storage/shared_prefs.dart';
import 'package:dokan/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await SharedPrefs.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _authenticated = false;

  @override
  void initState() {
    super.initState();
    SharedPrefs.getBool("authenticated").then((val) {
      setState(() {
        _authenticated = val;
      });
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 801),
        splitScreenMode: false,
        minTextAdapt: true,
        builder: (context, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Dokan',
            theme: TAppTheme.lightTheme,
            home: _authenticated ? const LandingPage() : const SigninPage(),
          );
        },
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xffFF679B),
                Color(0xffFF7B51),
              ],
            ),
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.search,
            color: Colors.white,
            size: TSizes.iconMd,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (val) => setState(() {
          _currentPage = val;
        }),
        children: const [
          MyHomePage(title: "Product List"),
          CategoryPage(),
          ShoppingCartPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        iconSize: TSizes.iconMd,
        icons: const [
          Icons.home,
          Icons.category,
          Icons.shopping_cart,
          Icons.person,
        ],
        activeIndex: _currentPage,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        activeColor: TColors.primary,
        inactiveColor: TColors.darkGrey,
        onTap: (index) {
          setState(() {
            _currentPage = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}
