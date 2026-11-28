/// Switches that change between the private test build and the public release.
class BuildFlags {
  BuildFlags._();

  /// true  = the Test button (self test) is shown in the menu.
  /// false = it is hidden. SET THIS TO false BEFORE THE PLAY STORE RELEASE.
  static const bool testTools = true;
}
