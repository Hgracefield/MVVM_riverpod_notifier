import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/student.dart';
import '../vm/student_provider.dart';

class InsertStudents extends ConsumerStatefulWidget {
  const InsertStudents({super.key});

  @override
  ConsumerState<InsertStudents> createState() => _InsertStudentState();
}

class _InsertStudentState extends ConsumerState<InsertStudents> {
  late final TextEditingController codeController;
  late final TextEditingController nameController;
  late final TextEditingController deptController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
    nameController = TextEditingController();
    deptController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    codeController.dispose();
    nameController.dispose();
    deptController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentNotifier = ref.read(
      studentNotifierProvider.notifier,
    ); // 비어있는 화면이니까 watch할 필요가X.

    return Scaffold(
      appBar: AppBar(title: const Text("Insert Student")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField("학번", codeController),
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
                final result = await studentNotifier.insertStudent(student);
                if (result == 'OK') {
                  if (!context.mounted) return; // await 이후에는 context가 여전히 유효한지 확인
                  Navigator.of(context).pop();
                  _snackBar(context, '학생 정보가 등록 되었습니다.', Colors.blue);
                } else {
                  if (!context.mounted) return;
                  _snackBar(context, '오류가 발생했습니다.', Colors.red);
                }
              },
              child: const Text('입력'),
            ),
          ],
        ),
      ),
    );
  } // build

  // ==================== Widgets ====================
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
      ),
    );
  }

  // ==================== Functions ====================
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
