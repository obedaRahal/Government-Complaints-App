import '../../databases/cache/cache_helper.dart';
import 'feature_tour_service.dart';

class FeatureTourServiceImpl implements FeatureTourService {
  @override
  bool isTourDone(String key) {
    final v = CacheHelper.getData(key: key);

    if (v is bool) return v;
    if (v is int) return v == 1;
    if (v is String) return v.toLowerCase() == 'true' || v == '1';

    return false;
  }

  @override
  Future<void> markTourDone(String key) async {
    await CacheHelper.saveData(key: key, value: true);
  }
}

