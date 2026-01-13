import 'package:flutter/material.dart';
import 'package:seatup_app/view/app_route/place_holder_page.dart';

class MenuItem {
  final String title;
  final String route;
  const MenuItem(this.title, this.route);
}

class AppRoutes {
  // ✅ 버튼 목록 (네가 준 파일명 그대로)
  static const menuItems = <MenuItem>[
    // user
    MenuItem('splash_screen', '/splash_screen'),
    MenuItem('customer_login', '/customer_login'),
    MenuItem('customer_find_info', '/customer_find_info'),
    MenuItem('sign_up', '/sign_up'),
    MenuItem('customer_info_update', '/customer_info_update'),
    MenuItem('customer_mypage', '/customer_mypage'),
    MenuItem('tab_bar.dart', '/tab_bar'),
    MenuItem('main_page.dart', '/main_page'),
    MenuItem('performance_detail', '/performance_detail'),
    MenuItem('ticket_detail', '/ticket_detail'),
    MenuItem('purchase_history', '/purchase_history'),
    MenuItem('purchase_detail', '/purchase_detail'),
    MenuItem('map_view', '/map_view'),
    MenuItem('payment', '/payment'),
    MenuItem('category', '/category'),
    MenuItem('search_result', '/search_result'),
    MenuItem('review_write', '/review_write'),
    MenuItem('review_list', '/review_list'),
    MenuItem('seller_to_seller_chat', '/seller_to_seller_chat'),
    MenuItem('seller_to_admin_chat', '/seller_to_admin_chat'),
    MenuItem('transaction_review_write', '/transaction_review_write'),
    MenuItem('transaction_review_list', '/transaction_review_list'),
    MenuItem('transaction_cancel', '/transaction_cancel'),
    MenuItem('transaction_tickets_check', '/transaction_tickets_check'),
    MenuItem('shopping_cart', '/shopping_cart'),
    MenuItem('sell_register', '/sell_register'),
    MenuItem('sell_history', '/sell_history'),

    // admin
    MenuItem('admin_login', '/admin_login'),
    MenuItem('admin_dashboard', '/admin_dashboard'),
    MenuItem('admin_performance_create', '/admin_performance_create'),
    MenuItem('admin_performance_edit', '/admin_performance_edit'),
    MenuItem('faq', '/faq'),
    MenuItem('board_write', '/board_write'),
    MenuItem('board_edit', '/board_edit'),
    MenuItem('admin_transaction_manage', '/admin_transaction_manage'),
    MenuItem('admin_review_manage', '/admin_review_manage'),
    MenuItem('admin_transaction_review_manage', '/admin_transaction_review_manage'),
    MenuItem('admin_chat_list', '/admin_chat_list'),
    MenuItem('admin_chat_detail', '/admin_chat_detail'),
  ];

  // ✅ MaterialApp(routes:) 에 넣을 라우트 테이블
  // static final Map<String, WidgetBuilder> routes = {
  //   for (final m in menuItems) m.route: (context) => PlaceholderPage(title: m.title),
  // };
}
