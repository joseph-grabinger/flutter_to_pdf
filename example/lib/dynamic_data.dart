import 'package:rfw/rfw.dart';

class DynamicData {
  late Map<String, Object?> data = {};

  final DynamicContent content = DynamicContent();

  void update(String key, Object value) {
    data['data.$key'] = value;
    content.update(key, value);
  }

  DynamicData({
    Map<String, Object?> data = const {},
  }) {
    for (final key in data.keys) {
      this.data['data.$key'] = data[key];
      content.update(key, data[key]!);
    }
  }


  T? v<T extends Object>(Object? obj) {
    return obj is T ? obj : (obj is DataReference ? (data[obj.toString()] as T?) : null);
  }
}