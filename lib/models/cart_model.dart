import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;
  List<CartProduct> products = [];

  CartModel(this.userModel);

  static CartModel of(BuildContext context) => ScopedModel.of(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(userModel.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }
}
