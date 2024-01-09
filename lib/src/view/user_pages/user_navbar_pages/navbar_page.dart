import 'package:agriculture/src/auth_repo/auth_repo.dart';
import 'package:agriculture/src/constant/color.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/category_page.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/dashboard_page.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/disease_page.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/guid_page.dart';
import 'package:agriculture/src/view/user_pages/user_navbar_pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({super.key});

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final _authRepo = Get.put(AuthenticationRepository());
  late final email = _authRepo.firebaseUser.value?.email;

  final List<Widget> widgetList = const [
    Dashboard(),
    CategoriesPage(),
    GuidPage(),
    DiseasePage(),
    ProfilePage(),
  ];

  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
            body: Center(
              child: widgetList[selectedIndex.value],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: ColorConst.secScaffoldBackgroundColor,
                selectedItemColor: ColorConst.mainScaffoldBackgroundColor,
                unselectedItemColor: ColorConst.mainScaffoldBackgroundColor,
                onTap: (value) {
                  selectedIndex.value = value;
                },
                currentIndex: selectedIndex.value,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    label: "",
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.table,
                    ),
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.book,
                    ),
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.healing_sharp,
                    ),
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    icon: const Icon(
                      Icons.person_2_outlined,
                    ),
                    label: "",
                  ),
                ]))));
  }
}
