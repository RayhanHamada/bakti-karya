enum KategoriProduct {
  Daging,
  Sayur,
  Buah,
  Rempah,
  Paket,
}

class Product {
  final KategoriProduct kategoriProduct;
  final String nama, photoName, deskripsi;
  final int harga;

  Product({
    this.nama,
    this.kategoriProduct,
    this.deskripsi,
    this.photoName,
    this.harga,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        nama: map['nama'],
        deskripsi: map['deskripsi'],
        harga: map['harga'],
        photoName: map['photo_name'],
        kategoriProduct: stringToKategori(map['category']));
  }

  static KategoriProduct stringToKategori(String kategori) {
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
}

class RecipeProduct extends Product {
  List<String> bahan, langkah;

  RecipeProduct({
    String nama,
    KategoriProduct kategoriProduct,
    String deskripsi,
    String photoName,
    int harga,
    this.bahan,
    this.langkah,
  }) : super(
          nama: nama,
          kategoriProduct: kategoriProduct,
          deskripsi: deskripsi,
          photoName: photoName,
          harga: harga,
        );

  factory RecipeProduct.fromJson(Map<String, dynamic> map) {
    return RecipeProduct(
      nama: map['nama'],
      deskripsi: map['deskripsi'],
      harga: int.parse(map['harga']),
      photoName: map['photo_name'],
      kategoriProduct: Product.stringToKategori(map['category']),
      bahan: map['bahan'],
      langkah: map['langkah'],
    );
  }
}
