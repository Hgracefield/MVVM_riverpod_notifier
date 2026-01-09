import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/model/student.dart';
import 'package:riverpod_crud_app/vm/student_provider.dart';

class UpdateStudents extends ConsumerStatefulWidget {
  final String code;
  final String name;
  final String dept;
  final String phone;
  final String address;
  const UpdateStudents({
    super.key,
    required this.code,
    required this.name,
    required this.dept,
    required this.phone,
    required this.address,
  });

  @override
  ConsumerState<UpdateStudents> createState() => _UpdateStudents();
}

class _UpdateStudents extends ConsumerState<UpdateStudents> {
  late final TextEditingController codeController;
  late final TextEditingController nameController;
  late final TextEditingController deptController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  @override
  void initState() {
    codeController = TextEditingController(text: widget.code);
    nameController = TextEditingController(text: widget.name);
    deptController = TextEditingController(text: widget.dept);
    phoneController = TextEditingController(text: widget.phone);
    addressController = TextEditingController(text: widget.address);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    deptController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentModel = ref.watch(studentNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Update Student")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField("학번", codeController, readOnly: true),
            _buildTextField("성명", nameController),
            _buildTextField("전공", deptController),
            _buildTextField("전화번호", phoneController),
            _buildTextField("주소", addressController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final student = Student(
                  code: codeController.text,
                  name: nameController.text,
                  dept: deptController.text,
                  phone: phoneController.text,
                  address: addressController.text,
                );
                final result = await studentModel.updateStudent(student);
                if (result == 'OK') {
                  if (!context.mounted) return; // await 이후에는 context가 여전히 유효한지 확인
                  Navigator.of(context).pop();
                  _snackBar(context, '학생 정보가 수정 되었습니다.', Colors.blue);
                } else {
                  if (!context.mounted) return;
                  _snackBar(context, '오류가 발생했습니다.', Colors.red);
                }
              },
              child: const Text('수정'),
            ),
          ],
        ),
      ),
    );
  } // build

  // --- Widgets
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  // --- Functions
  void _snackBar(BuildContext context, String str, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(str),
        duration: Duration(seconds: 1),
        backgroundColor: color,
      ),
    );
  }
} // class
