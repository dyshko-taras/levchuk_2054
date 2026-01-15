class Env {
  const Env._();

  static const bool isProd = bool.fromEnvironment('dart.vm.product');
  static bool get isDev => !isProd;
}
