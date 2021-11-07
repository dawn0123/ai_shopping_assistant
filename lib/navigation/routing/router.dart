import 'package:aishop/navigation/routing/route_names.dart';
import 'package:aishop/screens/cart/checkout_page.dart';
import 'package:aishop/screens/cart/components/checkoutpayment.dart';
import 'package:aishop/screens/categories/books.dart';
import 'package:aishop/screens/categories/clothes.dart';
import 'package:aishop/screens/categories/kitchen.dart';
import 'package:aishop/screens/categories/shoes.dart';
import 'package:aishop/screens/categories/tech.dart';
import 'package:aishop/screens/delivery/checkoutdelivery.dart';
import 'package:aishop/screens/delivery/first_delivery_page.dart';
import 'package:aishop/screens/homepage/homepage.dart';
import 'package:aishop/screens/invoices/invoices.dart';
import 'package:aishop/screens/login/loginscreen.dart';
import 'package:aishop/screens/past_purchases/pastpurchase.dart';
import 'package:aishop/screens/profile_page/edit_profile.dart';
import 'package:aishop/screens/search/search.dart';
import 'package:aishop/screens/settings/settings.dart';
import 'package:aishop/screens/signup/registerscreen.dart';
import 'package:aishop/screens/verification_page/verifyscreen.dart';
import 'package:aishop/screens/wishlist/wislistscreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print('generateRoute: ${settings.name}');
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomePage());
    case InvoicesRoute:
      return _getPageRoute(InvoicesPage());
    case BooksRoute:
      return _getPageRoute(BooksScreen());
    case KitchenRoute:
      return _getPageRoute(KitchenScreen());
    case LoginRoute:
      return _getPageRoute(LoginScreen());
    // case RegistrationRoute:
    //   return _getPageRoute(RegisterScreen());
    case ClothesRoute:
      return _getPageRoute(ClothesScreen());
    case ShoesRoute:
      return _getPageRoute(ShoesScreen());
    case TechRoute:
      return _getPageRoute(TechScreen());
    case WishlistRoute:
      return _getPageRoute(WishlistPage());
    case ProfileRoute:
      return _getPageRoute(EditProfilePage());
    case PastPurchasesRoute:
      return _getPageRoute(PastPurchase());
    case SearchRoute:
      return _getPageRoute(Search());
    case CheckOutRoute:
      return _getPageRoute(CheckOutPage());
    case SettingsRoute:
      return _getPageRoute(SettingsPage());
    case FirstDeliveryRoute:
      return _getPageRoute(FirstDelivaryPage());
    case CheckOutDeliveryRoute:
      return _getPageRoute(CheckOutDelivery());
     case CheckOutPaymentRoute:
      return _getPageRoute(CheckOutPayment());
      // case VerificationRoute:
      // return _getPageRoute(VerifyScreen());
    // case PageControllerRoute:
    //   return _getPageRoute(AppPagesController());
    default:
      return _getPageRoute(LoginScreen());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
