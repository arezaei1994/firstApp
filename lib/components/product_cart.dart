import 'package:flutter/material.dart';
import 'package:whatsapp/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return new Container(
      margin: const EdgeInsets.only(right: 5, left: 5, bottom: 10),
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: [
          new Container(
            height: 200,
            width: screenSize.width,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder-image.png',
              image: product.image,
              fit: BoxFit.cover,
            ),
          ),
          new Container(
              alignment: Alignment.centerRight,
              height: 60,
              decoration: BoxDecoration(color: Colors.black45),
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    new RichText(
                      maxLines: 1,
                      text: TextSpan(
                          text: product.body,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Vazir',
                              color: Colors.white)),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
