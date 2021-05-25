import 'package:bakti_karya/pages/product_list_page/product_list_page.dart';

/// untuk kategori di page [ProductListPage]
enum KategoriProductListPage {
  All,
  Daging,
  Sayur,
  Buah,
  Rempah,
  Resep,
}

/// untuk index tabview di page [ProductListPage]
int? kategoriToInt(KategoriProductListPage kategoriProduk) {
  return <KategoriProductListPage, int>{
    KategoriProductListPage.All: 0,
    KategoriProductListPage.Daging: 1,
    KategoriProductListPage.Sayur: 2,
    KategoriProductListPage.Buah: 3,
    KategoriProductListPage.Rempah: 4,
    KategoriProductListPage.Resep: 5
  }[kategoriProduk];
}
