import 'package:auto_route/auto_route.dart';
import 'package:happypaws/common/services/AuthService.dart';
import 'package:happypaws/routes/app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    var user = await AuthService().getCurrentUser();
    if (user != null) {
      if (user['Role'] == "Admin") {
        resolver.next(true);
      } else if (user['Role'] == "Employee") {
        resolver.redirect(const OrdersRoute());
      }
    } else {
      resolver.redirect(const LoginDesktopRoute());
    }
  }
}
