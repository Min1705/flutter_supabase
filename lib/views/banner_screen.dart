import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:test_supabase/services/banner_service.dart';
import '../widgets/bottom_navigation_bar.dart';

class BannerScreen extends StatefulWidget {
  final BannerService bannerService;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BannerScreen(
      {super.key,
      required this.bannerService,
      required this.currentIndex,
      required this.onTap});

  @override
  State<BannerScreen> createState() => _BannerScreen();
}

class _BannerScreen extends State<BannerScreen> {
  late Future<List<String>> _Urls;

  @override
  void initState() {
    super.initState();
    // Trì hoãn tải dữ liệu ảnh sau 0 giây
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _Urls = widget.bannerService.getBanner();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _Urls,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No images found.'));
        }
        final imageUrls = snapshot.data!;
        return Scaffold(
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 250, // Điều chỉnh chiều cao của slideshow
                child: ImageSlideshow(
                  width: double.infinity,
                  height: double.infinity,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  autoPlayInterval: 2000,
                  isLoop: true,
                  onPageChanged: (value) {
                    print('Page changed: $value');
                  },
                  children: imageUrls.map((url) {
                    return Image.network(
                      url,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => print('Button 1 pressed'),
                    child: const Text(
                      'Laptop',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Button 2 pressed'),
                    child: const Text(
                      'PC',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Button 3 pressed'),
                    child: const Text(
                      'Phone',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Button 4 pressed'),
                    child: const Text(
                      'Ipad',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => print('Button 5 pressed'),
                    child: const Text(
                      'All',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => HomeScreen()),
              //     );
              //   },
              //   child: Text('Go to Home Screen'),
              // ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigationBar(
                    currentIndex: widget.currentIndex,
                    onTap: widget.onTap,
                  ),
                ),
              ),
            ],
          ),
        );

        // return Scaffold(
        //   body: Stack(
        //     children: [
        //       Positioned(
        //         top: 10, // Căn lên phía trên màn hình
        //         left: 10,
        //         right: 10, // Tràn hết chiều rộng màn hình
        //         child: Container(
        //           width: double.infinity,
        //           height: 300, // Điều chỉnh chiều cao của slideshow
        //           child: ImageSlideshow(
        //             width: double.infinity,
        //             height: double.infinity,
        //             initialPage: 0,
        //             indicatorColor: Colors.blue,
        //             indicatorBackgroundColor: Colors.grey,
        //             children: imageUrls.map((url) {
        //               return Image.network(
        //                 url,
        //                 fit: BoxFit.cover,
        //               );
        //             }).toList(),
        //             autoPlayInterval: 2000,
        //             isLoop: true,
        //             onPageChanged: (value) {
        //               print('Page changed: $value');
        //             },
        //           ),
        //         ),
        //       ),
        //       // Các widget khác có thể thêm ở đây nếu cần
        //     ],
        //   ),
        //   bottomNavigationBar: CustomBottomNavigationBar(
        //     currentIndex: widget.currentIndex,
        //     onTap: widget.onTap,
        //   ),
        // );
      },
    );
  }
}
