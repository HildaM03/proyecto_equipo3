import 'package:flutter/material.dart';
import 'package:flutter_proyecto_equipo3/widget/drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recetas Saludables en Casa - Acerca de'),
      ),
      drawer: const MenuDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.grey.shade800],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Sobre la Aplicación',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Desarrollamos una aplicación que ofrece recetas saludables y fáciles de preparar para ayudar a las personas a mantener una dieta equilibrada en casa. Nuestra aplicación incluye características como la planificación de comidas y la posibilidad de adaptar las recetas según las preferencias dietéticas.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30), // Incrementamos el espacio
              const Text(
                'Alcance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              _buildFeatureItem(
                'Catálogo de Recetas',
                'Una amplia variedad de recetas clasificadas por tipo de comida, ingredientes y tiempo de preparación.',
                Icons.restaurant,
              ),
              _buildFeatureItem(
                'Planificación de Comidas',
                'Función para planificar comidas semanales, permitiendo a los usuarios organizar y prepararse con anticipación.',
                Icons.calendar_today,
              ),
              _buildFeatureItem(
                'Personalización de Recetas',
                'Opción para adaptar las recetas según preferencias dietéticas, alergias o restricciones alimenticias.',
                Icons.settings,
              ),
              const SizedBox(height: 10), // Incrementamos el espacio
              const Text(
                'Integrantes del Equipo:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildTeamMember('Hilda Ester Melendez', '62151194'),
              _buildTeamMember('Daniel Edgardo Morales', '62241019'),
              _buildTeamMember('Carlos Leonel Sandoval', '62111743'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
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
