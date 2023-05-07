import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collectar_admin/products/product_model.dart';
// import 'package:firebase_for_all/firebase_for_all.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firedart/firedart.dart';

class FirestoreDB {
  static final fireDB = Firestore.instance;
  static final firestorage = FirebaseStorage.instance.ref();

  static addProduct(Product product) async {
    await fireDB.collection('store').add(product.toJson());
  }

  static Future<List<Document>> productStream() async {
    final products = await fireDB.collection('store').orderBy('id').get();
    return products;
  }

  static Stream<List<Document>> orderStream(
      {String? orderBy, bool? descending}) {
    final orders = fireDB
        .collection('orders')
        .orderBy(orderBy ?? 'date', descending: descending ?? true)
        .get()
        .asStream();
    return orders;
  }

  static Future<Document> fetchUserData(String id) async {
    final query =
        await fireDB.collection('users').where('id', isEqualTo: id).get();
    final user = query[0];

    return user;
  }

  static update(String id, Product product) {
    var collection =
        fireDB.collection('store').document(id).update(product.toJson());
  }
}
