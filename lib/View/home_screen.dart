import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:opslagstavlen/Provider/home_screen_provider.dart';
import 'board_screen.dart';

// HomeScreen widget to display the app's main UI
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context); // Access the provider

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image camera draggable demo'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Tag ny selfie'),
                onTap: () {
                  provider.pickImageFromCamera(
                      context); // Call the function from provider
                  Navigator.pop(context); // Close the drawer after tapping
                },
              ),
              ListTile(
                title: const Text('Hent billed fra gallery'),
                onTap: () {
                  provider.pickImageFromGallery(
                      context); // Call the function from provider
                  Navigator.pop(context); // Close the drawer after tapping
                },
              ),
              ListTile(
                title: const Text('Vis opslagstavlen'),
                onTap: () {
                  // Implement functionality to navigate to the board
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BoardScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: const HomeScreenView(), // Display the HomeScreenView
      ),
    );
  }
}

// HomeScreenView widget to display the content of the home screen
class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("opslagstavlen", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Color.fromARGB(255, 26, 135, 244)),),
        SizedBox(height: 20),
      ]),
    );
  }
}
