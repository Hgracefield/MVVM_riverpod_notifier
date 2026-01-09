import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tabbar_app/view/first_page.dart';
import 'package:riverpod_tabbar_app/view/second_page.dart';
import 'package:riverpod_tabbar_app/view/third_page.dart';
import 'package:riverpod_tabbar_app/vm/tab_model.dart';

class Home extends ConsumerStatefulWidget {
  // Provider의 TabBar는 Stateful로 제어한다.
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState(); //  <<<<<<<<<<<<<<<<<<<<<<
}

class _HomeState extends ConsumerState<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _pages = [FirstPage(), SecondPage(), ThirdPage()];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(tabNotifierProvider.notifier).changeTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(tabNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider TabBar Example'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(icon: Icon(Icons.home), text: "홈"),
            Tab(icon: Icon(Icons.business), text: "비즈니스"),
            Tab(icon: Icon(Icons.school), text: "학교"),
          ],
          onTap: (value) {
            ref.read(tabNotifierProvider.notifier).changeTab(value);
            _tabController.animateTo(value);
          },
        ),
      ),
      body: TabBarView(controller: _tabController, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          ref.read(tabNotifierProvider.notifier).changeTab(value);
          _tabController.animateTo(value);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "비즈니스"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "학교"),
        ],
      ),
    );
  }
}
