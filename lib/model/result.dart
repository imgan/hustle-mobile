sealed class Result<T> {}

class SuccessState<T> extends Result<T> {
  final T? result;

  SuccessState(this.result);
}

class LoadingState<T> extends Result<T> {}

class EmptyState<T> extends Result<T> {}

class ErrorState<T> extends Result<T> {
  final String? error;

  ErrorState(this.error);
}
