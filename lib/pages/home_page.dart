import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_proyecto_equipo3/services/firestore.dart';
import 'package:flutter_proyecto_equipo3/widget/drawer.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();

  void _openAutoBox({String? docID}) {
    String? marca;
    String? modelo;
    int? ano;
    String? color;
    double? precio;
    String? urlImagen; // Nuevo campo para la URL de la imagen

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => marca = value,
              decoration: InputDecoration(labelText: 'Marca'),
            ),
            TextField(
              onChanged: (value) => modelo = value,
              decoration: InputDecoration(labelText: 'Modelo'),
            ),
            TextField(
              onChanged: (value) => ano = int.tryParse(value),
              decoration: InputDecoration(labelText: 'Año'),
            ),
            TextField(
              onChanged: (value) => color = value,
              decoration: InputDecoration(labelText: 'Color'),
            ),
            TextField(
              onChanged: (value) => precio = double.tryParse(value),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio'),
            ),
            TextField( // Nuevo campo para la URL de la imagen
              onChanged: (value) => urlImagen = value,
              decoration: InputDecoration(labelText: 'URL de la imagen'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (marca != null &&
                  modelo != null &&
                  ano != null &&
                  color != null &&
                  precio != null &&
                  urlImagen != null) { // Asegúrate de que la URL de la imagen no sea nula
                if (docID == null) {
                  _firestoreService.addAuto(
                      marca!, modelo!, ano!, color!, precio!, urlImagen!);
                } else {
                  _firestoreService.updateAuto(docID, marca!, modelo!, ano!,
                      color!, precio!, urlImagen!);
                }
                Navigator.pop(context);
              }
            },
            child: Text(docID == null ? "Add" : "Update"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Autos")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAutoBox(),
        child: const Icon(Icons.add),
      ),
      drawer: const MenuDrawer(), 
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getAutosStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> autosList = snapshot.data!.docs.cast<DocumentSnapshot>();

            return ListView.builder(
              itemCount: autosList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = autosList[index];
                String docID = document.id;

                Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;

                String marcaText = data?['Marca'] ?? 'Desconocido';
                String modeloText = data?['Modelo'] ?? 'Desconocido';
                int anoText = data?['Año'] ?? 0;
                String colorText = data?['Color'] ?? 'Desconocido';
                double precioText = data?['Precio'] ?? 0.0;
                String urlImagenText = data?['URL'] ?? 'Desconocida'; // Obtener la URL de la imagen

                return ListTile(
                  title: Text('$marcaText - $modeloText'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Año: $anoText - Color: $colorText - Precio: $precioText'),
                     // Mostrar la URL de la imagen
                      if (urlImagenText.isNotEmpty)
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.network(urlImagenText), // Display the car image
                        ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _openAutoBox(docID: docID),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () =>
                            _firestoreService.deleteAuto(docID),
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
