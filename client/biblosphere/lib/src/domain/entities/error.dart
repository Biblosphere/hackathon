enum AppError { network }

extension AppErrorLocalization on AppError {
  String localize() {
    switch (this) {
      case AppError.network:
        return 'Ошибка сети';
    }
  }
}
