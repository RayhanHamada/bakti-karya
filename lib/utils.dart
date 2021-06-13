import 'package:bakti_karya/pages/product_list_page/product_list_page.dart';
import 'package:intl/intl.dart';

/// untuk kategori di page [ProductListPage]
enum KategoriProductListPage {
  All,
  Daging,
  Sayur,
  Buah,
  Rempah,
  Paket,
}

/// untuk index tabview di page [ProductListPage]
int? kategoriToInt(KategoriProductListPage kategoriProduk) {
  return <KategoriProductListPage, int>{
    KategoriProductListPage.All: 0,
    KategoriProductListPage.Daging: 1,
    KategoriProductListPage.Sayur: 2,
    KategoriProductListPage.Buah: 3,
    KategoriProductListPage.Rempah: 4,
    KategoriProductListPage.Paket: 5
  }[kategoriProduk];
}

var rupiahFormatter = NumberFormat.simpleCurrency(
  locale: 'id_ID',
);

enum Bank {
  BNI,
  BCA,
}

enum PaymentMethod {
  VirtualAccount,
  Cash,
}
