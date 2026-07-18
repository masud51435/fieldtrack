import 'package:flutter_test/flutter_test.dart';
import '../../lib_template/features/sms_console/data/models/cost_breakdown_model.dart';
import '../../lib_template/core/utils/helpers/money_utils.dart';

void main() {
  group('CostBreakdownModel', () {
    test('should parse decimal strings correctly without converting to double', () {
      final json = {
        "currency": "EUR",
        "totalCost": "12.4500",
        "rows": [
          {"provider": "TWILIO", "totalCost": "8.2500", "messageCount": 110}
        ]
      };

      final model = CostBreakdownModel.fromJson(json);

      expect(model.totalCost, "12.4500");
      expect(model.rows.first.totalCost, "8.2500");
      expect(model.totalCost.runtimeType, String);
    });
  });

  group('MoneyUtils', () {
    test('0.0079 * 3 should be exactly 0.0237', () {
      // If we used double: 0.0079 * 3 = 0.023700000000000002
      final result = MoneyUtils.multiply("0.0079", 3);
      expect(result, "0.0237");
    });

    test('0.1500 * 2 should be exactly 0.3000', () {
      final result = MoneyUtils.multiply("0.1500", 2);
      expect(result, "0.3000");
    });
  });
}
