import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happypaws/common/components/dialogs/change_password_dialog.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/common/services/ImagesService.dart';
import 'package:happypaws/common/utilities/Colors.dart';
import 'package:happypaws/desktop/components/spinner.dart';
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
  Map<String, dynamic>? profilePhoto;

  var openMenu = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future getUser() async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      if (user['ProfilePhotoId'] != null && user['ProfilePhotoId'] != "") {
        var image = await ImagesService().get("/${user['ProfilePhotoId']}");
        if (image.statusCode == 200) {
          setState(() {
            profilePhoto = image.data;
          });
        }
      }
      setState(() {
        this.user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null
          ? const Spinner()
          : Row(
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
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: profilePhoto != null
                                                ? SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: Image.network(
                                                          profilePhoto![
                                                              'downloadURL']),
                                                    ),
                                                  )
                                                : const Image(
                                                    image: AssetImage(
                                                        "assets/images/user.png"))),
                                        if (user != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              user!['FirstName'] +
                                                  " " +
                                                  user!['LastName'],
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        PopupMenuButton<String>(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: SvgPicture.asset(
                                              "assets/icons/more_horiz.svg",
                                              height: 30,
                                              width: 30,
                                              color: AppColors.gray,
                                            ),
                                          ),
                                          onSelected: (String result) {
                                            switch (result) {
                                              case 'changePassword':
                                                {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                          return AlertDialog(
                                                            insetPadding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        300,
                                                                    vertical:
                                                                        20),
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            content:
                                                                ChangePasswordMenu(
                                                              onCanceled: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              setState:
                                                                  setState,
                                                              onClosed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                context.router.push(
                                                                    const LoginDesktopRoute());
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                }
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                            const PopupMenuItem<String>(
                                              value: 'changePassword',
                                              child: Text('Change Password'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                IconButton(
                                    onPressed: () {
                                      AuthService().logOut();
                                      context.router
                                          .push(const LoginDesktopRoute());
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
            visible: user != null ? user!['Role'] == 'Admin' : false,
            child: barTile(0, context, "Dashboard",
                "assets/icons/dashboard.svg", const DashboardRoute()),
          ),
          Visibility(
            visible: user!['Role'] == 'Admin' ||
                user!['EmployeePosition'] == 'PharmacyStaff' ||
                user!['EmployeePosition'] == 'RetailStaff',
            child: ExpansionTile(
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
                Visibility(
                    visible: user!['Role'] == 'Admin' ||
                        user!['EmployeePosition'] == 'PharmacyStaff',
                    child:
                        barTile(1, context, "Orders", "", const OrdersRoute())),
                Visibility(
                    visible: user!['Role'] == 'Admin' ||
                        user!['EmployeePosition'] == 'RetailStaff',
                    child: barTile(
                        2, context, "Inventory", "", const InventoryRoute())),
              ],
            ),
          ),
          Visibility(
            visible: user!['Role'] == 'Admin' ||
                user!['EmployeePosition'] == 'Veterinarian' ||
                user!['EmployeePosition'] == 'VeterinarianTechnician' ||
                user!['EmployeePosition'] == 'VeterinarianAssistant' ||
                user!['EmployeePosition'] == 'Groomer',
            child: barTile(3, context, "Appointments",
                "assets/icons/calender.svg", const AppointmentsRoute()),
          ),
          Visibility(
            visible: user!['Role'] == 'Admin' ||
                user!['EmployeePosition'] == 'Veterinarian' ||
                user!['EmployeePosition'] == 'VeterinarianTechnician' ||
                user!['EmployeePosition'] == 'VeterinarianAssistant' ||
                user!['EmployeePosition'] == 'Groomer' ||
                user!['EmployeePosition'] == 'PharmacyStaff',
            child: barTile(4, context, "Patients", "assets/icons/paw.svg",
                PatientsRoute()),
          ),
          Visibility(
            visible: user!['Role'] == 'Admin' ? true : false,
            child: barTile(5, context, "Employees",
                "assets/icons/employees.svg", const EmployeesRoute()),
          ),
          Visibility(
            visible: user!['Role'] == 'Admin' ? true : false,
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
                barTile(10, context, "Products", "", const ProductsRoute()),
                barTile(11, context, "Pet types", "", const PetTypesRoute()),
                barTile(12, context, "Pet breeds", "", const PetBreedsRoute()),
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
        leading: iconUrl == ""
            ? const SizedBox(
                width: 10,
              )
            : SvgPicture.asset(
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
