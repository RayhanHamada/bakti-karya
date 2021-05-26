enum KategoriProduct {
  Daging,
  Sayur,
  Buah,
  Rempah,
  Paket,
}

class Product {
  final KategoriProduct? kategoriProduct;
  final String nama, photoName, deskripsi;
  final num harga;
  final num promo;

  Product({
    required this.nama,
    required this.kategoriProduct,
    required this.deskripsi,
    required this.photoName,
    required this.harga,
    required this.promo,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      nama: map['nama'],
      deskripsi: map['deskripsi'],
      harga: map['harga'],
      photoName: map['photo_name'],
      kategoriProduct: stringToKategori(map['category']),
      promo: map['promo'],
    );
  }

  static KategoriProduct? stringToKategori(String kategori) {
    var kategoriMap = <String, KategoriProduct>{
      'daging': KategoriProduct.Daging,
      'buah': KategoriProduct.Buah,
      'sayur': KategoriProduct.Sayur,
      'rempah': KategoriProduct.Rempah,
      'paket': KategoriProduct.Paket,
    };

    if (!kategoriMap.keys.toList().any((e) => e == kategori)) {
      throw Error.safeToString(
          'invalid kategori, must be one if these: ${kategoriMap.keys}');
    }

    return kategoriMap[kategori];
  }

  static String? kategoriToString(KategoriProduct kategoriProduct) {
    var kategoriMap = <KategoriProduct, String>{
      KategoriProduct.Daging: 'daging',
      KategoriProduct.Buah: 'buah',
      KategoriProduct.Sayur: 'sayur',
      KategoriProduct.Rempah: 'rempah',
      KategoriProduct.Paket: 'paket',
    };

    return kategoriMap[kategoriProduct];
  }
}

class RecipeProduct extends Product {
  List<String> bahan;

  RecipeProduct({
    required String nama,
    KategoriProduct? kategoriProduct,
    required String deskripsi,
    required String photoName,
    required num harga,
    required num promo,
    required this.bahan,
    // required this.langkah,
  }) : super(
          nama: nama,
          kategoriProduct: kategoriProduct,
          deskripsi: deskripsi,
          photoName: photoName,
          harga: harga,
          promo: promo,
        );

  factory RecipeProduct.fromJson(Map<String, dynamic> map) {
    return RecipeProduct(
      nama: map['nama'],
      deskripsi: map['deskripsi'],
      harga: map['harga'],
      photoName: map['photo_name'],
      kategoriProduct: Product.stringToKategori(map['category']),
      bahan: List.from(map['bahan']),
      promo: map['promo'],
    );
  }
}
