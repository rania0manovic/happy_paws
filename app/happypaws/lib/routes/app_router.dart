import 'package:auto_route/auto_route.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/main.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: "/welcome",
            page: WelcomeRoute.page,
            initial: platformInfo.isAppOS()),
        AutoRoute(
          path: "/register",
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: RegisterVerificationRoute.page,
        ),
        AutoRoute(
          page: RegisterAddPetsRoute.page,
        ),
        AutoRoute(
          path: "/login",
          page: LoginRoute.page,
        ),
        AutoRoute(page: ClientLayout.page, guards: [
          AuthGuardMobile()
        ], children: [
          AutoRoute(
              path: 'home',
              page: HomeTab.page,
              children: [AutoRoute(path: '', page: HomeRoute.page)]),
          AutoRoute(path: "clinic", page: ClinicTab.page, children: [
            AutoRoute(path: '', page: ClinicRoute.page),
            AutoRoute(path: 'appointments', page: UserAppointmentsRoute.page),
            AutoRoute(path: 'make-appointment', page: MakeAppointmentRoute.page)
          ]),
          AutoRoute(path: "shop", page: ShopTab.page, children: [
            AutoRoute(path: '', page: ShopRoute.page),
            AutoRoute(
              path: '',
              page: CartRoute.page,
            ),
            AutoRoute(
                path: 'category/:id',
                page: ShopCategorySubcategoriesRoute.page),
            AutoRoute(
                path: "products/:categoryId/:subcategoryId",
                page: CatalogRoute.page),
            AutoRoute(path: "product/:id", page: ProductDetailsRoute.page),
             AutoRoute(
              path: 'checkout',
              page: CheckoutRoute.page,
            ),
             AutoRoute(path: 'order-history', page: OrderHistoryRoute.page),
            AutoRoute(path: 'order-details', page: OrderDetailsRoute.page),
          ]),
          AutoRoute(path: "profile", page: ProfileTab.page, children: [
            AutoRoute(path: '', page: ProfileRoute.page),
            AutoRoute(
                path: 'personalInformation',
                page: PersonalInformationRoute.page),
            AutoRoute(path: 'my-pets', page: MyPetsRoute.page),
            AutoRoute(path: 'pet-details', page: PetDetailsRoute.page),
           

          ]),
        ]),
        AutoRoute(
            path: '/admin/login',
            page: LoginDesktopRoute.page,
            initial: platformInfo.isDesktopOS()),
        AutoRoute(
            path: "/admin",
            guards: [AuthGuardDesktop()],
            page: AdminLayout.page,
            children: [
              AutoRoute(path: 'dashboard', page: DashboardRoute.page, initial: true),
              AutoRoute(path: 'appointments', page: AppointmentsRoute.page),
              AutoRoute(path: 'patients', page: PatientsRoute.page),
              AutoRoute(path: 'employees', page: EmployeesRoute.page),
              AutoRoute(path: 'products', page: ProductsRoute.page),
              AutoRoute(
                  path: 'settings/product-categories',
                  page: CategoriesRoute.page),
              AutoRoute(
                  path: 'settings/product-subcategories',
                  page: SubcategoriesRoute.page),
              AutoRoute(path: 'settings/brands', page: BrandsRoute.page),
              AutoRoute(path: 'settings/pet-types', page: PetTypesRoute.page),
              AutoRoute(path: 'settings/pet-breeds', page: PetBreedsRoute.page),


            ]),
      ];
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'ClinicTab')
class ClinicTabPage extends AutoRouter {
  const ClinicTabPage({super.key});
}

@RoutePage(name: 'ShopTab')
class ShopTabPage extends AutoRouter {
  const ShopTabPage({super.key});
}

@RoutePage(name: 'ProfileTab')
class ProfileTabPage extends AutoRouter {
  const ProfileTabPage({super.key});
}

@RoutePage(name: 'AdminOutlet')
class AdminOutletPage extends AutoRouter {
  const AdminOutletPage({super.key});
}

class AuthGuardDesktop extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    var user = await AuthService().getCurrentUser();
    if (user != null &&
        (user["Role"] == 'Admin' || user['Role'] == 'Employee')) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginDesktopRoute());
    }
  }
}

class AuthGuardMobile extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
