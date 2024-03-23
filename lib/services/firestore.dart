 import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference autos = FirebaseFirestore.instance.collection('Autos');

  Future<void> addAuto(String marca, String modelo, int ano, String color, double precio, String url) {
    return autos.add({
      'Marca': marca,
      'Modelo': modelo,
      'Año': ano,
      'Color': color,
      'Precio': precio,
      'URL': url, 
      'Timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getAutosStream() {
    final autosStream = autos.orderBy('Timestamp', descending: true).snapshots();
    return autosStream;
  }

  Future<void> updateAuto(String docID, String marca, String modelo, int ano, String color, double precio, String url) {
    return autos.doc(docID).update({
      'Marca': marca,
      'Modelo': modelo,
      'Año': ano,
      'Color': color,
      'Precio': precio,
      'URL': url, 
      'Timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteAuto(String docID) {
    return autos.doc(docID).delete();
  }
}