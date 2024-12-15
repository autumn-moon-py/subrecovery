import 'dart:convert';

class Trend {
  String trend;
  String image;
  DateTime time;
  Trend(this.trend, this.image, this.time);
  @override
  String toString() {
    Map map = {
      'trend': trend,
      'image': image,
      'time': time.millisecondsSinceEpoch,
    };
    return jsonEncode(map);
  }

  fromString(String json) {
    Map map = jsonDecode(json);
    trend = map['trend'];
    image = map['image'];
    time = DateTime.fromMillisecondsSinceEpoch(map['time']);
  }
}
