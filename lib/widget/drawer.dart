import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 131, 181, 73),
                  Colors.green.shade400
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://d31sro4iz4ob5n.cloudfront.net/upload/car/civic-sedan-2022/home/civic-sedan-2022-lhd-mobile.jpg', 
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 900, 
                  height: 1000, 
                ),
                const Text(
                  'Crud AutosMoviles', // Texto a mostrar
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          buildListTile(Icons.home, 'Home', () => GoRouter.of(context).go('/')),
          const SizedBox(height: 15),
               buildListTile(Icons.person, 'About Us', () => GoRouter.of(context).go('/about')),
      
        ],
      ),
    );
  }
  
  ListTile buildListTile(IconData icon, String title, Function()? onTap) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.green.shade800),
      title: Text(title, style: const TextStyle(color: Colors.black87, fontSize: 16)),
      onTap: onTap,
    );
  }
}
