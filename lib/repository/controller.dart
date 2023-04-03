import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Controller extends GetxController {
  List<String>? favourites = [];
  @override
  void onInit() {
    getFavouritesData();
    super.onInit();
  }

  getFavouritesData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    favourites = prefs.getStringList('items');
  }

  onPressFavouriteButton(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (favourites == null) {
      await prefs.setStringList('items', [id.toString()]);
      favourites = prefs.getStringList('items');
    } else {
      favourites!.contains(id) ? favourites!.remove(id) : favourites!.add(id);

      await prefs.setStringList('items', favourites!);
    }
    update();
    print(favourites);
  }
}
