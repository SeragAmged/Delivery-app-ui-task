part of 'search_cubit.dart';

enum SearchStatus {
  initial,
  loading,
  success,
  failure,
}

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.results = const [],
    this.errorMessage,
  });

  final SearchStatus status;
  final List<Product> results;
  final String? errorMessage;

  SearchState copyWith({
    SearchStatus? status,
    List<Product>? results,
    String? errorMessage,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, results, errorMessage];
}
