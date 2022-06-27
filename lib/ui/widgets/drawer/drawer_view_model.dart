import 'package:easyenglish/core/enums/drawer_items.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class DrawerViewModel extends BaseViewModel {
  final NavigationService _navigationService = GetIt.I.get();

  void onItemClick(DrawerItems item) {}
}
