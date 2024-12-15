import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../model/user_model.dart';

class ImageViewModel with ChangeNotifier {
  Map get imageMap => _imageMap;
  final user = User();

  Future<void> init() async {
    _imageMap = await user.loadImage(_imageMap);
  }

  void lockImage(String image, {bool no = true}) {
    _imageMap[image] = true;
    notifyListeners();
    user.saveImage(_imageMap);
    if (no) {
      EasyLoading.showToast('已解锁图鉴：$image',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  void lockAllImage() {
    _imageMap.forEach((key, value) {
      if (key != '0') _imageMap[key] = true;
    });
    notifyListeners();
  }

  void lockChapterImage(String chapter) {
    if (chapter.startsWith('番外')) return;
    const chapterToImage = {
      "第一章": "S1",
      "第二章": "S2",
      "第三章": "S3",
      "第四章": "S4",
      "第五章": "S5",
      "第六章": "S6"
    };
    _imageMap.forEach((key, value) {
      if (key.startsWith(chapterToImage[chapter] ?? '')) {
        _imageMap[key] = true;
      }
    });
    notifyListeners();
    user.saveImage(_imageMap);
  }

  List<String> imageList = [
    'S1-01',
    'S1-02',
    'S1-03',
    'S1-04',
    'S1-05',
    'E1-01',
    'E1-02',
    'S2-01',
    'S2-02',
    'S2-03',
    'S2-04',
    'S2-05',
    'S2-06',
    'S2-07',
    'S2-08',
    'E2-01',
    'E2-02',
    'E2-03',
    'E2-04',
    'S3-01',
    'S3-02',
    'S3-03',
    'S3-04',
    'S4-01',
    'S4-02',
    'S4-03',
    'S4-04',
    'S4-05',
    'S4-06',
    'S5-01',
    'S5-02',
    'S5-03',
    'S5-04',
    'S5-05',
    'S5-06',
    'S6-01',
    'S6-02',
    'S6-03',
    'S6-04',
    'S6-05',
    'S6-06',
    'S6-07',
    'W1-01',
    'W1-02',
    'W1-03',
    'W1-04',
    'W1-05',
    'W1-06',
    'W1-07',
    'W1-08',
    'W1-09'
  ];

  ///图鉴解锁
  Map _imageMap = {
    '0': false,
    'E1-01': false,
    'E1-02': false,
    'E1-03': false,
    'E2-01': false,
    'E2-02': false,
    'E2-03': false,
    'E2-04': false,
    'E3-01': false,
    'E3-02': false,
    'E3-03': false,
    'S1-01': false,
    'S1-02': false,
    'S1-03': false,
    'S1-04': false,
    'S1-05': false,
    'S2-01': false,
    'S2-02': false,
    'S2-03': false,
    'S2-04': false,
    'S2-05': false,
    'S2-06': false,
    'S2-07': false,
    'S2-08': false,
    'S3-01': false,
    'S3-02': false,
    'S3-03': false,
    'S3-04': false,
    'S4-01': false,
    'S4-02': false,
    'S4-03': false,
    'S4-04': false,
    'S4-05': false,
    'S4-06': false,
    'S5-01': false,
    'S5-02': false,
    'S5-03': false,
    'S5-04': false,
    'S5-05': false,
    'S5-06': false,
    'S6-01': false,
    'S6-02': false,
    'S6-03': false,
    'S6-04': false,
    'S6-05': false,
    'S6-06': false,
    'S6-07': false,
    'W1-01': false,
    'W1-02': false,
    'W1-03': false,
    'W1-04': false,
    'W1-05': false,
    'W1-06': false,
    'W1-07': false,
    'W1-08': false,
    'W1-09': false
  };
}
