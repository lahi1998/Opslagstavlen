import 'dart:io';
import 'package:flutter/material.dart';
import 'package:opslagstavlen/Provider/home_screen_provider.dart';
import 'package:opslagstavlen/View/home_screen.dart';
import 'package:provider/provider.dart';
import '../Provider/board_screen_provider.dart';

// BoardScreen widget to display the canvas board UI
class BoardScreen extends StatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  State<BoardScreen> createState() {
    return BoardScreenView();
  }
}

class BoardScreenView extends State<BoardScreen> {
  final List<Widget> _addedWidgets = [];

  // Function to reset the added images
  void resetAddedImages() {
    setState(() {
      _addedWidgets.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeScreenProvider>(context);

    // Create a list of widgets from image paths
    final List<Widget> imageWidgets = provider.imagePaths.map((imagePath) {
      return board_screen_provider(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Image.file(File(imagePath), fit: BoxFit.cover),
        ),
      );
    }).toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Opslagstavle"),
        ),

        // Drawer menu for navigation
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
                title: const Text('Vis home'),
                onTap: () {
                  // Navigate to the home screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),

        // Floating action buttons for adding images and resetting
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                if (_addedWidgets.length < imageWidgets.length) {
                  setState(() {
                    _addedWidgets.add(imageWidgets[_addedWidgets.length]);
                  });
                }
              },
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: resetAddedImages, // Call the reset function
              child: const Icon(Icons.refresh),
            ),
          ],
        ),

        // Display the canvas board and added widgets
        body: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assest\\background.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            for (int i = 0; i < _addedWidgets.length; i++) _addedWidgets[i]
          ],
        ),
      ),
    );
  }
}
