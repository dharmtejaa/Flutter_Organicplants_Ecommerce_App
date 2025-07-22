import 'package:organicplants/models/all_plants_model.dart';

class CartItem {
  final AllPlantsModel plant;
  int quantity;

  CartItem({required this.plant, this.quantity = 1});
}
