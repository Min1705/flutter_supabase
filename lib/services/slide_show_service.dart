// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:test_supabase/app/supabase_client.dart';
//
// class SlideShowService {
//   final SupabaseClient _client = SupabaseClientInstance.client;
//
//   Future<List<String>> getCategories() async {
//     // Lấy kết quả từ Supabase
//     final response = await _client
//         .from('products')
//         .select('image_url')
//         .order('price', ascending: false)
//         .limit(5); // Đảm bảo gọi .execute() để thực thi truy vấn
//
//     // Kiểm tra dữ liệu trong response
//     if (response.isEmpty) {
//       throw Exception('No data returned from Supabase');
//     }
//
//     // Lấy dữ liệu từ response và ép kiểu
//     final List<dynamic> data =
//         response as List<dynamic>; // data là List<dynamic> chứa các bản ghi
//
//     // Trả về danh sách các image_url dưới dạng List<String>
//     return data.map((record) => record['image_url'] as String).toList();
//   }
// }
//
// // class SlideShowService {
// //   final SupabaseClient _client = SupabaseClientInstance.client;
// //
// //   Future<List<String>> getCategories() async {
// //     final response = await _client
// //         .from('products')
// //         .select('image_url')
// //         .order('price', ascending: false)
// //         .limit(5);
// //
// //     if (response == null || response.isEmpty) {
// //       throw Exception('No data returned from Supabase');
// //     }
// //
// //     return List<String>.from(response as List);
// //   }
// // }
