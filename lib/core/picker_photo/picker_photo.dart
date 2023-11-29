import 'package:image_picker/image_picker.dart';

Future<void> pickerPhoto(
    ImageSource source,
    final void Function(String path) onPicked
    ) async {
  final picked = await ImagePicker().pickImage(source: source, imageQuality: 70);
  if(picked == null) return;

  onPicked(picked.path);
}