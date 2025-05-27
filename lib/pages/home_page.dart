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

  double convertirADouble(dynamic valor) {
    if (valor is int) return valor.toDouble();
    if (valor is double) return valor;
    return 0.0;
  }

  void _openAutoBox({String? docID}) {
    String? marca;
    String? modelo;
    int? ano;
    String? color;
    double? precio;
    String? urlImagen;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        title: Text(docID == null ? 'Agregar Auto' : 'Editar Auto',
            style: TextStyle(color: Colors.blueGrey)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => marca = value,
                decoration: InputDecoration(
                    labelText: 'Marca',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => modelo = value,
                decoration: InputDecoration(
                    labelText: 'Modelo',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => ano = int.tryParse(value),
                decoration: InputDecoration(
                    labelText: 'Año',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => color = value,
                decoration: InputDecoration(
                    labelText: 'Color',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => precio = double.tryParse(value),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Precio',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
              SizedBox(height: 8),
              TextField(
                onChanged: (value) => urlImagen = value,
                decoration: InputDecoration(
                    labelText: 'URL de la imagen',
                    labelStyle: TextStyle(color: Colors.blueGrey)),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (marca != null &&
                  modelo != null &&
                  ano != null &&
                  color != null &&
                  precio != null &&
                  urlImagen != null) {
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
            child: Text(docID == null ? "Agregar" : "Actualizar"),
            style:
                ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              const Text("Autos", style: TextStyle(color: Colors.blueGrey))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAutoBox(),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
      drawer: const MenuDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getAutosStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DocumentSnapshot> autosList =
                snapshot.data!.docs.cast<DocumentSnapshot>();

            return ListView.builder(
              itemCount: autosList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = autosList[index];
                String docID = document.id;

                Map<String, dynamic>? data =
                    document.data() as Map<String, dynamic>?;

                String marcaText = data?['Marca'] ?? 'Desconocido';
                String modeloText = data?['Modelo'] ?? 'Desconocido';
                int anoText = data?['Año'] ?? 0;
                String colorText = data?['Color'] ?? 'Desconocido';

                // Aquí uso la función para evitar error de tipo
                double precioText = convertirADouble(data?['Precio']);

                String urlImagenText = data?['URL'] ?? 'Desconocida';

                return Card(
                  elevation: 4,
                  margin:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.grey.shade300,
                  child: ListTile(
                    title: Text('$marcaText - $modeloText',
                        style: TextStyle(color: Colors.black)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Año: $anoText - Color: $colorText - Precio: $precioText',
                          style: TextStyle(color: Colors.black),
                        ),
                        if (urlImagenText.isNotEmpty)
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Image.network(urlImagenText,
                                fit: BoxFit.cover),
                          ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => _openAutoBox(docID: docID),
                          icon: const Icon(Icons.edit),
                          color: Colors.blueGrey,
                        ),
                        IconButton(
                          onPressed: () => _firestoreService.deleteAuto(docID),
                          icon: const Icon(Icons.delete),
                          color: Colors.blueGrey,
                        )
                      ],
                    ),
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
