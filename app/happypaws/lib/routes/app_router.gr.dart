// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i28;
import 'package:flutter/material.dart' as _i29;
import 'package:happypaws/common/layouts/admin_layout.dart' as _i1;
import 'package:happypaws/common/layouts/client_layout.dart' as _i8;
import 'package:happypaws/desktop/pages/_appointmentsPage.dart' as _i3;
import 'package:happypaws/desktop/pages/_brandsPage.dart' as _i4;
import 'package:happypaws/desktop/pages/_categoriesPage.dart' as _i7;
import 'package:happypaws/desktop/pages/_dashboardPage.dart' as _i10;
import 'package:happypaws/desktop/pages/_productsPage.dart' as _i18;
import 'package:happypaws/desktop/pages/_subcategoriesPage.dart' as _i25;
import 'package:happypaws/mobile/pages/_appointmentsPage.dart' as _i26;
import 'package:happypaws/mobile/pages/_cartPage.dart' as _i5;
import 'package:happypaws/mobile/pages/_catalogPage.dart' as _i6;
import 'package:happypaws/mobile/pages/_clinicPage.dart' as _i9;
import 'package:happypaws/mobile/pages/_homePage.dart' as _i11;
import 'package:happypaws/mobile/pages/_loginPage.dart' as _i12;
import 'package:happypaws/mobile/pages/_makeAppointmentPage.dart' as _i13;
import 'package:happypaws/mobile/pages/_myPetsPage.dart' as _i14;
import 'package:happypaws/mobile/pages/_personalInformationPage.dart' as _i15;
import 'package:happypaws/mobile/pages/_petDetailsPage.dart' as _i16;
import 'package:happypaws/mobile/pages/_productDetailsPage.dart' as _i17;
import 'package:happypaws/mobile/pages/_profilePage.dart' as _i19;
import 'package:happypaws/mobile/pages/_registerPage.dart' as _i21;
import 'package:happypaws/mobile/pages/_registerPageAddPets.dart' as _i20;
import 'package:happypaws/mobile/pages/_registerPageVerification.dart' as _i22;
import 'package:happypaws/mobile/pages/_shopCategorySubcategoriesPage.dart'
    as _i23;
import 'package:happypaws/mobile/pages/_shopPage.dart' as _i24;
import 'package:happypaws/mobile/pages/_welcomePage.dart' as _i27;
import 'package:happypaws/routes/app_router.dart' as _i2;

abstract class $AppRouter extends _i28.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i28.PageFactory> pagesMap = {
    AdminLayout.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AdminLayout(),
      );
    },
    AdminOutlet.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminOutletPage(),
      );
    },
    AppointmentsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AppointmentsPage(),
      );
    },
    BrandsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BrandsPage(),
      );
    },
    CartRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.CartPage(),
      );
    },
    CatalogRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<CatalogRouteArgs>(
          orElse: () => CatalogRouteArgs(
                categoryId: pathParams.optInt('categoryId'),
                subcategoryId: pathParams.optInt('subcategoryId'),
              ));
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CatalogPage(
          key: args.key,
          categoryId: args.categoryId,
          subcategoryId: args.subcategoryId,
          categoryPhoto: args.categoryPhoto,
          categoryName: args.categoryName,
          subcategoryName: args.subcategoryName,
          searchInput: args.searchInput,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CategoriesPage(),
      );
    },
    ClientLayout.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.ClientLayout(),
      );
    },
    ClinicRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ClinicPage(),
      );
    },
    ClinicTab.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ClinicTabPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.DashboardPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.HomePage(),
      );
    },
    HomeTab.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeTabPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.LoginPage(),
      );
    },
    MakeAppointmentRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.MakeAppointmentPage(),
      );
    },
    MyPetsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.MyPetsPage(),
      );
    },
    PersonalInformationRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.PersonalInformationPage(),
      );
    },
    PetDetailsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.PetDetailsPage(),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailsRouteArgs>(
          orElse: () =>
              ProductDetailsRouteArgs(productId: pathParams.getInt('id')));
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.ProductDetailsPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i18.ProductsPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i19.ProfilePage(),
      );
    },
    ProfileTab.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ProfileTabPage(),
      );
    },
    RegisterAddPetsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.RegisterAddPetsPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.RegisterPage(),
      );
    },
    RegisterVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterVerificationRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i22.RegisterVerificationPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    ShopCategorySubcategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<ShopCategorySubcategoriesRouteArgs>();
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i23.ShopCategorySubcategoriesPage(
          key: args.key,
          categoryId: args.categoryId,
          categoryPhoto: args.categoryPhoto,
          categoryName: args.categoryName,
        ),
      );
    },
    ShopRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i24.ShopPage(),
      );
    },
    ShopTab.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ShopTabPage(),
      );
    },
    SubcategoriesRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.SubcategoriesPage(),
      );
    },
    UserAppointmentsRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.UserAppointmentsPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i28.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i27.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AdminLayout]
class AdminLayout extends _i28.PageRouteInfo<void> {
  const AdminLayout({List<_i28.PageRouteInfo>? children})
      : super(
          AdminLayout.name,
          initialChildren: children,
        );

  static const String name = 'AdminLayout';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AdminOutletPage]
class AdminOutlet extends _i28.PageRouteInfo<void> {
  const AdminOutlet({List<_i28.PageRouteInfo>? children})
      : super(
          AdminOutlet.name,
          initialChildren: children,
        );

  static const String name = 'AdminOutlet';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AppointmentsPage]
class AppointmentsRoute extends _i28.PageRouteInfo<void> {
  const AppointmentsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          AppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BrandsPage]
class BrandsRoute extends _i28.PageRouteInfo<void> {
  const BrandsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          BrandsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrandsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CartPage]
class CartRoute extends _i28.PageRouteInfo<void> {
  const CartRoute({List<_i28.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CatalogPage]
class CatalogRoute extends _i28.PageRouteInfo<CatalogRouteArgs> {
  CatalogRoute({
    _i29.Key? key,
    int? categoryId,
    int? subcategoryId,
    String? categoryPhoto,
    String? categoryName,
    String? subcategoryName,
    String? searchInput,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          CatalogRoute.name,
          args: CatalogRouteArgs(
            key: key,
            categoryId: categoryId,
            subcategoryId: subcategoryId,
            categoryPhoto: categoryPhoto,
            categoryName: categoryName,
            subcategoryName: subcategoryName,
            searchInput: searchInput,
          ),
          rawPathParams: {
            'categoryId': categoryId,
            'subcategoryId': subcategoryId,
          },
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const _i28.PageInfo<CatalogRouteArgs> page =
      _i28.PageInfo<CatalogRouteArgs>(name);
}

class CatalogRouteArgs {
  const CatalogRouteArgs({
    this.key,
    this.categoryId,
    this.subcategoryId,
    this.categoryPhoto,
    this.categoryName,
    this.subcategoryName,
    this.searchInput,
  });

  final _i29.Key? key;

  final int? categoryId;

  final int? subcategoryId;

  final String? categoryPhoto;

  final String? categoryName;

  final String? subcategoryName;

  final String? searchInput;

  @override
  String toString() {
    return 'CatalogRouteArgs{key: $key, categoryId: $categoryId, subcategoryId: $subcategoryId, categoryPhoto: $categoryPhoto, categoryName: $categoryName, subcategoryName: $subcategoryName, searchInput: $searchInput}';
  }
}

/// generated route for
/// [_i7.CategoriesPage]
class CategoriesRoute extends _i28.PageRouteInfo<void> {
  const CategoriesRoute({List<_i28.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i8.ClientLayout]
class ClientLayout extends _i28.PageRouteInfo<void> {
  const ClientLayout({List<_i28.PageRouteInfo>? children})
      : super(
          ClientLayout.name,
          initialChildren: children,
        );

  static const String name = 'ClientLayout';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ClinicPage]
class ClinicRoute extends _i28.PageRouteInfo<void> {
  const ClinicRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ClinicRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClinicRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ClinicTabPage]
class ClinicTab extends _i28.PageRouteInfo<void> {
  const ClinicTab({List<_i28.PageRouteInfo>? children})
      : super(
          ClinicTab.name,
          initialChildren: children,
        );

  static const String name = 'ClinicTab';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i10.DashboardPage]
class DashboardRoute extends _i28.PageRouteInfo<void> {
  const DashboardRoute({List<_i28.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i11.HomePage]
class HomeRoute extends _i28.PageRouteInfo<void> {
  const HomeRoute({List<_i28.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeTabPage]
class HomeTab extends _i28.PageRouteInfo<void> {
  const HomeTab({List<_i28.PageRouteInfo>? children})
      : super(
          HomeTab.name,
          initialChildren: children,
        );

  static const String name = 'HomeTab';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i12.LoginPage]
class LoginRoute extends _i28.PageRouteInfo<void> {
  const LoginRoute({List<_i28.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i13.MakeAppointmentPage]
class MakeAppointmentRoute extends _i28.PageRouteInfo<void> {
  const MakeAppointmentRoute({List<_i28.PageRouteInfo>? children})
      : super(
          MakeAppointmentRoute.name,
          initialChildren: children,
        );

  static const String name = 'MakeAppointmentRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i14.MyPetsPage]
class MyPetsRoute extends _i28.PageRouteInfo<void> {
  const MyPetsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          MyPetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyPetsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i15.PersonalInformationPage]
class PersonalInformationRoute extends _i28.PageRouteInfo<void> {
  const PersonalInformationRoute({List<_i28.PageRouteInfo>? children})
      : super(
          PersonalInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PersonalInformationRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i16.PetDetailsPage]
class PetDetailsRoute extends _i28.PageRouteInfo<void> {
  const PetDetailsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          PetDetailsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PetDetailsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i17.ProductDetailsPage]
class ProductDetailsRoute extends _i28.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i29.Key? key,
    required int productId,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'id': productId},
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static const _i28.PageInfo<ProductDetailsRouteArgs> page =
      _i28.PageInfo<ProductDetailsRouteArgs>(name);
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.productId,
  });

  final _i29.Key? key;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i18.ProductsPage]
class ProductsRoute extends _i28.PageRouteInfo<void> {
  const ProductsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i19.ProfilePage]
class ProfileRoute extends _i28.PageRouteInfo<void> {
  const ProfileRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ProfileTabPage]
class ProfileTab extends _i28.PageRouteInfo<void> {
  const ProfileTab({List<_i28.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i20.RegisterAddPetsPage]
class RegisterAddPetsRoute extends _i28.PageRouteInfo<void> {
  const RegisterAddPetsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          RegisterAddPetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterAddPetsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i21.RegisterPage]
class RegisterRoute extends _i28.PageRouteInfo<void> {
  const RegisterRoute({List<_i28.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i22.RegisterVerificationPage]
class RegisterVerificationRoute
    extends _i28.PageRouteInfo<RegisterVerificationRouteArgs> {
  RegisterVerificationRoute({
    _i29.Key? key,
    required Map<String, dynamic> user,
    List<_i28.PageRouteInfo>? children,
  }) : super(
          RegisterVerificationRoute.name,
          args: RegisterVerificationRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterVerificationRoute';

  static const _i28.PageInfo<RegisterVerificationRouteArgs> page =
      _i28.PageInfo<RegisterVerificationRouteArgs>(name);
}

class RegisterVerificationRouteArgs {
  const RegisterVerificationRouteArgs({
    this.key,
    required this.user,
  });

  final _i29.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'RegisterVerificationRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i23.ShopCategorySubcategoriesPage]
class ShopCategorySubcategoriesRoute
    extends _i28.PageRouteInfo<ShopCategorySubcategoriesRouteArgs> {
  ShopCategorySubcategoriesRoute({
    _i29.Key? key,
    required int categoryId,
    required String categoryPhoto,
    required String categoryName,
    List<_i28.PageRouteInfo>? children,
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

  static const _i28.PageInfo<ShopCategorySubcategoriesRouteArgs> page =
      _i28.PageInfo<ShopCategorySubcategoriesRouteArgs>(name);
}

class ShopCategorySubcategoriesRouteArgs {
  const ShopCategorySubcategoriesRouteArgs({
    this.key,
    required this.categoryId,
    required this.categoryPhoto,
    required this.categoryName,
  });

  final _i29.Key? key;

  final int categoryId;

  final String categoryPhoto;

  final String categoryName;

  @override
  String toString() {
    return 'ShopCategorySubcategoriesRouteArgs{key: $key, categoryId: $categoryId, categoryPhoto: $categoryPhoto, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i24.ShopPage]
class ShopRoute extends _i28.PageRouteInfo<void> {
  const ShopRoute({List<_i28.PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ShopTabPage]
class ShopTab extends _i28.PageRouteInfo<void> {
  const ShopTab({List<_i28.PageRouteInfo>? children})
      : super(
          ShopTab.name,
          initialChildren: children,
        );

  static const String name = 'ShopTab';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i25.SubcategoriesPage]
class SubcategoriesRoute extends _i28.PageRouteInfo<void> {
  const SubcategoriesRoute({List<_i28.PageRouteInfo>? children})
      : super(
          SubcategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubcategoriesRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i26.UserAppointmentsPage]
class UserAppointmentsRoute extends _i28.PageRouteInfo<void> {
  const UserAppointmentsRoute({List<_i28.PageRouteInfo>? children})
      : super(
          UserAppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAppointmentsRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}

/// generated route for
/// [_i27.WelcomePage]
class WelcomeRoute extends _i28.PageRouteInfo<void> {
  const WelcomeRoute({List<_i28.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i28.PageInfo<void> page = _i28.PageInfo<void>(name);
}
