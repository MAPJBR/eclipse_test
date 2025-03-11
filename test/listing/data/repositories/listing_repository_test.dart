import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teste_to_eclipse/features/list/data/datasources/listing_local_data_source.dart';
import 'package:teste_to_eclipse/features/list/data/datasources/listing_remote_data_source.dart';
import 'package:teste_to_eclipse/features/list/data/exceptions/network_exception.dart';
import 'package:teste_to_eclipse/features/list/data/exceptions/server_exception.dart';
import 'package:teste_to_eclipse/features/list/data/models/picture_model.dart';
import 'package:teste_to_eclipse/features/list/data/repositories/listing_repository.dart';
import 'package:teste_to_eclipse/features/list/domain/entities/picture.dart';
import 'package:teste_to_eclipse/features/list/domain/failures/network_failure.dart';
import 'package:teste_to_eclipse/features/list/domain/failures/server_failure.dart';


class MockListingLocalDataSource extends Mock implements ListingLocalDataSourceContract {}

class MockListingRemoteDataSource extends Mock implements ListingRemoteDataSourceContract {}

void main() {
  late MockListingLocalDataSource mockListingLocalDataSource;
  late MockListingRemoteDataSource mockListingRemoteDataSource;
  late ListingRepository listingRepository;

  setUpAll(() {
    mockListingLocalDataSource = MockListingLocalDataSource();
    mockListingRemoteDataSource = MockListingRemoteDataSource();
    listingRepository = ListingRepository(mockListingLocalDataSource, mockListingRemoteDataSource);
  });

  group('tests for [ListingRepository.listPictures]', () {
    test(
        'check if [NetworkFailure] is returned if no cached data is found and the remote data source fails on loading data',
        () async {
      // Arrange
      when(() => mockListingRemoteDataSource.getPictures()).thenThrow(const NetworkException(''));
      when(() => mockListingLocalDataSource.retrieve()).thenAnswer((_) async => null);
      // Act
      final result = await listingRepository.listPictures();
      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<NetworkFailure>());
    });

    test(
        'check if [ServerFailure] is returned if no cached data is found and the remote data source fails on loading data',
        () async {
      // Arrange
      when(() => mockListingRemoteDataSource.getPictures()).thenThrow(const ServerException(''));
      when(() => mockListingLocalDataSource.retrieve()).thenAnswer((_) async => null);
      // Act
      final result = await listingRepository.listPictures();
      // Assert
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => r), isA<ServerFailure>());
    });

    test(
        'check if [List<Picture>] is returned if cached data is found and the remote data source fails on loading data',
        () async {
      // Arrange
      when(() => mockListingRemoteDataSource.getPictures()).thenThrow(const NetworkException(''));
      when(() => mockListingLocalDataSource.retrieve())
          .thenAnswer((_) async => [const PictureModel('', '', '', '', '', '', '', '', '')]);
      // Act
      final result = await listingRepository.listPictures();
      // Assert
      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<List<Picture>>());
    });

    test(
        'check if [List<Picture>] is returned if cached data is found and the remote data source fails on loading data',
        () async {
      // Arrange
      when(() => mockListingRemoteDataSource.getPictures()).thenThrow(const ServerException(''));
      when(() => mockListingLocalDataSource.retrieve())
          .thenAnswer((_) async => [const PictureModel('', '', '', '', '', '', '', '', '')]);
      // Act
      final result = await listingRepository.listPictures();
      // Assert
      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<List<Picture>>());
    });

    test('check if [List<Picture>] is returned and the data is cached when remote data source load the data', () async {
      // Arrange
      when(() => mockListingRemoteDataSource.getPictures())
          .thenAnswer((_) async => [const PictureModel('', '', '', '', '', '', '', '', '')]);
      when(() => mockListingLocalDataSource.store(any())).thenAnswer((_) async => Future.value);
      // Act
      final result = await listingRepository.listPictures();
      // Assert
      verify(() => mockListingLocalDataSource.store(any())).called(1);
      expect(result.isRight(), true);
      expect(result.fold((l) => l, (r) => r), isA<List<Picture>>());
    });
  });
}
