import 'package:test/test.dart';
import '../utils/json_helper.dart';

void main() {
  group('JsonHelper', () {
    test('Encoder une Map en JSON', () {
      final map = {
        "name": "Valisoa",
        "age": 20,
      };

      final json = JsonHelper.encode(map);

      expect(json.contains("Valisoa"), true);
    });

    test('Décoder un JSON', () {
      final json = '{"name":"Valisoa"}';

      final map = JsonHelper.decode(json);

      expect(map["name"], "Valisoa");
    });
  });
}
