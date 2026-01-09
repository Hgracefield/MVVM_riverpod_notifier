import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:riverpod_must_eat_place_app/view/insert_place.dart';
import 'package:riverpod_must_eat_place_app/view/map_place.dart';
import 'package:riverpod_must_eat_place_app/vm/image_handler.dart';
import 'package:riverpod_must_eat_place_app/vm/vm_handler.dart';

class QueryPlace extends ConsumerWidget {
  // <<<<<<<<<<<<<
  QueryPlace({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // <<<<<<<<<<<<<<<<<
    final addressAsync = ref.watch(vmNotifierProvider);
    final vmHanlder = ref.read(vmNotifierProvider.notifier);
    final imageHandler = ref.read(imageNotifierProvider.notifier);

    // 수정 필요

    return Scaffold(
      appBar: AppBar(
        title: Text('내가 경험한 맛집'),
        actions: [
          IconButton(
            onPressed: () {
              imageHandler.clearImage();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InsertPlace()),
              );
            },
            icon: Icon(Icons.add_business),
          ),
        ],
      ),
      body: addressAsync.when(
        data: (addressList) {
          return addressList.isEmpty
              ? Center(child: Text('등록된 자료가 없습니다.'))
              : ListView.builder(
                  itemCount: addressList.length,
                  itemBuilder: (context, index) {
                    final address = addressList[index];

                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MapPlace(lat: address.lat, lng: address.lng),
                        ),
                      ),
                      child: Slidable(
                        // startActionPane: ActionPane(
                        //   motion: BehindMotion(),
                        //   children: [
                        //     SlidableAction(
                        //       backgroundColor: Colors.lightGreen,
                        //       icon: Icons.edit,
                        //       label: '수정',
                        //       onPressed: (context) {
                        //        imageHandler.clearImage(); // 이미지 메모리 삭제
                        //         Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => EditPlace(
                        //               id: address.id!,
                        //               name: address.name,
                        //               phone: address.phone,
                        //               estimate: address.estimate,
                        //               lat: address.lat,
                        //               lng: address.lng,
                        //               image: address.image,
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // ),
                        endActionPane: ActionPane(
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: '삭제',
                              onPressed: (conetxt) async {
                                await vmHanlder.deleteAddress(address.id!);
                              },
                            ),
                          ],
                        ),
                        child: Card(
                          child: Row(
                            children: [
                              Image.memory(address.image, width: 100, height: 80),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '명칭: ${address.name}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '전화번호: ${address.phone}',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
        error: (error, StackTrace) => Center(child: Text('error')),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  } // build

  //============================== style
  // class textStyleT(Text){
  //   return Text(
  //     style:TextStyle(fontWeight: FontWeight.bold)
  //   )
  // }
}// class