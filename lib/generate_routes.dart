import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/models.dart';
import 'pages/pages.dart';
import 'state/state.dart';

bool isProtectedRoute(String? routeName) {
  const List<String> protectedRoutes = [
    /// User
    UserProfilePrivate.routeName,
  ];
  return protectedRoutes.contains(routeName);
}

Route<dynamic> generateRoute(RouteSettings settings, BuildContext context) {
  final authNotifier = Provider.of<AuthStateNotifier>(context, listen: false);

  print('authNotifier.isAuthenticated: ${authNotifier.isAuthenticated}');
  print('settings.name: ${settings.name}');
  print('isProtectedRoute(settings.name): ${isProtectedRoute(settings.name)}');
  final List<Item> fakeItems = List.generate(
    10,
    (index) => Item(
      id: index,
      name: 'Item $index',
      description: 'Description of item $index',
      price: 20.0 + index,
      category: 'Category ${index % 3}',
      createdAt: DateTime.now().subtract(Duration(days: index * 5)),
      images: [
        'https://picsum.photos/seed/$index/200/300',
        'https://picsum.photos/seed/${index + 1}/200/300',
        'https://picsum.photos/seed/${index + 2}/200/300',
      ],
    ),
  );

  Widget page = const SplashPage();

  if (!authNotifier.isAuthenticated && isProtectedRoute(settings.name)) {
    page = const SplashPage();
  } else {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());

      /// Auth
      case UserApplicationForm.routeName:
        return MaterialPageRoute(builder: (_) => const UserApplicationForm());
      case LoginPage.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case ForgotPasswordPage.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case LoginPageMagicLink.routeName:
        return MaterialPageRoute(builder: (_) => const LoginPageMagicLink());
      case SignUpPage.routeName:
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      /// Cart
      case CartPage.routeName:
        return MaterialPageRoute(builder: (_) => CartPage(items: fakeItems));

      /// Items
      case ItemsCatalog.routeName:
        return MaterialPageRoute(builder: (_) => const ItemsCatalog());
      case ItemsCatalogAlt.routeName:
        return MaterialPageRoute(
            builder: (_) => ItemsCatalogAlt(items: fakeItems));

      /// User
      case UserProfilePrivate.routeName:
        return MaterialPageRoute(builder: (_) => const UserProfilePrivate());

      /// 404
      default:
        return MaterialPageRoute(builder: (_) => const SplashPage());
    }
  }

  return MaterialPageRoute(builder: (_) => page);
}
