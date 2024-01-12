///
///"results": [
//   {
//     "location": {
//       "id": "C23NB62W20TF",
//       "name": "西雅图",
//       "country": "US",
//       "path": "西雅图,华盛顿州,美国",
//       "timezone": "America/Los_Angeles",
//       "timezone_offset": "-07:00"
//     },
//     "now": {
//       "text": "多云", //天气现象文字
//       "code": "4", //天气现象代码
//       "temperature": "14", //温度，单位为c摄氏度或f华氏度
//       "feels_like": "14", //体感温度，单位为c摄氏度或f华氏度
//       "pressure": "1018", //气压，单位为mb百帕或in英寸
//       "humidity": "76", //相对湿度，0~100，单位为百分比
//       "visibility": "16.09", //能见度，单位为km公里或mi英里
//       "wind_direction": "西北", //风向文字
//       "wind_direction_degree": "340", //风向角度，范围0~360，0为正北，90为正东，180为正南，270为正西
//       "wind_speed": "8.05", //风速，单位为km/h公里每小时或mph英里每小时
//       "wind_scale": "2", //风力等级，请参考：http://baike.baidu.com/view/465076.htm
//       "clouds": "90", //云量，单位%，范围0~100，天空被云覆盖的百分比 #目前不支持中国城市#
//       "dew_point": "-12" //露点温度，请参考：http://baike.baidu.com/view/118348.htm #目前不支持中国城市#
//     },
//     "last_update": "2015-09-25T22:45:00-07:00" //数据更新时间（该城市的本地时间）
//   }
// ]
///
import 'package:intl/intl.dart';

class Weather {
  final String cityName;
  final String temperature;
  final String mainCodition;
  final String lastUpdate;
  final String code;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCodition,
      required this.lastUpdate,
      required this.code});

  factory Weather.fromJson(Map<String, dynamic> json) {
    var result = json['results'][0];
    var name = result['location']['name'];
    var temperature = result['now']['temperature'];
    var text = result['now']['text'];
    var time = result['last_update'];
    var code = result['now']['code'];
    DateFormat dateFormat = DateFormat('yyyy年MM月dd日 HH 时 mm 分');
    String formattedDate = dateFormat.format(DateTime.parse(time));
    return Weather(
        cityName: name,
        temperature: temperature,
        mainCodition: text,
        lastUpdate: formattedDate,
        code: code);
  }

  factory Weather.error() {
    return Weather(
        cityName: "获取失败",
        temperature: "null",
        mainCodition: "null",
        lastUpdate: "null",
        code: "-1");
  }

  String getWeatherAnimationJSONPath() {
    // https://seniverse.yuque.com/hyper_data/api_v3/yev2c3
    String value = "default";
    switch (int.parse(code)) {
      case 0:
      case 1:
      case 2:
      case 3:
        value = "sunny";
        break;
      case 34:
      case 35:
      case 36:
        value = "storm";
        break;
      case 4:
      case 32:
      case 33:
        value = "windy";
        break;
      case 11:
        value = "thunder";
        break;
      default:
    }
    print("assets/$value.json");
    return "assets/$value.json";
  }
}
