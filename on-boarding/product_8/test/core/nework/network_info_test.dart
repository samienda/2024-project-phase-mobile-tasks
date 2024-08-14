import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:product_8/core/network/network_info.dart';

import '../../helper/dummy_data/test_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(
    () {
      mockInternetConnectionChecker = MockInternetConnectionChecker();
      networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
    },
  );

  group(
    'isconnected',
    () {
      test(
        'should forward the call to internetconnectionChecker.hasconnection',
        () async {
          final tHasConnectionFuture = Future.value(true);

          when(mockInternetConnectionChecker.hasConnection)
              .thenAnswer((_) => tHasConnectionFuture);

          final result = networkInfoImpl.isConnected;

          verify(mockInternetConnectionChecker.hasConnection);
          expect(result, tHasConnectionFuture);
        },
      );
    },
  );
}
