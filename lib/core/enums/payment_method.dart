enum PaymentMethod { Cash, Online }

extension PaymentMethodExtension on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.Cash:
        return 'cash';

      case PaymentMethod.Online:
        return 'online';

      default:
        return 'unknown';
    }
  }

  int get value {
    switch (this) {
      case PaymentMethod.Online:
        return 2;

      case PaymentMethod.Cash:
      default:
        return 1;
    }
  }

  String get selector {
    switch (this) {
      case PaymentMethod.Cash:
        return 'Pay by Cash';

      case PaymentMethod.Online:
      default:
        return 'Pay Online';
    }
  }
}
