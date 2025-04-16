import 'package:either_dart/either.dart';
import 'package:flower_app/core/error_handling/exceptions/api_exception.dart';
import 'package:flower_app/features/home/domain/entities/product_entity.dart';
import 'package:flower_app/features/search/domain/repositories/search_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepository _repository;

  SearchProductsUseCase(this._repository);

  Future<Either<ApiException, List<ProductEntity>>> call(String query, {String? categoryId}) {
    return _repository.searchProducts(query, categoryId: categoryId);
  }
}
