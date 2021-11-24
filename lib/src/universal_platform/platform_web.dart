class UniversalPlatform {
  static int get numberOfProcessors => 1;
  static String get pathSeparator => '/';
  static String get localeName => 'en';
  static String get operatingSystem => 'web';
  static String get operatingSystemVersion => '1.0';
  static String get localHostname => '';
  static Map<String, String> get environment => {};
  static String get executable => '';
  static String get resolvedExecutable => '';
  static Uri get script => Uri.parse('');
  static List<String> get executableArguments => [];
  static String? get packageConfig => null;
  static String get version => '1.0';

  static bool get isLinux => false;
  static bool get isMacOS => false;
  static bool get isWindows => false;
  static bool get isAndroid => false;
  static bool get isIOS => false;
  static bool get isFuchsia => false;
  static bool get isWeb => true;
}
