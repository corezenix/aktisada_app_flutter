enum LoadingStatus {
  initial,
  loading,
  success,
  error,
  empty,
  noInternet,
  serverError,
  unauthorized,
  validationError,
}

extension LoadingStatusExtension on LoadingStatus {
  bool get isLoading => this == LoadingStatus.loading;
  bool get isSuccess => this == LoadingStatus.success;
  bool get isError => this == LoadingStatus.error;
  bool get isEmpty => this == LoadingStatus.empty;
  bool get isNoInternet => this == LoadingStatus.noInternet;
  bool get isServerError => this == LoadingStatus.serverError;
  bool get isUnauthorized => this == LoadingStatus.unauthorized;
  bool get isValidationError => this == LoadingStatus.validationError;

  String get displayMessage {
    switch (this) {
      case LoadingStatus.initial:
        return '';
      case LoadingStatus.loading:
        return 'Loading...';
      case LoadingStatus.success:
        return 'Success!';
      case LoadingStatus.error:
        return 'Something went wrong';
      case LoadingStatus.empty:
        return 'No data found';
      case LoadingStatus.noInternet:
        return 'No internet connection';
      case LoadingStatus.serverError:
        return 'Server error. Please try again later.';
      case LoadingStatus.unauthorized:
        return 'Please login again';
      case LoadingStatus.validationError:
        return 'Please check your input';
    }
  }
}
