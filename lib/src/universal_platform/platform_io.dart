import 'dart:io';

class UniversalPlatform {
  static int get numberOfProcessors => Platform.numberOfProcessors;
  static String get pathSeparator => Platform.pathSeparator;
  static String get localeName => Platform.localeName;
  static String get operatingSystem => Platform.operatingSystem;
  static String get operatingSystemVersion => Platform.operatingSystemVersion;
  static String get localHostname => Platform.localHostname;
  static Map<String, String> get environment => Platform.environment;
  static String get executable => Platform.executable;
  static String get resolvedExecutable => Platform.resolvedExecutable;
  static Uri get script => Platform.script;
  static List<String> get executableArguments => Platform.executableArguments;
  static String? get packageConfig => Platform.packageConfig;
  static String get version => Platform.version;

  static bool get isLinux => operatingSystem == "linux";
  static bool get isMacOS => operatingSystem == "macos";
  static bool get isWindows => operatingSystem == "windows";
  static bool get isAndroid => operatingSystem == "android";
  static bool get isIOS => operatingSystem == "ios";
  static bool get isFuchsia => operatingSystem == "fuchsia";
  static bool get isWeb => false;
}
