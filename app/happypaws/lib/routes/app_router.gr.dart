// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i27;
import 'package:flutter/material.dart' as _i28;
import 'package:happypaws/common/layouts/admin_layout.dart' as _i1;
import 'package:happypaws/common/layouts/client_layout.dart' as _i7;
import 'package:happypaws/desktop/pages/_appointmentsPage.dart' as _i3;
import 'package:happypaws/desktop/pages/_brandsPage.dart' as _i4;
import 'package:happypaws/desktop/pages/_categoriesPage.dart' as _i6;
import 'package:happypaws/desktop/pages/_dashboardPage.dart' as _i9;
import 'package:happypaws/desktop/pages/_productsPage.dart' as _i17;
import 'package:happypaws/desktop/pages/_subcategoriesPage.dart' as _i24;
import 'package:happypaws/mobile/pages/_appointmentsPage.dart' as _i25;
import 'package:happypaws/mobile/pages/_catalogPage.dart' as _i5;
import 'package:happypaws/mobile/pages/_clinicPage.dart' as _i8;
import 'package:happypaws/mobile/pages/_homePage.dart' as _i10;
import 'package:happypaws/mobile/pages/_loginPage.dart' as _i11;
import 'package:happypaws/mobile/pages/_makeAppointmentPage.dart' as _i12;
import 'package:happypaws/mobile/pages/_myPetsPage.dart' as _i13;
import 'package:happypaws/mobile/pages/_personalInformationPage.dart' as _i14;
import 'package:happypaws/mobile/pages/_petDetailsPage.dart' as _i15;
import 'package:happypaws/mobile/pages/_productDetailsPage.dart' as _i16;
import 'package:happypaws/mobile/pages/_profilePage.dart' as _i18;
import 'package:happypaws/mobile/pages/_registerPage.dart' as _i20;
import 'package:happypaws/mobile/pages/_registerPageAddPets.dart' as _i19;
import 'package:happypaws/mobile/pages/_registerPageVerification.dart' as _i21;
import 'package:happypaws/mobile/pages/_shopCategorySubcategoriesPage.dart'
    as _i22;
import 'package:happypaws/mobile/pages/_shopPage.dart' as _i23;
import 'package:happypaws/mobile/pages/_welcomePage.dart' as _i26;
import 'package:happypaws/routes/app_router.dart' as _i2;

abstract class $AppRouter extends _i27.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i27.PageFactory> pagesMap = {
    AdminLayout.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AdminLayout(),
      );
    },
    AdminOutlet.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminOutletPage(),
      );
    },
    AppointmentsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AppointmentsPage(),
      );
    },
    BrandsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BrandsPage(),
      );
    },
    CatalogRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CatalogPage(),
      );
    },
    CategoriesRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.CategoriesPage(),
      );
    },
    ClientLayout.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ClientLayout(),
      );
    },
    ClinicRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ClinicPage(),
      );
    },
    ClinicTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ClinicTabPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.DashboardPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.HomePage(),
      );
    },
    HomeTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeTabPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.LoginPage(),
      );
    },
    MakeAppointmentRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.MakeAppointmentPage(),
      );
    },
    MyPetsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MyPetsPage(),
      );
    },
    PersonalInformationRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.PersonalInformationPage(),
      );
    },
    PetDetailsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.PetDetailsPage(),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.ProductDetailsPage(),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.ProductsPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ProfilePage(),
      );
    },
    ProfileTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ProfileTabPage(),
      );
    },
    RegisterAddPetsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.RegisterAddPetsPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.RegisterPage(),
      );
    },
    RegisterVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterVerificationRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i21.RegisterVerificationPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    ShopCategorySubcategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<ShopCategorySubcategoriesRouteArgs>();
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.ShopCategorySubcategoriesPage(
          key: args.key,
          categoryId: args.categoryId,
          categoryPhoto: args.categoryPhoto,
          categoryName: args.categoryName,
        ),
      );
    },
    ShopRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.ShopPage(),
      );
    },
    ShopTab.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ShopTabPage(),
      );
    },
    SubcategoriesRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.SubcategoriesPage(),
      );
    },
    UserAppointmentsRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.UserAppointmentsPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i27.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AdminLayout]
class AdminLayout extends _i27.PageRouteInfo<void> {
  const AdminLayout({List<_i27.PageRouteInfo>? children})
      : super(
          AdminLayout.name,
          initialChildren: children,
        );

  static const String name = 'AdminLayout';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AdminOutletPage]
class AdminOutlet extends _i27.PageRouteInfo<void> {
  const AdminOutlet({List<_i27.PageRouteInfo>? children})
      : super(
          AdminOutlet.name,
          initialChildren: children,
        );

  static const String name = 'AdminOutlet';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AppointmentsPage]
class AppointmentsRoute extends _i27.PageRouteInfo<void> {
  const AppointmentsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          AppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BrandsPage]
class BrandsRoute extends _i27.PageRouteInfo<void> {
  const BrandsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          BrandsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrandsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CatalogPage]
class CatalogRoute extends _i27.PageRouteInfo<void> {
  const CatalogRoute({List<_i27.PageRouteInfo>? children})
      : super(
          CatalogRoute.name,
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CategoriesPage]
class CategoriesRoute extends _i27.PageRouteInfo<void> {
  const CategoriesRoute({List<_i27.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ClientLayout]
class ClientLayout extends _i27.PageRouteInfo<void> {
  const ClientLayout({List<_i27.PageRouteInfo>? children})
      : super(
          ClientLayout.name,
          initialChildren: children,
        );

  static const String name = 'ClientLayout';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ClinicPage]
class ClinicRoute extends _i27.PageRouteInfo<void> {
  const ClinicRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ClinicRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClinicRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ClinicTabPage]
class ClinicTab extends _i27.PageRouteInfo<void> {
  const ClinicTab({List<_i27.PageRouteInfo>? children})
      : super(
          ClinicTab.name,
          initialChildren: children,
        );

  static const String name = 'ClinicTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i9.DashboardPage]
class DashboardRoute extends _i27.PageRouteInfo<void> {
  const DashboardRoute({List<_i27.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i10.HomePage]
class HomeRoute extends _i27.PageRouteInfo<void> {
  const HomeRoute({List<_i27.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeTabPage]
class HomeTab extends _i27.PageRouteInfo<void> {
  const HomeTab({List<_i27.PageRouteInfo>? children})
      : super(
          HomeTab.name,
          initialChildren: children,
        );

  static const String name = 'HomeTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i11.LoginPage]
class LoginRoute extends _i27.PageRouteInfo<void> {
  const LoginRoute({List<_i27.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i12.MakeAppointmentPage]
class MakeAppointmentRoute extends _i27.PageRouteInfo<void> {
  const MakeAppointmentRoute({List<_i27.PageRouteInfo>? children})
      : super(
          MakeAppointmentRoute.name,
          initialChildren: children,
        );

  static const String name = 'MakeAppointmentRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i13.MyPetsPage]
class MyPetsRoute extends _i27.PageRouteInfo<void> {
  const MyPetsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          MyPetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPetsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i14.PersonalInformationPage]
class PersonalInformationRoute extends _i27.PageRouteInfo<void> {
  const PersonalInformationRoute({List<_i27.PageRouteInfo>? children})
      : super(
          PersonalInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PersonalInformationRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i15.PetDetailsPage]
class PetDetailsRoute extends _i27.PageRouteInfo<void> {
  const PetDetailsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          PetDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PetDetailsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i16.ProductDetailsPage]
class ProductDetailsRoute extends _i27.PageRouteInfo<void> {
  const ProductDetailsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ProductDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i17.ProductsPage]
class ProductsRoute extends _i27.PageRouteInfo<void> {
  const ProductsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i18.ProfilePage]
class ProfileRoute extends _i27.PageRouteInfo<void> {
  const ProfileRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ProfileTabPage]
class ProfileTab extends _i27.PageRouteInfo<void> {
  const ProfileTab({List<_i27.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i19.RegisterAddPetsPage]
class RegisterAddPetsRoute extends _i27.PageRouteInfo<void> {
  const RegisterAddPetsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          RegisterAddPetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterAddPetsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i20.RegisterPage]
class RegisterRoute extends _i27.PageRouteInfo<void> {
  const RegisterRoute({List<_i27.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i21.RegisterVerificationPage]
class RegisterVerificationRoute
    extends _i27.PageRouteInfo<RegisterVerificationRouteArgs> {
  RegisterVerificationRoute({
    _i28.Key? key,
    required Map<String, dynamic> user,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          RegisterVerificationRoute.name,
          args: RegisterVerificationRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterVerificationRoute';

  static const _i27.PageInfo<RegisterVerificationRouteArgs> page =
      _i27.PageInfo<RegisterVerificationRouteArgs>(name);
}

class RegisterVerificationRouteArgs {
  const RegisterVerificationRouteArgs({
    this.key,
    required this.user,
  });

  final _i28.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'RegisterVerificationRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i22.ShopCategorySubcategoriesPage]
class ShopCategorySubcategoriesRoute
    extends _i27.PageRouteInfo<ShopCategorySubcategoriesRouteArgs> {
  ShopCategorySubcategoriesRoute({
    _i28.Key? key,
    required int categoryId,
    required String categoryPhoto,
    required String categoryName,
    List<_i27.PageRouteInfo>? children,
  }) : super(
          ShopCategorySubcategoriesRoute.name,
          args: ShopCategorySubcategoriesRouteArgs(
            key: key,
            categoryId: categoryId,
            categoryPhoto: categoryPhoto,
            categoryName: categoryName,
          ),
          rawPathParams: {'id': categoryId},
          initialChildren: children,
        );

  static const String name = 'ShopCategorySubcategoriesRoute';

  static const _i27.PageInfo<ShopCategorySubcategoriesRouteArgs> page =
      _i27.PageInfo<ShopCategorySubcategoriesRouteArgs>(name);
}

class ShopCategorySubcategoriesRouteArgs {
  const ShopCategorySubcategoriesRouteArgs({
    this.key,
    required this.categoryId,
    required this.categoryPhoto,
    required this.categoryName,
  });

  final _i28.Key? key;

  final int categoryId;

  final String categoryPhoto;

  final String categoryName;

  @override
  String toString() {
    return 'ShopCategorySubcategoriesRouteArgs{key: $key, categoryId: $categoryId, categoryPhoto: $categoryPhoto, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i23.ShopPage]
class ShopRoute extends _i27.PageRouteInfo<void> {
  const ShopRoute({List<_i27.PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ShopTabPage]
class ShopTab extends _i27.PageRouteInfo<void> {
  const ShopTab({List<_i27.PageRouteInfo>? children})
      : super(
          ShopTab.name,
          initialChildren: children,
        );

  static const String name = 'ShopTab';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i24.SubcategoriesPage]
class SubcategoriesRoute extends _i27.PageRouteInfo<void> {
  const SubcategoriesRoute({List<_i27.PageRouteInfo>? children})
      : super(
          SubcategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubcategoriesRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i25.UserAppointmentsPage]
class UserAppointmentsRoute extends _i27.PageRouteInfo<void> {
  const UserAppointmentsRoute({List<_i27.PageRouteInfo>? children})
      : super(
          UserAppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAppointmentsRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}

/// generated route for
/// [_i26.WelcomePage]
class WelcomeRoute extends _i27.PageRouteInfo<void> {
  const WelcomeRoute({List<_i27.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i27.PageInfo<void> page = _i27.PageInfo<void>(name);
}
