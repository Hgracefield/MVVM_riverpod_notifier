import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_must_eat_place_app/model/address.dart';
import 'package:riverpod_must_eat_place_app/vm/gps_handler.dart';
import 'package:riverpod_must_eat_place_app/vm/image_handler.dart';
import 'package:riverpod_must_eat_place_app/vm/vm_handler.dart';

class InsertPlace extends ConsumerStatefulWidget {
  const InsertPlace({super.key});

  @override
  ConsumerState<InsertPlace> createState() => _InsertPlaceState();
}

class _InsertPlaceState extends ConsumerState<InsertPlace> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController estimateController;
  late final TextEditingController latController;
  late final TextEditingController lngController;
  late final TextEditingController imageController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    estimateController = TextEditingController();
    latController = TextEditingController();
    lngController = TextEditingController();
    imageController = TextEditingController();

    // 위치 데이터 요청은 1번만
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gpsNotifierProvider.notifier).checkLocationPermission();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    estimateController.dispose();
    latController.dispose();
    lngController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gps = ref.watch(gpsNotifierProvider);
    final ImageState = ref.watch(imageNotifierProvider);

    if (gps.latitude.isNotEmpty) latController.text = gps.latitude;
    if (gps.longitude.isNotEmpty) lngController.text = gps.longitude;

    return Scaffold(
      appBar: AppBar(title: Text('맛집 추가')),
      body: gps.latitude.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildImagePicker(ref),
                _buildLatLngFields(),
                _buildTextField('이름', nameController),
                _buildTextField('전화번호', phoneController),
                ElevatedButton(
                  onPressed: () => _insert(context, ImageState.imageFile),
                  child: Text('입력'),
                ),
              ],
            ),
    );
  } // build

  // ============== widgets =====================
  Widget _buildImagePicker(WidgetRef ref) {
    final ImageNotifier = ref.read(imageNotifierProvider.notifier);
    final image = ref.watch(imageNotifierProvider).imageFile;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            ElevatedButton(
              onPressed: () => ImageNotifier.getImageFromGallery(ImageSource.gallery),
              child: Text('갤러리'),
            ),
            ElevatedButton(
              onPressed: () => ImageNotifier.getImageFromGallery(ImageSource.camera),
              child: Text('카메라'),
            ),
          ],
        ),
        Container(
          width: double.infinity,
          height: 200,
          color: Colors.blueGrey,
          child: image == null
              ? Center(child: Text('이미지를 선택해 주세요.'))
              : Image.file(File(image.path)),
        ),
      ],
    );
  }

  Widget _buildLatLngFields() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [_coordField('위도', latController), _coordField('경도', lngController)],
  );

  Widget _coordField(String label, TextEditingController controller) => SizedBox(
    width: 150,
    child: TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      readOnly: true,
    ),
  );

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    // {
    // textInputType? keyboardType,
    // int maxLines = 1,
    // int? maxLength,
    // }
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  // ================== functions ======================
  Future<void> _insert(BuildContext context, XFile? imageFile) async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이미지를 선택해 주세요'),
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final bytes = await File(imageFile!.path).readAsBytes();
    final address = Address(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      estimate: estimateController.text.trim(),
      lat: double.parse(latController.text),
      lng: double.parse(lngController.text),
      image: bytes,
    );

    await ref.read(vmNotifierProvider.notifier).insertAddress(address);
    if (!context.mounted) return;
    _showDialog(context);
  }

  void _showDialog(BuildContext parentContext) {
    showDialog(
      context: parentContext,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Colors.amber[50],
          title: const Text('입력 완료'),
          content: const Text("맛집이 등록 되었습니다."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(parentContext).pop();
                Navigator.of(parentContext).pop();
              },
              child: const Text('종료'),
            ),
          ],
        );
      },
    );
  }
}
 // class