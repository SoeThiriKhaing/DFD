import 'package:dailyfairdeal/models/food/fav_cuisine_model.dart';

abstract class IFavouriteCusineRepository {
  Future<List<FavCuisineModel>> getFavouriteCuisine();
}
