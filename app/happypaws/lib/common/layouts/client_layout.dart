import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/common/utilities/Toast.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

@RoutePage()
class ClientLayout extends StatefulWidget {
  const ClientLayout({super.key});

  @override
  State<ClientLayout> createState() => _ClientLayoutState();
}

class _ClientLayoutState extends State<ClientLayout> {
  final _pageController = PageController(
    initialPage: 0,
  );
  String searchInput = "";
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> search() async {
    if (searchInput == "") {
      if (!mounted) return;
      ToastHelper.showToastError(context, "Input field can not be empty!");
      return;
    }
    else {
      context.router.push(CatalogRoute(searchInput: searchInput));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HomeTab(), ClinicTab(), ShopTab(), ProfileTab()],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(tabsRouter),
            body: child,
            bottomNavigationBar: bottomNavigationBar(tabsRouter));
      },
    );
  }

  AppBar appBar(TabsRouter tabsRouter) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 80,
      backgroundColor: Colors.white,
      leadingWidth: 150,
      leading: _leadingWidget(),
      actions: [_actionsWidget(tabsRouter)],
    );
  }

  SalomonBottomBar bottomNavigationBar(TabsRouter tabsRouter) {
    return SalomonBottomBar(
      backgroundColor: const Color(0xffF2F2F2),
      currentIndex: tabsRouter.activeIndex,
      onTap: (index) {
        tabsRouter.setActiveIndex(index);
      },
      items: [
        SalomonBottomBarItem(
          icon: SvgPicture.asset(
            "assets/icons/home.svg",
            height: 40,
            width: 40,
            color: tabsRouter.activeIndex == 0
                ? const Color(0xff3F0D84)
                : Colors.grey,
          ),
          title: const Text("Home"),
          selectedColor: const Color(0xff3F0D84),
        ),
        SalomonBottomBarItem(
          icon: SvgPicture.asset(
            "assets/icons/vaccines.svg",
            height: 40,
            width: 40,
            color: tabsRouter.activeIndex == 1
                ? const Color(0xff3F0D84)
                : Colors.grey,
          ),
          title: const Text("Clinic"),
          selectedColor: const Color(0xff3F0D84),
        ),
        SalomonBottomBarItem(
          icon: SvgPicture.asset(
            "assets/icons/storefront.svg",
            height: 40,
            width: 40,
            color: tabsRouter.activeIndex == 2
                ? const Color(0xff3F0D84)
                : Colors.grey,
          ),
          title: const Text("Shop"),
          selectedColor: const Color(0xff3F0D84),
        ),
        SalomonBottomBarItem(
          icon: SvgPicture.asset(
            "assets/icons/account.svg",
            height: 40,
            width: 40,
            color: tabsRouter.activeIndex == 3
                ? const Color(0xff3F0D84)
                : Colors.grey,
          ),
          title: const Text("Profile"),
          selectedColor: const Color(0xff3F0D84),
        ),
      ],
    );
  }

  Row _actionsWidget(TabsRouter tabsRouter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
            visible: tabsRouter.activeIndex == 2,
            child: SizedBox(
              width: 150,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchInput = value;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Search...",
                    labelStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500),
                    suffixIcon: GestureDetector(
                      onTap: () => search(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          "assets/icons/search.svg",
                          height: 20,
                          width: 20,
                          color: const Color(0xff3F0D84),
                        ),
                      ),
                    )),
              ),
            )),
        Visibility(
          visible: tabsRouter.activeIndex == 2,
          child: GestureDetector(
            onTap: () {
              print(context.router.current.path);
              if (context.router.current.name == 'cart') return;
              context.router.push(const CartRoute());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/icons/cart.svg",
                height: 35,
                width: 35,
                color: const Color(0xff3F0D84),
              ),
            ),
          ),
        ),
         Visibility(
          visible: tabsRouter.activeIndex == 2,
          child: GestureDetector(
            onTap: () {
              context.router.push( CatalogRoute(isShowingFavourites: true));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.favorite, size: 35, color: AppColors.primary,)
            ),
          ),
        ),
        Visibility(
          visible: tabsRouter.activeIndex == 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/icons/notifications.svg",
              height: 35,
              width: 35,
              color: Colors.grey,
            ),
          ),
        ),
        Visibility(
          visible: tabsRouter.activeIndex == 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                const Text(
                  "Emergency call",
                  style: TextStyle(color: Color(0xffBA1A36), fontSize: 20),
                ),
                SvgPicture.asset(
                  "assets/icons/phone.svg",
                  height: 24,
                  width: 24,
                  color: const Color(0xffBA1A36),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Row _leadingWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          child: const Image(
            image: AssetImage("assets/images/logo_1.png"),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
