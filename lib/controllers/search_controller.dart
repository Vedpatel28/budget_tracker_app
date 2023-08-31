import 'package:budget_tracker_app/controllers/db_helper/db_helper.dart';
import 'package:get/get.dart';

class searchController extends GetxController {
  RxList Search = [].obs;

  isSearch({required String search}) async {
    return await Search(dbHelper.dbhelper.SearchTransaction(remarks: search) as List?);
  }
}
