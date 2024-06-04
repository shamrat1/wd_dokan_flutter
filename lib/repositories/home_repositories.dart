import 'package:dokan/models/product.dart';
import 'package:dokan/utils/http/http_client.dart';
import 'package:flutter/services.dart';

class HomeRepositories {
  final THttpHelper _helper = THttpHelper();

  Future<List<Product>> getHomeData() async {
    final String response =
        await rootBundle.loadString('assets/home_response.json');
    return productFromJson(response);
  }
}
