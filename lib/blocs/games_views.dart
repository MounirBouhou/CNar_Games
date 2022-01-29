import 'package:cnargames/config/wp_config.dart';
import 'package:http/http.dart' as http;
class GamesViews {

  Future sendViewsCount(String id) async {
    final String url = '${WpConfig().webURL}/update-views.php';
    var res = await http.post(Uri.parse(url), body: {
      'Post_id': id,
    });
    if (res.statusCode == 200) {
      print('response body = ' + res.body);
    } else {
      print('response statusCode =  ${res.statusCode}');
    }
  }
}

