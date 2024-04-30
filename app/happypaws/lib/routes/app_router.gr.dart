// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i43;

import 'package:auto_route/auto_route.dart' as _i40;
import 'package:flutter/cupertino.dart' as _i42;
import 'package:flutter/material.dart' as _i41;
import 'package:happypaws/common/layouts/admin_layout.dart' as _i1;
import 'package:happypaws/common/layouts/client_layout.dart' as _i9;
import 'package:happypaws/desktop/pages/appointments_page.dart' as _i3;
import 'package:happypaws/desktop/pages/brands_page.dart' as _i4;
import 'package:happypaws/desktop/pages/dashboard_page.dart' as _i11;
import 'package:happypaws/desktop/pages/employees_page.dart' as _i13;
import 'package:happypaws/desktop/pages/inventory_page.dart' as _i15;
import 'package:happypaws/desktop/pages/login_desktop_page.dart' as _i16;
import 'package:happypaws/desktop/pages/orders_page.dart' as _i22;
import 'package:happypaws/desktop/pages/patients_page.dart' as _i23;
import 'package:happypaws/desktop/pages/pet_breeds_page.dart' as _i26;
import 'package:happypaws/desktop/pages/pet_types_page.dart' as _i28;
import 'package:happypaws/desktop/pages/product_categories_page.dart' as _i7;
import 'package:happypaws/desktop/pages/product_subcategories_page.dart'
    as _i37;
import 'package:happypaws/desktop/pages/products_page.dart' as _i30;
import 'package:happypaws/mobile/pages/appointments_page.dart' as _i38;
import 'package:happypaws/mobile/pages/cart_page.dart' as _i5;
import 'package:happypaws/mobile/pages/catalog_page.dart' as _i6;
import 'package:happypaws/mobile/pages/checkout_page.dart' as _i8;
import 'package:happypaws/mobile/pages/clinic_page.dart' as _i10;
import 'package:happypaws/mobile/pages/donate_page.dart' as _i12;
import 'package:happypaws/mobile/pages/home_page.dart' as _i14;
import 'package:happypaws/mobile/pages/login_page.dart' as _i17;
import 'package:happypaws/mobile/pages/make_appointment_page.dart' as _i18;
import 'package:happypaws/mobile/pages/my_pets_page.dart' as _i19;
import 'package:happypaws/mobile/pages/order_details_page.dart' as _i20;
import 'package:happypaws/mobile/pages/order_history_page.dart' as _i21;
import 'package:happypaws/mobile/pages/paypal_donations_page.dart' as _i24;
import 'package:happypaws/mobile/pages/personal_info_page.dart' as _i25;
import 'package:happypaws/mobile/pages/pet_details_page.dart' as _i27;
import 'package:happypaws/mobile/pages/product_details_page.dart' as _i29;
import 'package:happypaws/mobile/pages/profile_page.dart' as _i31;
import 'package:happypaws/mobile/pages/register_add_pets_page.dart' as _i32;
import 'package:happypaws/mobile/pages/register_page.dart' as _i33;
import 'package:happypaws/mobile/pages/register_page_verification.dart' as _i34;
import 'package:happypaws/mobile/pages/shop_category_subcategories_page.dart'
    as _i35;
import 'package:happypaws/mobile/pages/shop_page.dart' as _i36;
import 'package:happypaws/mobile/pages/welcome_page.dart' as _i39;
import 'package:happypaws/routes/app_router.dart' as _i2;

abstract class $AppRouter extends _i40.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i40.PageFactory> pagesMap = {
    AdminLayout.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AdminLayout(),
      );
    },
    AdminOutlet.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AdminOutletPage(),
      );
    },
    AppointmentsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AppointmentsPage(),
      );
    },
    BrandsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.BrandsPage(),
      );
    },
    CartRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
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
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.CatalogPage(
          key: args.key,
          categoryId: args.categoryId,
          subcategoryId: args.subcategoryId,
          categoryPhoto: args.categoryPhoto,
          categoryName: args.categoryName,
          subcategoryName: args.subcategoryName,
          searchInput: args.searchInput,
          isShowingFavourites: args.isShowingFavourites,
        ),
      );
    },
    CategoriesRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.CategoriesPage(),
      );
    },
    CheckoutRoute.name: (routeData) {
      final args = routeData.argsAs<CheckoutRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.CheckoutPage(
          key: args.key,
          total: args.total,
          products: args.products,
        ),
      );
    },
    ClientLayout.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ClientLayout(),
      );
    },
    ClinicRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ClinicPage(),
      );
    },
    ClinicTab.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ClinicTabPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.DashboardPage(),
      );
    },
    DonateRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.DonatePage(),
      );
    },
    EmployeesRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.EmployeesPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.HomePage(),
      );
    },
    HomeTab.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeTabPage(),
      );
    },
    InventoryRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.InventoryPage(),
      );
    },
    LoginDesktopRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.LoginDesktopPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.LoginPage(),
      );
    },
    MakeAppointmentRoute.name: (routeData) {
      final args = routeData.argsAs<MakeAppointmentRouteArgs>(
          orElse: () => const MakeAppointmentRouteArgs());
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i18.MakeAppointmentPage(
          key: args.key,
          data: args.data,
        ),
      );
    },
    MyPetsRoute.name: (routeData) {
      final args = routeData.argsAs<MyPetsRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i19.MyPetsPage(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i20.OrderDetailsPage(
          key: args.key,
          data: args.data,
        ),
      );
    },
    OrderHistoryRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.OrderHistoryPage(),
      );
    },
    OrdersRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i22.OrdersPage(),
      );
    },
    PatientsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i23.PatientsPage(),
      );
    },
    PaypalDonationsRoute.name: (routeData) {
      final args = routeData.argsAs<PaypalDonationsRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i24.PaypalDonationsPage(
          key: args.key,
          total: args.total,
          onSuccess: args.onSuccess,
        ),
      );
    },
    PersonalInformationRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i25.PersonalInformationPage(),
      );
    },
    PetBreedsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i26.PetBreedsPage(),
      );
    },
    PetDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PetDetailsRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i27.PetDetailsPage(
          key: args.key,
          userId: args.userId,
          petId: args.petId,
          onChangedData: args.onChangedData,
        ),
      );
    },
    PetTypesRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i28.PetTypesPage(),
      );
    },
    ProductDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProductDetailsRouteArgs>(
          orElse: () =>
              ProductDetailsRouteArgs(productId: pathParams.getInt('id')));
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i29.ProductDetailsPage(
          key: args.key,
          productId: args.productId,
        ),
      );
    },
    ProductsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i30.ProductsPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i31.ProfilePage(),
      );
    },
    ProfileTab.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ProfileTabPage(),
      );
    },
    RegisterAddPetsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i32.RegisterAddPetsPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i33.RegisterPage(),
      );
    },
    RegisterVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterVerificationRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i34.RegisterVerificationPage(
          key: args.key,
          user: args.user,
        ),
      );
    },
    ShopCategorySubcategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<ShopCategorySubcategoriesRouteArgs>();
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i35.ShopCategorySubcategoriesPage(
          key: args.key,
          categoryId: args.categoryId,
          categoryPhoto: args.categoryPhoto,
          categoryName: args.categoryName,
        ),
      );
    },
    ShopRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i36.ShopPage(),
      );
    },
    ShopTab.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ShopTabPage(),
      );
    },
    SubcategoriesRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i37.SubcategoriesPage(),
      );
    },
    UserAppointmentsRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i38.UserAppointmentsPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i40.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i39.WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AdminLayout]
class AdminLayout extends _i40.PageRouteInfo<void> {
  const AdminLayout({List<_i40.PageRouteInfo>? children})
      : super(
          AdminLayout.name,
          initialChildren: children,
        );

  static const String name = 'AdminLayout';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AdminOutletPage]
class AdminOutlet extends _i40.PageRouteInfo<void> {
  const AdminOutlet({List<_i40.PageRouteInfo>? children})
      : super(
          AdminOutlet.name,
          initialChildren: children,
        );

  static const String name = 'AdminOutlet';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AppointmentsPage]
class AppointmentsRoute extends _i40.PageRouteInfo<void> {
  const AppointmentsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          AppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i4.BrandsPage]
class BrandsRoute extends _i40.PageRouteInfo<void> {
  const BrandsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          BrandsRoute.name,
          initialChildren: children,
        );

  static const String name = 'BrandsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i5.CartPage]
class CartRoute extends _i40.PageRouteInfo<void> {
  const CartRoute({List<_i40.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i6.CatalogPage]
class CatalogRoute extends _i40.PageRouteInfo<CatalogRouteArgs> {
  CatalogRoute({
    _i41.Key? key,
    int? categoryId,
    int? subcategoryId,
    String? categoryPhoto,
    String? categoryName,
    String? subcategoryName,
    String? searchInput,
    bool? isShowingFavourites,
    List<_i40.PageRouteInfo>? children,
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
            isShowingFavourites: isShowingFavourites,
          ),
          rawPathParams: {
            'categoryId': categoryId,
            'subcategoryId': subcategoryId,
          },
          initialChildren: children,
        );

  static const String name = 'CatalogRoute';

  static const _i40.PageInfo<CatalogRouteArgs> page =
      _i40.PageInfo<CatalogRouteArgs>(name);
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
    this.isShowingFavourites,
  });

  final _i41.Key? key;

  final int? categoryId;

  final int? subcategoryId;

  final String? categoryPhoto;

  final String? categoryName;

  final String? subcategoryName;

  final String? searchInput;

  final bool? isShowingFavourites;

  @override
  String toString() {
    return 'CatalogRouteArgs{key: $key, categoryId: $categoryId, subcategoryId: $subcategoryId, categoryPhoto: $categoryPhoto, categoryName: $categoryName, subcategoryName: $subcategoryName, searchInput: $searchInput, isShowingFavourites: $isShowingFavourites}';
  }
}

/// generated route for
/// [_i7.CategoriesPage]
class CategoriesRoute extends _i40.PageRouteInfo<void> {
  const CategoriesRoute({List<_i40.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i8.CheckoutPage]
class CheckoutRoute extends _i40.PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    _i42.Key? key,
    required String total,
    required Map<String, dynamic> products,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          CheckoutRoute.name,
          args: CheckoutRouteArgs(
            key: key,
            total: total,
            products: products,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static const _i40.PageInfo<CheckoutRouteArgs> page =
      _i40.PageInfo<CheckoutRouteArgs>(name);
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.total,
    required this.products,
  });

  final _i42.Key? key;

  final String total;

  final Map<String, dynamic> products;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, total: $total, products: $products}';
  }
}

/// generated route for
/// [_i9.ClientLayout]
class ClientLayout extends _i40.PageRouteInfo<void> {
  const ClientLayout({List<_i40.PageRouteInfo>? children})
      : super(
          ClientLayout.name,
          initialChildren: children,
        );

  static const String name = 'ClientLayout';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ClinicPage]
class ClinicRoute extends _i40.PageRouteInfo<void> {
  const ClinicRoute({List<_i40.PageRouteInfo>? children})
      : super(
          ClinicRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClinicRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ClinicTabPage]
class ClinicTab extends _i40.PageRouteInfo<void> {
  const ClinicTab({List<_i40.PageRouteInfo>? children})
      : super(
          ClinicTab.name,
          initialChildren: children,
        );

  static const String name = 'ClinicTab';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i11.DashboardPage]
class DashboardRoute extends _i40.PageRouteInfo<void> {
  const DashboardRoute({List<_i40.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i12.DonatePage]
class DonateRoute extends _i40.PageRouteInfo<void> {
  const DonateRoute({List<_i40.PageRouteInfo>? children})
      : super(
          DonateRoute.name,
          initialChildren: children,
        );

  static const String name = 'DonateRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i13.EmployeesPage]
class EmployeesRoute extends _i40.PageRouteInfo<void> {
  const EmployeesRoute({List<_i40.PageRouteInfo>? children})
      : super(
          EmployeesRoute.name,
          initialChildren: children,
        );

  static const String name = 'EmployeesRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i14.HomePage]
class HomeRoute extends _i40.PageRouteInfo<void> {
  const HomeRoute({List<_i40.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomeTabPage]
class HomeTab extends _i40.PageRouteInfo<void> {
  const HomeTab({List<_i40.PageRouteInfo>? children})
      : super(
          HomeTab.name,
          initialChildren: children,
        );

  static const String name = 'HomeTab';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i15.InventoryPage]
class InventoryRoute extends _i40.PageRouteInfo<void> {
  const InventoryRoute({List<_i40.PageRouteInfo>? children})
      : super(
          InventoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i16.LoginDesktopPage]
class LoginDesktopRoute extends _i40.PageRouteInfo<void> {
  const LoginDesktopRoute({List<_i40.PageRouteInfo>? children})
      : super(
          LoginDesktopRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginDesktopRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i17.LoginPage]
class LoginRoute extends _i40.PageRouteInfo<void> {
  const LoginRoute({List<_i40.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i18.MakeAppointmentPage]
class MakeAppointmentRoute
    extends _i40.PageRouteInfo<MakeAppointmentRouteArgs> {
  MakeAppointmentRoute({
    _i41.Key? key,
    Map<String, dynamic>? data,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          MakeAppointmentRoute.name,
          args: MakeAppointmentRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'MakeAppointmentRoute';

  static const _i40.PageInfo<MakeAppointmentRouteArgs> page =
      _i40.PageInfo<MakeAppointmentRouteArgs>(name);
}

class MakeAppointmentRouteArgs {
  const MakeAppointmentRouteArgs({
    this.key,
    this.data,
  });

  final _i41.Key? key;

  final Map<String, dynamic>? data;

  @override
  String toString() {
    return 'MakeAppointmentRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i19.MyPetsPage]
class MyPetsRoute extends _i40.PageRouteInfo<MyPetsRouteArgs> {
  MyPetsRoute({
    _i41.Key? key,
    required String userId,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          MyPetsRoute.name,
          args: MyPetsRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'MyPetsRoute';

  static const _i40.PageInfo<MyPetsRouteArgs> page =
      _i40.PageInfo<MyPetsRouteArgs>(name);
}

class MyPetsRouteArgs {
  const MyPetsRouteArgs({
    this.key,
    required this.userId,
  });

  final _i41.Key? key;

  final String userId;

  @override
  String toString() {
    return 'MyPetsRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i20.OrderDetailsPage]
class OrderDetailsRoute extends _i40.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    _i41.Key? key,
    required Map<String, dynamic> data,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const _i40.PageInfo<OrderDetailsRouteArgs> page =
      _i40.PageInfo<OrderDetailsRouteArgs>(name);
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({
    this.key,
    required this.data,
  });

  final _i41.Key? key;

  final Map<String, dynamic> data;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i21.OrderHistoryPage]
class OrderHistoryRoute extends _i40.PageRouteInfo<void> {
  const OrderHistoryRoute({List<_i40.PageRouteInfo>? children})
      : super(
          OrderHistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderHistoryRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i22.OrdersPage]
class OrdersRoute extends _i40.PageRouteInfo<void> {
  const OrdersRoute({List<_i40.PageRouteInfo>? children})
      : super(
          OrdersRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrdersRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i23.PatientsPage]
class PatientsRoute extends _i40.PageRouteInfo<void> {
  const PatientsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          PatientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PatientsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i24.PaypalDonationsPage]
class PaypalDonationsRoute
    extends _i40.PageRouteInfo<PaypalDonationsRouteArgs> {
  PaypalDonationsRoute({
    _i41.Key? key,
    required String total,
    required void Function(dynamic) onSuccess,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          PaypalDonationsRoute.name,
          args: PaypalDonationsRouteArgs(
            key: key,
            total: total,
            onSuccess: onSuccess,
          ),
          initialChildren: children,
        );

  static const String name = 'PaypalDonationsRoute';

  static const _i40.PageInfo<PaypalDonationsRouteArgs> page =
      _i40.PageInfo<PaypalDonationsRouteArgs>(name);
}

class PaypalDonationsRouteArgs {
  const PaypalDonationsRouteArgs({
    this.key,
    required this.total,
    required this.onSuccess,
  });

  final _i41.Key? key;

  final String total;

  final void Function(dynamic) onSuccess;

  @override
  String toString() {
    return 'PaypalDonationsRouteArgs{key: $key, total: $total, onSuccess: $onSuccess}';
  }
}

/// generated route for
/// [_i25.PersonalInformationPage]
class PersonalInformationRoute extends _i40.PageRouteInfo<void> {
  const PersonalInformationRoute({List<_i40.PageRouteInfo>? children})
      : super(
          PersonalInformationRoute.name,
          initialChildren: children,
        );

  static const String name = 'PersonalInformationRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i26.PetBreedsPage]
class PetBreedsRoute extends _i40.PageRouteInfo<void> {
  const PetBreedsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          PetBreedsRoute.name,
          initialChildren: children,
        );

  static const String name = 'PetBreedsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i27.PetDetailsPage]
class PetDetailsRoute extends _i40.PageRouteInfo<PetDetailsRouteArgs> {
  PetDetailsRoute({
    _i41.Key? key,
    required String userId,
    int? petId,
    _i43.Future<void> Function()? onChangedData,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          PetDetailsRoute.name,
          args: PetDetailsRouteArgs(
            key: key,
            userId: userId,
            petId: petId,
            onChangedData: onChangedData,
          ),
          initialChildren: children,
        );

  static const String name = 'PetDetailsRoute';

  static const _i40.PageInfo<PetDetailsRouteArgs> page =
      _i40.PageInfo<PetDetailsRouteArgs>(name);
}

class PetDetailsRouteArgs {
  const PetDetailsRouteArgs({
    this.key,
    required this.userId,
    this.petId,
    this.onChangedData,
  });

  final _i41.Key? key;

  final String userId;

  final int? petId;

  final _i43.Future<void> Function()? onChangedData;

  @override
  String toString() {
    return 'PetDetailsRouteArgs{key: $key, userId: $userId, petId: $petId, onChangedData: $onChangedData}';
  }
}

/// generated route for
/// [_i28.PetTypesPage]
class PetTypesRoute extends _i40.PageRouteInfo<void> {
  const PetTypesRoute({List<_i40.PageRouteInfo>? children})
      : super(
          PetTypesRoute.name,
          initialChildren: children,
        );

  static const String name = 'PetTypesRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i29.ProductDetailsPage]
class ProductDetailsRoute extends _i40.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i41.Key? key,
    required int productId,
    List<_i40.PageRouteInfo>? children,
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

  static const _i40.PageInfo<ProductDetailsRouteArgs> page =
      _i40.PageInfo<ProductDetailsRouteArgs>(name);
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.productId,
  });

  final _i41.Key? key;

  final int productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i30.ProductsPage]
class ProductsRoute extends _i40.PageRouteInfo<void> {
  const ProductsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          ProductsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i31.ProfilePage]
class ProfileRoute extends _i40.PageRouteInfo<void> {
  const ProfileRoute({List<_i40.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ProfileTabPage]
class ProfileTab extends _i40.PageRouteInfo<void> {
  const ProfileTab({List<_i40.PageRouteInfo>? children})
      : super(
          ProfileTab.name,
          initialChildren: children,
        );

  static const String name = 'ProfileTab';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i32.RegisterAddPetsPage]
class RegisterAddPetsRoute extends _i40.PageRouteInfo<void> {
  const RegisterAddPetsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          RegisterAddPetsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterAddPetsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i33.RegisterPage]
class RegisterRoute extends _i40.PageRouteInfo<void> {
  const RegisterRoute({List<_i40.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i34.RegisterVerificationPage]
class RegisterVerificationRoute
    extends _i40.PageRouteInfo<RegisterVerificationRouteArgs> {
  RegisterVerificationRoute({
    _i41.Key? key,
    required Map<String, dynamic> user,
    List<_i40.PageRouteInfo>? children,
  }) : super(
          RegisterVerificationRoute.name,
          args: RegisterVerificationRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterVerificationRoute';

  static const _i40.PageInfo<RegisterVerificationRouteArgs> page =
      _i40.PageInfo<RegisterVerificationRouteArgs>(name);
}

class RegisterVerificationRouteArgs {
  const RegisterVerificationRouteArgs({
    this.key,
    required this.user,
  });

  final _i41.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'RegisterVerificationRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i35.ShopCategorySubcategoriesPage]
class ShopCategorySubcategoriesRoute
    extends _i40.PageRouteInfo<ShopCategorySubcategoriesRouteArgs> {
  ShopCategorySubcategoriesRoute({
    _i41.Key? key,
    required int categoryId,
    required String categoryPhoto,
    required String categoryName,
    List<_i40.PageRouteInfo>? children,
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

  static const _i40.PageInfo<ShopCategorySubcategoriesRouteArgs> page =
      _i40.PageInfo<ShopCategorySubcategoriesRouteArgs>(name);
}

class ShopCategorySubcategoriesRouteArgs {
  const ShopCategorySubcategoriesRouteArgs({
    this.key,
    required this.categoryId,
    required this.categoryPhoto,
    required this.categoryName,
  });

  final _i41.Key? key;

  final int categoryId;

  final String categoryPhoto;

  final String categoryName;

  @override
  String toString() {
    return 'ShopCategorySubcategoriesRouteArgs{key: $key, categoryId: $categoryId, categoryPhoto: $categoryPhoto, categoryName: $categoryName}';
  }
}

/// generated route for
/// [_i36.ShopPage]
class ShopRoute extends _i40.PageRouteInfo<void> {
  const ShopRoute({List<_i40.PageRouteInfo>? children})
      : super(
          ShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShopRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ShopTabPage]
class ShopTab extends _i40.PageRouteInfo<void> {
  const ShopTab({List<_i40.PageRouteInfo>? children})
      : super(
          ShopTab.name,
          initialChildren: children,
        );

  static const String name = 'ShopTab';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i37.SubcategoriesPage]
class SubcategoriesRoute extends _i40.PageRouteInfo<void> {
  const SubcategoriesRoute({List<_i40.PageRouteInfo>? children})
      : super(
          SubcategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubcategoriesRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i38.UserAppointmentsPage]
class UserAppointmentsRoute extends _i40.PageRouteInfo<void> {
  const UserAppointmentsRoute({List<_i40.PageRouteInfo>? children})
      : super(
          UserAppointmentsRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserAppointmentsRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}

/// generated route for
/// [_i39.WelcomePage]
class WelcomeRoute extends _i40.PageRouteInfo<void> {
  const WelcomeRoute({List<_i40.PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const _i40.PageInfo<void> page = _i40.PageInfo<void>(name);
}
