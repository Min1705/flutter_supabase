// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import '../services/slide_show_service.dart';
// import '../widgets/bottom_navigation_bar.dart';
//
// class SlideShowScreen extends StatefulWidget {
//   final SlideShowService slideShowService;
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//
//   const SlideShowScreen(
//       {required this.slideShowService,
//       super.key,
//       required this.currentIndex,
//       required this.onTap});
//
//   @override
//   State<SlideShowScreen> createState() => _SlideShowScreenState();
// }
//
// class _SlideShowScreenState extends State<SlideShowScreen> {
//   late Future<List<String>> _imageUrls;
//
//   @override
//   void initState() {
//     super.initState();
//     // Trì hoãn tải dữ liệu ảnh sau 0 giây
//     Future.delayed(const Duration(seconds: 0), () {
//       setState(() {
//         _imageUrls = widget.slideShowService.getCategories();
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<String>>(
//       future: _imageUrls,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return const Center(child: Text('No images found.'));
//         }
//
//         final imageUrls = snapshot.data!;
//         return Scaffold(
//           body: Stack(
//             children: [
//               Positioned(
//                 top: 30, // Căn lên phía trên màn hình
//                 left: 0,
//                 right: 0, // Tràn hết chiều rộng màn hình
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 300, // Điều chỉnh chiều cao của slideshow
//                   child: ImageSlideshow(
//                     width: double.infinity,
//                     height: double.infinity,
//                     initialPage: 0,
//                     indicatorColor: Colors.blue,
//                     indicatorBackgroundColor: Colors.grey,
//                     autoPlayInterval: 2000,
//                     isLoop: true,
//                     onPageChanged: (value) {
//                       print('Page changed: $value');
//                     },
//                     children: imageUrls.map((url) {
//                       return Image.network(
//                         url,
//                         fit: BoxFit.cover,
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//               // Các widget khác có thể thêm ở đây nếu cần
//             ],
//           ),
//           bottomNavigationBar: CustomBottomNavigationBar(
//             currentIndex: widget.currentIndex,
//             onTap: widget.onTap,
//           ),
//         );
//       },
//     );
//   }
// }
