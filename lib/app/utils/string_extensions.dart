extension StringExtensions on String {
  /// Returns the string with the first letter capitalized.
  ///
  /// Use `capitalizeFirst` to avoid name conflicts with other packages.
  String get capitalizeFirst {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
