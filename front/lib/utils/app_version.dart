import 'package:package_info_plus/package_info_plus.dart';

class AppVersion {
  const AppVersion._();

  static Future<String> load() async {
    final info = await PackageInfo.fromPlatform();
    final version = info.version.trim();
    final build = info.buildNumber.trim();
    if (version.isEmpty) return build.isEmpty ? '—' : build;
    if (build.isEmpty) return version;
    return '$version+$build';
  }
}
