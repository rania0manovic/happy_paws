import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/utilities/colors.dart';
import 'package:happypaws/routes/app_router.gr.dart';

@RoutePage()
class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  int _selectedIndex = 0;
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      setState(() {
        this.user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          sideBar(context),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              height: 35,
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: AppColors.dimWhite,
                                  borderRadius: BorderRadius.circular(100)),
                              child: Row(
                                children: [
                                  const Image(
                                      image:
                                          AssetImage("assets/images/user.png")),
                                  if (user != null)
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        user!['FirstName'] +
                                            " " +
                                            user!['LastName'],
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    )
                                ],
                              )),
                          IconButton(
                              onPressed: (){
                                AuthService().logOut();
                                context.router.push(const LoginDesktopRoute());
                              },
                              icon: const Icon(Icons.logout,
                                  color: AppColors.error, size: 18))
                        ]),
                  ),
                ),
                const Expanded(child: AutoRouter()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Drawer sideBar(BuildContext context) {
    return Drawer(
      width: 250,
      shape: const BeveledRectangleBorder(),
      backgroundColor: const Color.fromARGB(235, 0, 0, 0),
      elevation: 2,
      child: ListView(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        children: <Widget>[
          Visibility(
            visible: user!['Role'] == 'Admin',
            child: barTile(0, context, "Dashboard",
                "assets/icons/dashboard.svg", const DashboardRoute()),
          ),
          ExpansionTile(
            iconColor: AppColors.primary,
            collapsedIconColor: Colors.white,
            leading: SvgPicture.asset(
              "assets/icons/storefront.svg",
              color: Colors.white,
              width: 20,
            ),
            title: const Text(
              "Shop",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            children: [
              barTile(1, context, "Orders", "assets/icons/none.svg",
                  const AppointmentsRoute()),
              barTile(2, context, "Inventory", "assets/icons/none.svg",
                  const AppointmentsRoute()),
            ],
          ),
          barTile(3, context, "Appointments", "assets/icons/calender.svg",
              const AppointmentsRoute()),
          Visibility(
            visible: user!['Role'] == 'Admin',
            child: barTile(4, context, "Employees",
                "assets/icons/employees.svg", const AppointmentsRoute()),
          ),
          barTile(5, context, "Patients", "assets/icons/paw.svg",
              const AppointmentsRoute()),
          Visibility(
            visible: user!['Role'] == 'Admin',
            child: barTile(6, context, "Reports", "assets/icons/report.svg",
                const AppointmentsRoute()),
          ),
          Visibility(
            visible: user!['Role'] == 'Admin',
            child: ExpansionTile(
              iconColor: AppColors.primary,
              collapsedIconColor: Colors.white,
              leading: SvgPicture.asset(
                "assets/icons/settings.svg",
                color: Colors.white,
                width: 20,
              ),
              title: const Text(
                "Settings",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              children: [
                barTile(7, context, "Product categories", "",
                    const CategoriesRoute()),
                barTile(8, context, "Product subcategories", "",
                    const SubcategoriesRoute()),
                barTile(9, context, "Brands", "", const BrandsRoute()),
                barTile(10, context, "Products", "assets/icons/none.svg",
                    const ProductsRoute()),
                            barTile(11, context, "Pet types", "",
                    const PetTypesRoute()),
                     barTile(12, context, "Pet breeds", "",
                    const PetBreedsRoute()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding barTile(
    int index,
    BuildContext context,
    String name,
    String iconUrl,
    PageRouteInfo page,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        leading: SvgPicture.asset(
          iconUrl,
          color: const Color.fromARGB(208, 217, 217, 217),
          height: 20,
          width: 20,
        ),
        title: Text(name,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600)),
        selected: _selectedIndex == index,
        selectedTileColor: AppColors.primary,
        hoverColor: const Color.fromARGB(25, 219, 219, 219),
        onTap: () {
          context.router.push(page);
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
