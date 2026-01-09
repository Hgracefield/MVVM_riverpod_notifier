import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ImageState {
  //property
  XFile? imageFile;
  //method
  ImageState({this.imageFile});

  ImageState copyWith({XFile? imageFile}) => ImageState(imageFile: imageFile);
}

class ImageNotifier extends Notifier<ImageState> {
  final ImagePicker picker = ImagePicker();

  @override
  ImageState build() => ImageState();

  Future<void> getImageFromGallery(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      state = state.copyWith(imageFile: pickedFile);
    }
  }

  void clearImage() {
    state = ImageState();
  }
}

// Provider
final imageNotifierProvider = NotifierProvider<ImageNotifier, ImageState>(
  ImageNotifier.new,
);
