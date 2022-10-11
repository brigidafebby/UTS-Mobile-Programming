
import 'dart:ui';

/// class untuk custome warna agar mudah dalam penerapan
/// class dengan turunan class color
class AppHexColor extends Color {

  /// pembuatan static function dmn memiliki parameter String
  static int _getColorFromHex(String hexColor) {
    /// variabel parameter di atur agar apapun yg di tulis akan dirubah menjadi huruf besar, serta menambahkan # didepan warna yang dipilih
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    ///membuat validasi untuk panjang karakter jika sama dengan 6 maka, akan mengahsil kan output
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  AppHexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}