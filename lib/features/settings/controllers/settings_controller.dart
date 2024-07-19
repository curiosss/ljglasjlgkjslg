import 'package:flutter/material.dart';
import 'package:t89/common/utils/file_utils.dart';
import 'package:t89/core/storage/storage_hive.dart';
import 'package:t89/features/products/controller/product_controller.dart';
import 'package:t89/features/settings/models/company_info_model.dart';
import 'package:t89/features/shop/controller/shop_controller.dart';
import 'package:t89/injection_container.dart';

class SettingsController with ChangeNotifier {
  CompanyInfoModel? companyInfo;
  bool isNotificationsOn = true;

  StorageHive storageHive = getIt<StorageHive>();
  bool showOnboarding = true;

  init() async {
    try {
      String? res = storageHive.box?.get('company');
      if (res != null) {
        companyInfo = CompanyInfoModel.fromJson(res);
      }
      isNotificationsOn = storageHive.box?.get('isNotificationOn') ?? true;
      showOnboarding = storageHive.box?.get('showOnboarding') ?? true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  toggleNotification() {
    isNotificationsOn = !isNotificationsOn;
    notifyListeners();
    storageHive.box?.put('isNotificationOn', isNotificationsOn);
  }

  Future<bool> addCompanyInfo(
    String name,
    String path,
  ) async {
    try {
      if (companyInfo?.imagePath != path) {
        path = await saveFile(path, companyInfo?.imagePath);
      }
      companyInfo = CompanyInfoModel(name: name, imagePath: path);
      notifyListeners();
      await storageHive.box?.put('company', companyInfo!.toJson());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  viewOnboarding() {
    storageHive.box?.put('showOnboarding', false);
  }

  Future<bool> deleteProfile() async {
    try {
      getIt<ShopController>().reset();
      getIt<ProductController>().reset();

      showOnboarding = true;
      storageHive.box?.delete('showOnboarding');

      await deleteFile(companyInfo?.imagePath);
      await deleteAllImages();

      companyInfo = null;
      storageHive.box?.delete('company');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
