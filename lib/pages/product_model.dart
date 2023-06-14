class ProductModel {
  int? id;
  String? judul, isi;

  ProductModel({this.id, this.judul, this.isi});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(id: json['id'], judul: json['judul'], isi: json['isi']);
  }
}
