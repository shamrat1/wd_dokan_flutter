import 'package:dokan/pages/signin.dart';
import 'package:dokan/utils/constants/colors.dart';
import 'package:dokan/utils/constants/custom_textfields.dart';
import 'package:dokan/utils/constants/shadows.dart';
import 'package:dokan/utils/constants/sizes.dart';
import 'package:dokan/utils/storage/shared_prefs.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name;
  String? _email;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _aptController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    SharedPrefs.getString("username").then((val) {
      setState(() {
        _usernameController.text = val;
        _name = val;
      });
    });
    SharedPrefs.getString("email").then((val) {
      setState(() {
        _emailController.text = val;
        _email = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        actions: [
          IconButton(
            onPressed: () {
              SharedPrefs.setBool("authenticated", false);
              SharedPrefs.setString("token", "");
              SharedPrefs.setString("username", "");
              SharedPrefs.setString("email", "");
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Logged Out.")));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => SigninPage()),
                  (val) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileImage(),
            Text(
              _name ?? "",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              _email ?? "",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: const Color(0xff535353),
                  ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 22.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(TSizes.borderRadiusMd),
                boxShadow: TShadows.primaryBoxShadow,
              ),
              child: Column(
                children: [
                  _getExpansiontile(Icons.person_outline_rounded, "Account", [
                    ..._getTitleAndTextField("Email", _emailController, false),
                    ..._getTitleAndTextField(
                        "Full Name", _usernameController, true),
                    ..._getTitleAndTextField(
                        "Street Address", _streetController, true),
                    ..._getTitleAndTextField(
                        "Apt, Suite, Bldg (Optional)", _aptController, true),
                    Container(
                      padding: EdgeInsets.only(bottom: 12.h, top: 12.h),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Zip Code",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: const Color(0xff263238)),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 100.w,
                        child: TextFormField(
                          controller: _zipController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16.w),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 135.w,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text(
                                "Cancel",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 135.w,
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showMaterialBanner(
                                  MaterialBanner(
                                    content: const Text(
                                        "Update Profile is not implemented for lack of api provided."),
                                    actions: [
                                      IconButton(
                                          onPressed: () => ScaffoldMessenger.of(
                                                  context)
                                              .removeCurrentMaterialBanner(),
                                          icon: Icon(Icons.close)),
                                    ],
                                  ),
                                );
                              },
                              child: const Text(
                                "Apply",
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                  _getDivider(),
                  _getExpansiontile(Icons.lock_outline_rounded, "Password", []),
                  _getDivider(),
                  _getExpansiontile(
                      Icons.notifications_outlined, "Notifications", []),
                  _getDivider(),
                  _getExpansiontile(
                      Icons.favorite_outline_rounded, "Wishlist", []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getTitleAndTextField(
      String title, TextEditingController controller, bool topPadding) {
    return [
      Container(
        padding: EdgeInsets.only(bottom: 12.h, top: topPadding ? 12.h : 0),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: const Color(0xff263238)),
        ),
      ),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.w),
        ),
      ),
    ];
  }

  Widget _getExpansiontile(IconData icon, String title, List<Widget> children) {
    return ExpansionTile(
      leading: Icon(
        icon,
        color: TColors.darkGrey,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      dense: false,
      shape: Border.all(color: Colors.white),
      expandedAlignment: Alignment.centerLeft,
      childrenPadding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
      children: children,
    );
  }

  Widget _getDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: const Divider(
        height: 0.5,
        color: TColors.grey,
      ),
    );
  }

  Widget _profileImage() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.h),
      alignment: Alignment.center,
      child: DottedBorder(
        strokeWidth: .75,
        dashPattern: [3, 5],
        color: const Color(0xffFFADAD),
        borderType: BorderType.Circle,
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            "assets/profile.png",
            height: 112.h,
            width: 112.h,
          ),
        ),
      ),
    );
  }
}
