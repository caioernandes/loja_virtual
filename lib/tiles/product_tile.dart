import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';
import 'package:loja_virtual/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product))
        );
      },
      child: Card(
        child: type == "grid" ? getColumn(context) : getRow(context),
      ),
    );
  }

  Widget getColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8),
            child: getContainerDescription(context, type),
          ),
        )
      ],
    );
  }

  Widget getRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(
            product.images[0],
            fit: BoxFit.cover,
            height: 250,
          ),
        ),
        Flexible(
          flex: 1,
          child: getContainerDescription(context, type),
        )
      ],
    );
  }

  Widget getContainerDescription(BuildContext context, String type) {
    return Column(
      crossAxisAlignment: type == "list"
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          product.title,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          "R\$ ${product.price.toStringAsFixed(2)}",
          style: TextStyle(
              color: Theme
                  .of(context)
                  .primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
