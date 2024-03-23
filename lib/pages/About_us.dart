import 'package:flutter/material.dart';
import 'package:flutter_proyecto_equipo3/widget/drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca del Proyecto'),
      ),
      drawer: const MenuDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade900, Colors.grey.shade600],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Examen Práctico de Programación Móvil - CRUD con Firebase y Flutter',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Este proyecto es el resultado de un examen práctico de programación móvil que se enfoca en la creación de una aplicación utilizando Flutter y Firebase para realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre una base de datos Firestore. A continuación, se describen los puntos clave del proyecto:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20), 
              _buildListItem(
                'Configuración de Firebase:',
                'Se creó un nuevo proyecto en Firebase y se habilitó Firestore Database. Además, se configuraron las reglas de seguridad para permitir el acceso desde la aplicación Flutter.',
              ),
              _buildListItem(
                'Desarrollo de la Aplicación Flutter:',
                'Se creó un nuevo proyecto en Flutter e se agregaron las dependencias necesarias para utilizar Firebase Firestore y Providers. Se implementó el uso de rutas con Go Router y se configuró la conexión con Firebase.',
              ),
              _buildListItem(
                'Diseño de la Interfaz de Usuario:',
                'Se diseñó una interfaz de usuario que permite al usuario realizar las operaciones CRUD sobre la colección de vehículos. Se incluyen campos para las características de un vehículo y un campo para la URL de la fotografía del vehículo.',
              ),
              _buildListItem(
                'Implementación del CRUD:',
                'Se implementó la funcionalidad para crear, leer, actualizar y eliminar registros de la colección "Vehículos" en Firebase Firestore. Se utilizó Providers para gestionar el estado de la aplicación y la comunicación con Firebase.',
              ),
              const SizedBox(height: 20),
              const Text(
                'Integrantes del Equipo:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              _buildTeamMember('Hilda Ester Melendez', '62151194'),
              _buildTeamMember('Daniel Edgardo Morales', '62241019'),
              _buildTeamMember('Carlos Leonel Sandoval', '62111743'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTeamMember(String name, String id) {
    return Row(
      children: [
        const Icon(Icons.person, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '$name - $id',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
