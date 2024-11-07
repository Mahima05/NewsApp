// string_extensions.dart
extension StringCasingExtension on String {
  String capitalizeFirstOfEach() {
    return this.split(" ").map((str) => str.isNotEmpty ? str[0].toUpperCase() + str.substring(1) : "").join(" ");
  }
}
