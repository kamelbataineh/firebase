// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoAdd extends StatefulWidget {
//   const VideoAdd({super.key});
//
//   @override
//   State<VideoAdd> createState() => _VideoAddState();
// }
//
// class _VideoAddState extends State<VideoAdd> {
//   File? videoFile;
//   VideoPlayerController? videoController;
//
//   @override
//   void dispose() {
//     videoController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: () {
//                 pickVideo();
//               },
//               child: Text("Pick Video"),
//             ),
//             SizedBox(height: 20),
//             videoFile != null && videoController != null
//                 ? AspectRatio(
//               aspectRatio: videoController!.value.aspectRatio,
//               child: VideoPlayer(videoController!),
//             )
//                 : Image.network(
//               "https://www.w3schools.com/w3images/avatar2.png",
//               height: 100,
//               width: 100,
//             ),
//             SizedBox(height: 20),
//             if (videoController != null && videoController!.value.isInitialized)
//               IconButton(
//                 icon: Icon(
//                   videoController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     videoController!.value.isPlaying
//                         ? videoController!.pause()
//                         : videoController!.play();
//                   });
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void pickVideo() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
//
//     if (pickedVideo != null) {
//       setState(() {
//         videoFile = File(pickedVideo.path);
//         videoController?.dispose();
//         videoController = VideoPlayerController.file(videoFile!)
//           ..initialize().then((_) {
//             setState(() {});
//           });
//       });
//     }
//   }
// }
