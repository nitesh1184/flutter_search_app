class ApiResultModel {
  String status;
  int totalResults;
  List<Books> books;

  ApiResultModel({this.status, this.totalResults, this.books});

  ApiResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['books'] != null) {
      books = new List<Books>();
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalResults'] = this.totalResults;
    if (this.books != null) {
      data['articles'] = this.books.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String title;
  String subtitle;
  String isbn13;
  String image;
  String price;
  String url;

  Books(
      {this.title,
      this.subtitle,
      this.isbn13,
      this.image,
      this.price,
      this.url
      });

  Books.fromJson(Map<String, dynamic> json) {

    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
    image = json['image'];
    price = json['price'];
    isbn13 = json['isbn13'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['url'] = this.url;
    data['isbn13'] = this.isbn13;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }
}

class Source {
  String id;
  String name;

  Source({this.id, this.name});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
