import 'package:flutter_test/flutter_test.dart';

import 'package:iblock/services/history_logging_service.dart';

Future main() async {
  test('insert test', () async {
    var service = HistoryLoggingService();
    service.open();
    int id = await service.insert(HistoryRecord(txhash: '0x123456789', verifierName: 'iBlock', verifierContractAddress: '0x456789123'));
    expect(id, int);
    service.close();
  });
}