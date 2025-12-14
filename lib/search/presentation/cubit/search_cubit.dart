import 'dart:async';
import 'package:delivery_app/core/domain/product.dart';
import 'package:delivery_app/search/domain/search_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'search_state.dart';

@Injectable()
class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _searchRepository;
  Timer? _debounce;

  SearchCubit(this._searchRepository) : super(const SearchState());

  void search(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    if (query.isEmpty) {
      emit(state.copyWith(status: SearchStatus.initial, results: []));
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      _executeSearch(query);
    });
  }

  Future<void> _executeSearch(String query) async {
    emit(state.copyWith(status: SearchStatus.loading));
    try {
      final results = await _searchRepository.searchProducts(query);
      emit(state.copyWith(
        status: SearchStatus.success,
        results: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SearchStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
