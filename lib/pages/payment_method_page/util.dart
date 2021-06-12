enum Bank {
  BNI,
  BCA,
}

List<String> constructSteps(Bank bank) {
  var bankName = bank.toString().replaceFirst(r'Bank.', '');
  return [
    'Buka aplikasi layanan bank $bankName.',
    'Lakukan login.',
    'Pada menu utama, pilih transfer antar bank.',
    'Pada form, masukkan nomor virtual account yang tertera dibawah ini.',
    'Lalu konfirmasi dan selesaikan transaksi.',
  ];
}
