import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/untitled.dart';

void main() {
  const MethodChannel channel = MethodChannel('untitled');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Untitled.platformVersion, '42');
  });
}
