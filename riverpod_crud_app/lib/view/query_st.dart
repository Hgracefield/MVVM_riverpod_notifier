import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/view/delete_st.dart';
import 'package:riverpod_crud_app/view/insert_st.dart';
import 'package:riverpod_crud_app/view/update_st.dart';
import 'package:riverpod_crud_app/vm/student_provider.dart';

class QueryStudents extends ConsumerWidget {
  const QueryStudents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentAsync = ref.watch(studentNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider CRUD for Students'),
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InsertStudents()),
            ),
          ),
        ],
      ),
      body: studentAsync.when(
        data: (students) {
          return students.isEmpty
              ? const Center(child: Text('학생 정보가 없습니다'))
              : ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final s = students[index];
                    return ListTile(
                      title: Text('${s.name} (${s.code})'),
                      subtitle: Text('${s.dept} | ${s.phone}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateStudents(
                              code: s.code,
                              name: s.name,
                              dept: s.dept,
                              phone: s.phone,
                              address: s.address,
                            ),
                          ),
                        );
                      },
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteStudents(code: s.code),
                          ),
                        );
                      },
                    );
                  },
                );
        },
        error: (error, stackTrace) => Center(child: Text('Error:$error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
