class Product { 
  int id;
  int userId;
  String title;
  String body;
  String image;
  String price;
  DateTime createdat;
  DateTime updatedat;

  Product.fromJson(Map<String , dynamic> parsedJson) {
    id = parsedJson['id'];
    userId = parsedJson['userId'];
    title = parsedJson['title'];
    body = parsedJson['body'];
    image = parsedJson['image'];
    price = parsedJson['price'];
    createdat = parsedJson['createdat'];
    updatedat = parsedJson['updatedat'];

  }
}