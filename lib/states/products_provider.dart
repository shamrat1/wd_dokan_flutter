import 'package:dokan/repositories/home_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = FutureProvider.autoDispose((ref) async {
  return await HomeRepositories().getHomeData();
});
