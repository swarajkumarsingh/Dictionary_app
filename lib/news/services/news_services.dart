import 'package:dictionary/utils/snackbar.dart';
import 'package:share_plus/share_plus.dart';

final newServices = _NewsServices();

class _NewsServices {
  Future<void> shareApp() async {
    try {
      const urlPreview = "https://github.com/swarajkumarsingh/S_Dictionary";
      await Share.share(
          "GaadiDho is an Instant Bike Washing & Shining Subscription Service. GaadhiDho provides monthly subscription for Bike Wash, We are opening our Bike Washing Points on every 5 km to provide instant bike washing service.Free Download it from Google PlayStore  \n\n$urlPreview");
    } catch (e) {
      showSnackBar(msg: "Unable to share, Please try again later.");
    }
  }
}
