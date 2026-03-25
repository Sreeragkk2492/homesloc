// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';
import 'package:homesloc/core/routes/routes.dart';
import 'package:homesloc/screens/auth/sign_in.dart';
import 'package:homesloc/screens/categorie_screen/categorie_screen.dart';
import 'package:homesloc/screens/detailed_view_screen/detailed_view_screen.dart';
import 'package:homesloc/screens/filter_menu_screen/filter_menu_screen.dart';
import 'package:homesloc/screens/home/home_screen.dart';
import 'package:homesloc/screens/payment_screen/payment_screen.dart';
import 'package:homesloc/screens/search_screen/search_screen.dart';

class GetPages {
  static const INITAL = Routes.Home;
  static final routes = [
    GetPage(
      name: Routes.Home,
      page: () => HomeScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.Categorie,
      page: () => const CategorieSreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.DetailedView,
      page: () => const DetailedViewScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.FilterMenu,
      page: () => const FilterMenuScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.Payment,
      page: () => PaymentScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.Search,
      page: () => const SearchScreen(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.Search,
      page: () => SignIn(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: Routes.Search,
      page: () => const SearchScreen(),
      transition: Transition.zoom,
    ),
  ];
}
