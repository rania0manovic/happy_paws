import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/common/utilities/message_notifier.dart';
import 'package:happypaws/common/utilities/toast.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/routes/app_router.gr.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ClientLayout extends StatefulWidget {
  const ClientLayout({super.key});

  @override
  State<ClientLayout> createState() => _ClientLayoutState();
}

class _ClientLayoutState extends State<ClientLayout>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController(
    initialPage: 0,
  );
  late AnimationController _animationController;
  String searchInput = "";
  bool newNotification = false;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
void launchDialer(String phoneNumber) async {
  final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunch(telUri.toString())) {
    await launch(telUri.toString());
  } else {
    throw 'Could not launch $telUri';
  }
}

  Future<void> search() async {
    if (searchInput == "") {
      if (!mounted) return;
      ToastHelper.showToastError(context, "Input field can not be empty!");
      return;
    } else {
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
      scrolledUnderElevation: 0,
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
           if (index == tabsRouter.activeIndex) {
                tabsRouter.stackRouterOfIndex(index)!.popUntilRoot();
              } else {
                tabsRouter.setActiveIndex(index);
              }
      },
      items: [
        SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 30,
              width: 30,
              color:
                  tabsRouter.activeIndex == 0 ? AppColors.primary : Colors.grey,
            ),
            title: const Text("Home"),
            selectedColor: AppColors.primary),
        SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/vaccines.svg",
              height: 30,
              width: 30,
              color:
                  tabsRouter.activeIndex == 1 ? AppColors.primary : Colors.grey,
            ),
            title: const Text("Clinic"),
            selectedColor: AppColors.primary),
        SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/storefront.svg",
              height: 30,
              width: 30,
              color:
                  tabsRouter.activeIndex == 2 ? AppColors.primary : Colors.grey,
            ),
            title: const Text("Shop"),
            selectedColor: AppColors.primary),
        SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/account.svg",
              height: 30,
              width: 30,
              color:
                  tabsRouter.activeIndex == 3 ? AppColors.primary : Colors.grey,
            ),
            title: const Text("Profile"),
            selectedColor: AppColors.primary),
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
              width: 140,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchInput = value;
                  });
                },
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  search();
                },
                decoration: InputDecoration(
                    labelText: "Search...",
                    labelStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500),
                    suffixIcon: GestureDetector(
                      onTap: () => search(),
                      child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.search,
                            size: 25,
                            color: AppColors.primary,
                          )),
                    )),
              ),
            )),
        Visibility(
          visible: tabsRouter.activeIndex == 2,
          child: GestureDetector(
            onTap: () {
              if (context.router.current.name == 'cart') return;
              context.router.push(const CartRoute());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("assets/icons/cart.svg",
                  height: 25, width: 25, color: AppColors.primary),
            ),
          ),
        ),
        Visibility(
          visible: tabsRouter.activeIndex == 2,
          child: GestureDetector(
            onTap: () {
              context.router.push(CatalogRoute(isShowingFavourites: true));
            },
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  size: 25,
                  color: AppColors.primary,
                )),
          ),
        ),
        Visibility(
          visible: tabsRouter.activeIndex == 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    final notificationStatus =
                        Provider.of<NotificationStatus>(context, listen: false);
                    notificationStatus.setHasNewNotification(false);
                    notificationStatus.setIsShowingNotifications(
                        !notificationStatus.isShowingNotifications);
                  },
                  child: Icon(
                    Icons.notifications_none_outlined,
                    size: 25,
                    color: Colors.grey.shade500,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Consumer<NotificationStatus>(
                    builder: (context, value, child) {
                      return value.hasNewNotification
                          ? FadeTransition(
                              opacity: _animationController,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.error, 
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: tabsRouter.activeIndex == 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                // demo phone number
                launchDialer("+38761 111 222");
              },
              child: Row(
                children: [
                  const Text(
                    "Emergency call",
                    style: TextStyle(
                        color: Color(0xffBA1A36),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SvgPicture.asset(
                    "assets/icons/phone.svg",
                    height: 25,
                    width: 25,
                    color: const Color(0xffBA1A36),
                  )
                ],
              ),
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
          padding: const EdgeInsets.only(left: 10),
          width: 120,
          child: const Image(
            image: AssetImage("assets/images/logo_1.jpg"),
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
