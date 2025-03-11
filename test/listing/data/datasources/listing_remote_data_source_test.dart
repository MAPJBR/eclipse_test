

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:teste_to_eclipse/core/device/network_info.dart';
import 'package:teste_to_eclipse/features/list/data/datasources/listing_remote_data_source.dart';
import 'package:teste_to_eclipse/features/list/data/exceptions/network_exception.dart';


class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockNetworkInfo mockNetworkInfo;

  late Dio dio;
  late ListingRemoteDataSourceContract listingRemoteDataSource;

  setUpAll(() {
    mockNetworkInfo = MockNetworkInfo();
    dio = Dio();

    listingRemoteDataSource = ListingRemoteDataSource(mockNetworkInfo, dio);
  });

  group('tests for [ListingRemoteDataSource.getPictures]', () {
    group('offline tests', () {
      test('check if [NetworkException] is thrown when device is offline', () {
        // Arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        // Act
        // Assert
        expect(listingRemoteDataSource.getPictures(), throwsA(isA<NetworkException>()));
      });
    });

   
  });
}
