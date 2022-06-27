import 'package:flutter/material.dart';

enum DrawerItems {
  Salons,
  Professionals,
  Customers,
  Vacancies,
  Promotions,
  RequestLoan,
  RequestTraining,
  PromoteSalon,
  UpgradeSalon,
  ManagementSoftware,
  About,
  Privacy,
  Terms,
}

extension DrawerItemExtension on DrawerItems {
  String get text {
    switch (this) {
      case DrawerItems.Salons:
        return 'Salons';
      case DrawerItems.Professionals:
        return 'Professionals';
      case DrawerItems.Customers:
        return 'Customers';
      case DrawerItems.Vacancies:
        return 'Vacancies';
      case DrawerItems.Promotions:
        return 'Promotions';
      case DrawerItems.RequestLoan:
        return 'Request a Loan';
      case DrawerItems.RequestTraining:
        return 'Request a Training';
      case DrawerItems.PromoteSalon:
        return 'Promote My Salon';
      case DrawerItems.UpgradeSalon:
        return 'Upgrade My Salon';
      case DrawerItems.ManagementSoftware:
        return 'Salon Management Software';
      case DrawerItems.About:
        return 'About';
      case DrawerItems.Privacy:
        return 'Privacy Policy';
      case DrawerItems.Terms:
        return 'Terms & Conditions';
    }
  }

  ImageProvider? get icon {
    // switch (this) {
    //   case DrawerItems.Salons:
    //     return R.svg.ic_salons(width: 27, height: 25);
    //   case DrawerItems.Professionals:
    //     return R.svg.ic_professionals(width: 27, height: 25);
    //   case DrawerItems.Customers:
    //     return R.svg.ic_customers(width: 27, height: 25);
    //   case DrawerItems.Vacancies:
    //     return R.svg.ic_vacancies(width: 27, height: 25);
    //   case DrawerItems.Promotions:
    //     return R.svg.ic_promotion(width: 27, height: 25);
    //   case DrawerItems.RequestLoan:
    //     return R.svg.ic_loan(width: 27, height: 25);
    //   case DrawerItems.RequestTraining:
    //     return R.svg.ic_training(width: 27, height: 25);
    //   case DrawerItems.PromoteSalon:
    //     return R.svg.ic_promote(width: 27, height: 25);
    //   case DrawerItems.UpgradeSalon:
    //     return R.svg.ic_upgrade(width: 32, height: 32);
    //   case DrawerItems.ManagementSoftware:
    //     return R.svg.ic_management(width: 27, height: 25);
    //   case DrawerItems.About:
    //   case DrawerItems.Privacy:
    //   case DrawerItems.Terms:
    //   default:
    return null;
    // }
  }
}
