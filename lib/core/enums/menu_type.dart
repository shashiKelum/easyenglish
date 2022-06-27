enum MenuType { DineIn, DeliveryPickup }

extension MenuTypeExtension on MenuType {
  String get value {
    switch (this) {
      case MenuType.DineIn:
        return 'DineIn';

      case MenuType.DeliveryPickup:
        return 'DeliveryPickup';

      default:
        return 'Unknown';
    }
  }

  String get title {
    switch (this) {
      case MenuType.DeliveryPickup:
        return 'Delivery & Pickup';

      case MenuType.DineIn:
      default:
        return 'Dine In';
    }
  }

  int get id {
    switch (this) {
      case MenuType.DineIn:
        return 1;

      case MenuType.DeliveryPickup:
      default:
        return 2;
    }
  }
}
