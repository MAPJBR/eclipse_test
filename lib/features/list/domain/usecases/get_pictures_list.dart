import 'package:dartz/dartz.dart';
import 'package:teste_to_eclipse/features/list/domain/failures/custom_failure.dart';


import '../entities/picture.dart';
import '../repositories/listing_repository_contract.dart';

class GetPicturesList {
  final ListingRepositoryContract _listingRepository;

  GetPicturesList(this._listingRepository);

  Future<Either<CustomFailure, List<Picture>>> call() async {
    return _listingRepository.listPictures();
  }
}
