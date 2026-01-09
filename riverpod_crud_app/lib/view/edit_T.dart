// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:riverpod_must_eat_place_app/model/address.dart';

// class EditPlace extends ConsumerStatefulWidget {
//   final int id;
//   final String name;
//   final String phone;
//   final String estimate;
//   final double lat;
//   final double lng;
//   final Uint8List image;

//   const EditPlace({
//     super.key,
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.estimate,
//     required this.lat,
//     required this.lng,
//     required this.image,
//   });

//   @override
//   ConsumerState<EditPlace> createState() => _EditPlaceState();
// }

// class _EditPlaceState extends ConsumerState<EditPlace> {
//   late final TextEditingController nameController;
//   late final TextEditingController phoneController;
//   late final TextEditingController estimateController;
//   late final TextEditingController latController;
//   late final TextEditingController lngController;

//   @override
//   void initState() {
//     super.initState();

//     nameController = TextEditingController(text: widget.name);
//     phoneController = TextEditingController(text: widget.phone);
//     estimateController = TextEditingController(text: widget.estimate);
//     latController = TextEditingController(text: widget.lat.toString());
//     lngController = TextEditingController(text: widget.lng.toString());
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     phoneController.dispose();
//     estimateController.dispose();
//     latController.dispose();
//     lngController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final imageState = ref.watch(imageNotifierProvider);
//     final imageNotifier = ref.read(imageNotifierProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: const Text("맛집 수정")),
//       body: Column(
//         children: [
//           _buildImagePicker(imageNotifier, imageState, widget.image),
//           _buildLatLngFields(),
//           _buildTextField("이름", nameController),
//           _buildTextField("전화", phoneController, keyboardType: TextInputType.phone),
//           _buildTextField("평가", estimateController, maxLines: 3, maxLength: 50),
//           const SizedBox(height: 12),
//           ElevatedButton(
//             onPressed: () => _update(context, widget.image),
//             child: const Text("수정"),
//           ),
//         ],
//       ),
//     );
//   }

//   // --- Widgets ---
//   Widget _buildImagePicker(
//     ImageNotifier imageNotifier,
//     ImageState imageState,
//     Uint8List originalImage,
//   ) {
//     final picked = imageState.imageFile;

//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => imageNotifier.getImageFromGallery(ImageSource.gallery),
//               child: const Text("갤러리"),
//             ),
//             const SizedBox(width: 12),
//             ElevatedButton(
//               onPressed: () => imageNotifier.getImageFromGallery(ImageSource.camera),
//               child: const Text("카메라"),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Container(
//           width: double.infinity,
//           height: 200,
//           color: Colors.grey[300],
//           child: picked == null
//               ? Image.memory(originalImage)
//               : Image.file(File(picked.path)),
//         ),
//       ],
//     );
//   }

//   Widget _buildLatLngFields() => Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       _coordField("위도", latController),
//       const SizedBox(width: 12),
//       _coordField("경도", lngController),
//     ],
//   );

//   Widget _coordField(String label, TextEditingController controller) => SizedBox(
//     width: 150,
//     child: TextField(
//       controller: controller,
//       decoration: InputDecoration(labelText: label),
//       readOnly: true,
//     ),
//   );

//   Widget _buildTextField(
//     String label,
//     TextEditingController controller, {
//     TextInputType? keyboardType,
//     int maxLines = 1,
//     int? maxLength,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       maxLength: maxLength,
//       decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
//     );
//   }

//   // --- Functions ---
//   Future<void> _update(BuildContext context, Uint8List originalImage) async {
//     final imageState = ref.read(imageNotifierProvider);

//     // 새 이미지가 없으면 원본 유지
//     Uint8List imageBytes = originalImage;
//     if (imageState.imageFile != null) {
//       imageBytes = await File(imageState.imageFile!.path).readAsBytes();
//     }

//     final address = Address(
//       id: widget.id,
//       name: nameController.text.trim(),
//       phone: phoneController.text.trim(),
//       estimate: estimateController.text.trim(),
//       lat: double.tryParse(latController.text) ?? widget.lat,
//       lng: double.tryParse(lngController.text) ?? widget.lng,
//       image: imageBytes,
//     );

//     // DB 업데이트 (이미지 포함 여부는 기존 로직 유지)
//     if (imageState.imageFile != null) {
//       await ref.read(vmProvider.notifier).updateAddressAll(address);
//     } else {
//       await ref.read(vmProvider.notifier).updateAddress(address);
//     }

//     if (!context.mounted) return;
//     _showDialog(context, title: '수정 완료', message: '맛집이 수정 되었습니다.');
//   }

//   void _showDialog(
//     BuildContext parentContext, {
//     required String title,
//     required String message,
//   }) {
//     showDialog(
//       context: parentContext,
//       barrierDismissible: false,
//       builder: (_) {
//         return AlertDialog(
//           backgroundColor: Colors.amber[50],
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(parentContext).pop();
//                 Navigator.of(parentContext).pop();
//               },
//               child: const Text('종료'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
