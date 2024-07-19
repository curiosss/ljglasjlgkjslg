import 'package:get_it/get_it.dart';
import 'package:t89/core/storage/storage_hive.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';

import 'features/settings/controllers/settings_controller.dart';

final getIt = GetIt.instance;

setupLocator() async {
  StorageHive storageHive = StorageHive();
  await storageHive.init();
  getIt.registerSingleton(storageHive);

  getIt.registerSingleton(SettingsController());
  await getIt<SettingsController>().init();

  getIt.registerSingleton(ProductController());
  await getIt<ProductController>().init();

  getIt.registerSingleton(ShopController());
  await getIt<ShopController>().init();
}
