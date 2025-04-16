// features/search/data/repositories/search_repository_impl.dart
import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/search/data/datasources/search_remote_ds_interface.dart';
import 'package:flower_app/features/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDsInterface _remoteDataSource;

  SearchRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ApiException, List<ProductEntity>>> searchProducts(String query, {String? categoryId}) async {
    try {
      final productsModels = await _remoteDataSource.searchProducts(query, categoryId: categoryId);
      
      final productEntities = productsModels.map((product) => ProductEntity(
        id: product.id ?? '',
        title: product.title ?? '',
        description: product.description ?? '',
        price: product.price ?? 0,
        priceAfterDiscount: product.priceAfterDiscount ?? 0,
        images: product.images ?? [],
        imgCover: product.imgCover ?? (product.images?.isNotEmpty == true ? product.images!.first : ''),
      )).toList();
      
      return Right(productEntities);
    } catch (e) {
      final errorMessage = e.toString().contains('success') 
          ? 'No matching products found' 
          : e.toString();
      return Left(ApiException(message: errorMessage));
    }
  }
}