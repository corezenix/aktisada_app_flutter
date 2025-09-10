import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/logger.dart' as logger;

class ImageService {
  static final ImagePicker _imagePicker = ImagePicker();
  static final FilePicker _filePicker = FilePicker.platform;

  // Pick image from camera
  static Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      logger.logInfo('Error picking image from camera: $e');
      return null;
    }
  }

  // Pick image from gallery
  static Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      if (image != null) {
        return File(image.path);
      }
      return null;
    } catch (e) {
      logger.logInfo('Error picking image from gallery: $e');
      return null;
    }
  }

  // Pick file (any type)
  static Future<File?> pickFile({
    List<String>? allowedExtensions,
    String? dialogTitle,
  }) async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: dialogTitle,
      );

      if (result != null && result.files.isNotEmpty) {
        return File(result.files.first.path!);
      }
      return null;
    } catch (e) {
      logger.logInfo('Error picking file: $e');
      return null;
    }
  }

  // Pick multiple images
  static Future<List<File>> pickMultipleImages() async {
    try {
      final List<XFile> images = await _imagePicker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );

      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      logger.logInfo('Error picking multiple images: $e');
      return [];
    }
  }

  // Get file size in MB
  static double getFileSizeInMB(File file) {
    try {
      final bytes = file.lengthSync();
      return bytes / (1024 * 1024);
    } catch (e) {
      logger.logInfo('Error getting file size: $e');
      return 0.0;
    }
  }

  // Check if file is image
  static bool isImageFile(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(extension);
  }

  // Validate image file
  static String? validateImageFile(File file, {double maxSizeMB = 5.0}) {
    if (!isImageFile(file)) {
      return 'Please select a valid image file (JPG, PNG, GIF, etc.)';
    }

    final fileSize = getFileSizeInMB(file);
    if (fileSize > maxSizeMB) {
      return 'Image size should be less than ${maxSizeMB}MB';
    }

    return null;
  }
}
