enum Env {
  dev,
  pre,
  prd;

  static Env current = dev;
}

extension BaseUrl on Env {
  String get baseUrl {
    switch (this) {
      case Env.dev:
        return 'www.dev-env.com';
      case Env.pre:
        return 'www.pre-env.com';
      case Env.prd:
        return 'www.prd-env.com';
      default:
        return 'www.dev-env.com';
    }
  }
}
