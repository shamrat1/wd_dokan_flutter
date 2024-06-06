import 'package:dokan/models/product.dart';
import 'package:flutter/services.dart';

class HomeRepositories {
  Future<List<Product>> getHomeData() async {
    final String response =
        await rootBundle.loadString('assets/home_response.json');
    return productFromJson(response);
  }
}
