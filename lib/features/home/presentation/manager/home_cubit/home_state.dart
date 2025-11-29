part of 'home_cubit.dart';

enum HomeStatusEnum { initial, loading, success, error }

class HomeState {
  final HomeStatusEnum status;
  final List<ComplaintEntity> complaints;
  final String? message;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final bool isLoadingMore;

  final bool isSearchMode;
  final String searchText;

  bool get canLoadMore => currentPage < lastPage;

  const HomeState({
    this.status = HomeStatusEnum.initial,
    this.complaints = const [],
    this.message,
    this.currentPage = 1,
    this.lastPage = 1,
    this.perPage = 10,
    this.isLoadingMore = false,
    this.isSearchMode = false,
    this.searchText= ''
  });

  HomeState copyWith({
    HomeStatusEnum? status,
    List<ComplaintEntity>? complaints,
    String? message,
    int? currentPage,
    int? lastPage,
    int? perPage,
    bool? isLoadingMore,
    bool? isSearchMode,
    String? searchText,
  }) {
    return HomeState(
      status: status ?? this.status,
      complaints: complaints ?? this.complaints,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSearchMode: isSearchMode ?? this.isSearchMode,
      searchText: searchText ?? this.searchText,

    );
  }
}
