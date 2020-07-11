class DetailsModel {
String title;
String publishers;
String authors;
String subtitle;
String pages;
String years;
String rating;
String desc;
String price;
String image;

DetailsModel({this.title, this.publishers, this.authors,this.subtitle, this.pages, this.years,this.rating,
  this.desc, this.price,this.image});

DetailsModel.fromJson(Map<String, dynamic> json) {
title = json['title'];
publishers = json['publishers'];
authors = json['authors'];
subtitle = json['subtitle'];
pages = json['pages'];
years = json['years'];
rating = json['rating'];
desc = json['desc'];
price = json['price'];
image = json['image'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['title'] = this.title;
  data['publishers'] = this.publishers;
  data['authors'] = this.authors;
  data['subtitle'] = this.subtitle;
  data['pages'] = this.pages;
  data['years'] = this.years;
  data['rating'] = this.rating;
  data['desc'] = this.desc;
  data['price'] = this.price;
  data['image'] = this.image;

  return data;
}
}