enum KategoriProduk {
  All,
  Daging,
  Sayur,
  Buah,
  Rempah,
  Resep,
}

/// untuk index tab di screen produk
int kategoriToInt(KategoriProduk kategoriProduk) {
  return <KategoriProduk, int>{
    KategoriProduk.All: 0,
    KategoriProduk.Daging: 1,
    KategoriProduk.Sayur: 2,
    KategoriProduk.Buah: 3,
    KategoriProduk.Rempah: 4,
    KategoriProduk.Resep: 5
  }[kategoriProduk];
}
