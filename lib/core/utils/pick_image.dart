import 'package:bot_toast/bot_toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<FilePickerResult?> pickImage() async {
  if (!(await Permission.photos.request().isGranted)) {
    BotToast.showText(text: 'Izinkan akses penyimpanan untuk memilih gambar');
    return null;
  }

  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}
