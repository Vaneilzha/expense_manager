import 'dart:io';

double cekSaldo(double saldo) {
  return saldo;
}

double setor(double jumlah, double saldo, List<String> riwayat) {
  saldo += jumlah;
  riwayat.add("Setor tunai: +$jumlah, Saldo: $saldo");
  print("Setor tunai sebesar $jumlah berhasil");
  return saldo;
}

double tarik(double jumlah, double saldo, List<String> riwayat) {
  if (jumlah > saldo - 50000) {
    print("Saldo tidak mencukupi. Minimal saldo Rp50.000 harus tersisa.");
    return saldo;
  } else if (jumlah <= 0) {
    print("Jumlah tarik tunai tidak valid");
    return saldo;
  } else if (jumlah <= 50000) {
    saldo -= (jumlah + 2000);
    riwayat.add("Tarik tunai: -$jumlah (biaya 2000), Saldo: $saldo");
    print("Tarik tunai sebesar $jumlah berhasil");
    return saldo;
  }
  return saldo;
}

double transfer(double jumlah, double saldo, String rekeningTujuan, List<String> riwayat) {
  if (jumlah > saldo - 50000) {
    print("Saldo tidak mencukupi. Minimal saldo Rp50.000 harus tersisa.");
    return saldo;
  } else if (jumlah <= 0) {
    print("Jumlah transfer tidak valid");
    return saldo;
  } else {
    saldo -= jumlah;
    riwayat.add("Transfer ke $rekeningTujuan: -$jumlah, Saldo: $saldo");
    print("Transfer sebesar $jumlah ke rekening $rekeningTujuan berhasil");
    return saldo;
  }
}

void tampilkanRiwayat(List<String> riwayat) {
  print("\n=== Riwayat Transaksi ===");
  if (riwayat.isEmpty) {
    print("Belum ada transaksi.");
  } else {
    for (var r in riwayat) {
      print(r);
    }
  }
  print("========================\n");
}

void main() {
  double saldo = 100000;
  List<String> riwayat = [];
  while (true) {
    print("=== ATM ===");
    print("Menu Pilihan:");
    print("1. Cek Saldo");
    print("2. Tarik Tunai");
    print("3. Setor Tunai");
    print("4. Transfer Antar Rekening");
    stdout.write("Masukan pilihan (1/2/3/4): ");
    int jenisTransaksi = int.parse(stdin.readLineSync()!);
    switch (jenisTransaksi) {
      case 1:
        print("Saldo anda saat ini: ${cekSaldo(saldo)}");
        break;
      case 2:
        stdout.write("Masukan jumlah tarik tunai: ");
        double jumlahTarik = double.parse(stdin.readLineSync()!);
        saldo = tarik(jumlahTarik, saldo, riwayat);
        print("Saldo anda saat ini: $saldo");
        break;
      case 3:
        stdout.write("Masukan jumlah setor tunai: ");
        double jumlahSetor = double.parse(stdin.readLineSync()!);
        saldo = setor(jumlahSetor, saldo, riwayat);
        print("Saldo anda saat ini: $saldo");
        break;
      case 4:
        stdout.write("Masukan nomor rekening tujuan: ");
        String rekeningTujuan = stdin.readLineSync()!;
        stdout.write("Masukan jumlah transfer: ");
        double jumlahTransfer = double.parse(stdin.readLineSync()!);
        saldo = transfer(jumlahTransfer, saldo, rekeningTujuan, riwayat);
        print("Saldo anda saat ini: $saldo");
        break;
      default:
        print("Pilihan tidak valid.");
    }
    tampilkanRiwayat(riwayat);
    stdout.write("\nApakah anda ingin mengakhiri? (y/n): ");
    String lagi = stdin.readLineSync()!;
    if (lagi.toLowerCase() == 'y') {
      print("Terimakasih telah menggunakan ATM kami.");
      break;
    }
  }
}