import 'package:http/http.dart' as http;

class NetUtils {
  static Future<String> get(String url, Map<String, dynamic> params) async {
    if (params.isNotEmpty) {
      //拼装参数
      StringBuffer sb = StringBuffer('?');
      params.forEach((key, value) {
        sb.write('$key=$value&');
      });
      //去掉最后一个&
      String paramStr = sb.toString().substring(0, sb.length - 1);
      url += paramStr;
    }
    print('NetUtils : $url');
    Uri getUri = Uri.parse(url);
    http.Response response = await http.get(getUri);
    return response.body;
  }

  static Future<String> post(String url, Map<String, dynamic> params) async {
    Uri postUri = Uri.parse(url);
    http.Response response = await http.post(postUri, body: params);
    return response.body;
  }
}
