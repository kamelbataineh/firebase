// import 'package:flutter/material.dart';
// import 'package:introduction_screen/introduction_screen.dart';
// import 'package:lottie/lottie.dart';
// import 'package:med_project_flutter2/consr_routes.dart';
// import 'package:med_project_flutter2/rented/Screen_register_rented_packg.dart';
// import 'package:med_project_flutter2/user/Screen_register_user.dart';
// import 'package:med_project_flutter2/user/Screen_register_user_page.dart';
//
// class Userorrented extends StatefulWidget {
//   const Userorrented({super.key});
//
//   @override
//   State<Userorrented> createState() => _UserorrentedState();
// }
//
// class _UserorrentedState extends State<Userorrented> {
//   final inkey = GlobalKey<IntroductionScreenState>();
//   final PageController _pageController = PageController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: IntroductionScreen(
//         key: inkey,
//         pages: [
//           PageViewModel(
//             title: "Welcome",
//             body: "",
//             image: Image.asset("imgs/map1.png"),
//             decoration: PageDecoration(
//               titleTextStyle:
//               TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               bodyTextStyle: TextStyle(fontSize: 18),
//               pageColor: Colors.white,
//               imagePadding: EdgeInsets.all(5),
//             ),
//           ),
//           PageViewModel(
//             title: "Welcome",
//             body: "",
//             image:  Image.asset("imgs/map2.png"),
//             decoration: PageDecoration(
//               titleTextStyle:
//               TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               bodyTextStyle: TextStyle(fontSize: 18),
//               pageColor: Colors.white,
//               imagePadding: EdgeInsets.all(5),
//             ),
//           ),
//           PageViewModel(
//             title: "Welcome",
//             body: "",
//             image: Image.asset("imgs/map3.png"),
//             decoration: PageDecoration(
//               titleTextStyle:
//               TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               bodyTextStyle: TextStyle(fontSize: 18),
//               pageColor: Colors.white,
//               imagePadding: EdgeInsets.all(5),
//             ),
//             footer: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.of(context)
//                             .pushReplacementNamed(route_ScreenRegisterRented);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF15b9b4),
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),child: const Text(
//                       'Lessor',
//                       style: TextStyle(fontSize: 18, color: Colors.black),
//                     ),
//                     ),
//                     SizedBox(height: 20),
//
//                     ElevatedButton(
//
//                       onPressed: () {
//                         // Navigator.of(context)
//                         //     .pushReplacementNamed(route_ScreenRegisterUser);
//                         Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => ScreenRegisterUser(),
//                         ));          },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF15b9b4),
//                         padding: EdgeInsets.symmetric(vertical: 10),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Text('Tenant',
//                           style: TextStyle(fontSize: 18, color: Colors.black)),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//         onDone: () {
//           Navigator.of(context).pushReplacementNamed(route_ScreenRegisterUser);
//         },
//         showBackButton: true,
//         back: Text("Back", style: TextStyle(color: Colors.black)),
//         next: Text("Next", style: TextStyle(color: Colors.black)),
//         done: Text(
//           "Done",
//           style: TextStyle(color: Colors.black),
//         ),
//         dotsDecorator: DotsDecorator(
//             size: const Size(10.0, 10.0),
//             color: Color(0xFF15b9b4),
//             activeSize: const Size(22.0, 10.0),
//             activeShape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25.0),
//             ),
//             activeColor: Colors.black),
//       ),
//     );
//     ///////////////////////////////////
//     ///////////////////////////////////
//     ///////////////////////////////////
//     ///////////////////////////////////
// //////////////////////////////////////
//
//     Widget buildTextField(String label, IconData icon, bool required, bool x) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: TextField(
//           decoration: InputDecoration(
//             labelText: label,
//             prefixIcon: Icon(icon, color: Color(0xFF15b9b4)),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           obscureText: x,
//         ),
//       );
//     }
//   }
// }
