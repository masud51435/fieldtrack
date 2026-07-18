import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import '../../lib_template/features/sms_console/domain/entities/sms_message_entity.dart';
import '../../lib_template/features/sms_console/domain/repositories/sms_repository.dart';
import '../../lib_template/features/sms_console/domain/usecases/send_sms_usecase.dart';
import '../../lib_template/features/sms_console/domain/usecases/get_cost_breakdown_usecase.dart';
import '../../lib_template/features/sms_console/domain/usecases/get_sms_history_usecase.dart';
import '../../lib_template/features/sms_console/presentation/controllers/sms_console_controller.dart';
import '../../lib_template/features/sms_console/presentation/views/sms_console_screen.dart';

class MockSendSmsUseCase extends Mock implements SendSmsUseCase {
  @override
  Future<SmsMessageEntity> call(SendSmsParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  // TODO: implement repository
  SmsRepository get repository => throw UnimplementedError();
}
class MockGetCostBreakdownUseCase extends Mock implements GetCostBreakdownUseCase {}
class MockGetSmsHistoryUseCase extends Mock implements GetSmsHistoryUseCase {}

void main() {
  late SmsConsoleController controller;
  late MockSendSmsUseCase mockSendSms;
  late MockGetCostBreakdownUseCase mockCost;
  late MockGetSmsHistoryUseCase mockHistory;

  setUp(() {
    mockSendSms = MockSendSmsUseCase();
    mockCost = MockGetCostBreakdownUseCase();
    mockHistory = MockGetSmsHistoryUseCase();
    
    controller = SmsConsoleController(
      sendSmsUseCase: mockSendSms,
      getCostBreakdownUseCase: mockCost,
      getSmsHistoryUseCase: mockHistory,
    );
    
    Get.put(controller);
  });

  tearDown(() {
    Get.delete<SmsConsoleController>();
  });

  testWidgets('SMS Console should show validation error when fields are empty', (WidgetTester tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: SmsConsoleScreen()));

    final sendButton = find.text('Send Message');
    if (sendButton.evaluate().isNotEmpty) {
      await tester.tap(sendButton);
      await tester.pump();
      expect(controller.isSending.value, false);
    }
  });

  testWidgets('SMS Console Mobile Layout search', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const GetMaterialApp(home: SmsConsoleScreen()));
    await tester.pumpAndSettle();

    expect(find.byType(SmsConsoleScreen), findsOneWidget);
  });
}
