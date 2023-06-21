class User {
  int? id,
      jumlahCuti,
      umur,
      provinceId,
      jumlahAnak,
      regencyId,
      districtId,
      villageId;
  DateTime? tanggalLahir;
  String? nik,
      nama,
      email,
      password,
      role,
      alamat,
      jenisKelamin,
      nomorHp,
      statusPernikahan,
      department,
      golongan,
      foto,
      digitalSignature,
      token;

  User(
      {this.id,
      this.nik,
      this.nama,
      this.email,
      this.password,
      this.role,
      this.jumlahCuti,
      this.alamat,
      this.tanggalLahir,
      this.umur,
      this.jenisKelamin,
      this.nomorHp,
      this.statusPernikahan,
      this.jumlahAnak,
      this.department,
      this.golongan,
      this.foto,
      this.digitalSignature,
      this.provinceId,
      this.regencyId,
      this.districtId,
      this.villageId,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        nik: json['nik'],
        nama: json['nama'],
        email: json['email'],
        password: json['password'],
        role: json['role'],
        jumlahCuti: int.parse(json['jumlahCuti']),
        alamat: json['alamat'],
        tanggalLahir: json['tanggalLahir'],
        umur: int.parse(json['umur']),
        jenisKelamin: json['jenisKelamin'],
        nomorHp: json['nomorHp'],
        statusPernikahan: json['statusPernikahan'],
        jumlahAnak: json['jumlahAnak'],
        department: json['department'],
        golongan: json['golongan'],
        foto: json['foto'],
        digitalSignature: json['digitalSignature'],
        provinceId: int.parse(json['provinceId']),
        regencyId: int.parse(json['id']),
        districtId: int.parse(json['id']),
        villageId: int.parse(json['id']),
        token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nik': nik,
      'password': password,
      'token': token,
    };
  }
}
