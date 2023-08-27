import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'dart:io';

class HomeScreenProvider extends ChangeNotifier {
  final List<String> _imagePaths = []; // List to store image paths

  List<String> get imagePaths => _imagePaths; // Getter for image paths list

  Future<void> pickImageFromCamera(BuildContext context) async {
    // Pick an image from the camera
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      // Save the image to gallery and get the saved image path
      final newImagePath = await saveImageToGallery(File(image.path));

      if (newImagePath != null) {
        // Add the new image path to the list and notify listeners
        _imagePaths.add(newImagePath);
        notifyListeners();
      }
    }
  }

  Future<void> pickImageFromGallery(BuildContext context) async {
    // Pick an image from the gallery
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Add the new image path to the list and notify listeners
      _imagePaths.add(image.path);
      notifyListeners();
    }
  }

  Future<String?> saveImageToGallery(File imageFile) async {
    final appDir = await getTemporaryDirectory(); // Get the temporary directory
    final newImagePath =
        '${appDir.path}/image_${DateTime.now()}.jpg'; // Create a new image path

    final savedImage =
        await imageFile.copy(newImagePath); // Copy the image file
    final result =
        await GallerySaver.saveImage(savedImage.path); // Save image to gallery

    // Optionally, you can delete the temporary file after copying to the gallery
    // with await savedImage.delete();

    if (result ?? false) {
      return newImagePath; // Return the new image path
    } else {
      return null; // Return null if image save was not successful
    }
  }
}
