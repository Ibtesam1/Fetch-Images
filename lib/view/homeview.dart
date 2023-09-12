import  'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:task_beelogix/controller/image_controller.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ImageController _controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Images'),
      ),
      body: Obx(() {//Obx is widget provided by GetX state management it is use to create reactive UI
        if (_controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        else if (_controller.photos.isEmpty) {
          return Center(
            child: Text(
                'Failed to fetch data. Please check your network connection.'),
          );
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,  // the number of columns in the grid
              crossAxisSpacing: 8,  // horizontal spacing between grid items
              mainAxisSpacing: 8,  // vertical spacing between grid items
            ),
            itemCount: _controller.photos.length,
            itemBuilder: (context, index) {
              final photo = _controller.photos[index];
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          radius: 100,
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: photo.url,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          photo.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
