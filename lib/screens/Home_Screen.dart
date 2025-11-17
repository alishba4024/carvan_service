// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int selectedTab = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // Header
//           Container(
//             padding: const EdgeInsets.only(
//               left: 20,
//               right: 20,
//               top: 100,
//               bottom: 20,
//             ),
//             decoration: const BoxDecoration(
//               color: Color(0xff173EA6),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//               image: const DecorationImage(
//                 image: AssetImage(
//                   "assets/images/header.png",
//                 ), // your image path
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Row(
//               children: [
//                 // Logo
//                 Image.asset("assets/images/homelogo.png", height: 50),
//                 const Spacer(),
//                 // Notification & Settings Icons
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.notifications_none,
//                     color: Color(0xff173EA6),
//                     size: 20,
//                   ),
//                 ),
//                 const SizedBox(width: 11),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.settings,
//                     color: Color(0xff173EA6),
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 30),

//           // Tabs
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               tabButton(
//                 title: "Create Report",
//                 icon: Icons.add_circle_sharp,
//                 active: selectedTab == 0,
//                 onTap: () {
//                   setState(() => selectedTab = 0);
//                 },
//               ),

//               tabButton(
//                 title: "Open Report",
//                 icon: Icons.folder_open_outlined,
//                 active: selectedTab == 1,
//                 onTap: () {
//                   setState(() => selectedTab = 1);
//                 },
//               ),
//             ],
//           ),

//           const SizedBox(height: 15),

//           // Card
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Container(
//                 color: Colors.white,
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(18),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Blue DOC Banner
//                     Container(
//                       height: 200,
//                       decoration: BoxDecoration(
//                         color: const Color(0xff173EA6),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Center(
//                         child: Image.asset(
//                           "assets/images/doc.png",
//                           height: 110,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     const Text(
//                       "Motorhome Annual Habitation Service Finalisation & Observation Report",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const SizedBox(height: 5),

//                     const Text(
//                       "Lorem Ipsum is simply dummy text of the printing.",
//                       style: TextStyle(fontSize: 12, color: Colors.grey),
//                     ),

//                     const SizedBox(height: 10),

//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton.icon(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.add_circle_sharp,
//                           size: 18,
//                           color: Color(0xff173EA6),
//                         ),
//                         label: const Text(
//                           "Create Report",
//                           style: TextStyle(
//                             color: Color(0xff173EA6),
//                             fontFamily: 'PolySans',
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget tabButton({
//     required String title,
//     required IconData icon,
//     required bool active,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Icon(
//                 icon,
//                 size: 18,
//                 color: active ? const Color(0xff173EA6) : Colors.grey,
//               ),
//               const SizedBox(width: 5),
//               Text(
//                 title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   color: active ? const Color(0xff173EA6) : Colors.grey,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Container(
//             height: 2,
//             width: 120,
//             color: active ? const Color(0xff173EA6) : Colors.transparent,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:data/screens/Settings.dart';
import 'package:data/screens/engine_vehicle_service_form.dart';
import 'package:data/screens/main_form_screen.dart';
import 'package:data/screens/safety_inspection_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  //List of Reports (Loop Data)
  List<Map<String, String>> reports = [
    {
      "title":
          "Motorhome Annual Habitation Service Finalisation & Observation Report",
      "subtitle": "Lorem Ipsum is simply dummy text of the printing.",
    },
    {
      "title": "Motorhome Habitation Damp Report",
      "subtitle": "Lorem Ipsum is simply dummy text.",
    },
    {
      "title": "Tourer Annual Service Check Sheet",
      "subtitle": "Dummy text printing and typesetting.",
    },
    {
      "title": "Safety Inspection Report",
      "subtitle": "Lorem Ipsum simply dummy text.",
    },
    {
      "title": "Tourer Damp Report",
      "subtitle": "Lorem Ipsum simply dummy text.",
    },
    {
      "title": "Engine / Vehicle Service",
      "subtitle": "Lorem Ipsum simply dummy text.",
    },
    {
      "title": "Service Check List",
      "subtitle": "Lorem Ipsum simply dummy text.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //  Header
          Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 100,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xff173EA6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/header.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: [
                Image.asset("assets/images/homelogo.png", height: 50),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    color: Color(0xff173EA6),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 11),
                GestureDetector(
                  onTap: () {
                    Get.to(() => Settings()); // Navigate to settings screen
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.settings,
                      color: Color(0xff173EA6),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Tabs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              tabButton(
                title: "Create Report",
                icon: Icons.add_circle_sharp,
                active: selectedTab == 0,
                onTap: () => setState(() => selectedTab = 0),
              ),
              tabButton(
                title: "Open Report",
                icon: Icons.folder_open_outlined,
                active: selectedTab == 1,
                onTap: () => setState(() => selectedTab = 1),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // Cards
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // banner box
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: const Color(0xff173EA6),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/images/doc.png",
                                height: 110,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            report["title"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),

                          Text(
                            report["subtitle"]!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 10),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () {
                                if (index == 0) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MainFormScreen(),
                                    ),
                                  );
                                } else if (index == 5) {
                                  // Engine / Vehicle Service card (6th card, index 5)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              EngineVehicleServiceForm(),
                                    ),
                                  );
                                } else if (index == 3) {
                                  // Engine / Vehicle Service card (6th card, index 5)
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => SafetyInspectionForm(),
                                    ),
                                  );
                                }
                              },
                              icon: const Icon(
                                Icons.add_circle_sharp,
                                size: 18,
                                color: Color(0xff173EA6),
                              ),
                              label: const Text(
                                "Create Report",
                                style: TextStyle(
                                  color: Color(0xff173EA6),
                                  fontFamily: 'PolySans',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  //Tab Button UI
  Widget tabButton({
    required String title,
    required IconData icon,
    required bool active,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: active ? const Color(0xff173EA6) : Colors.grey,
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: active ? const Color(0xff173EA6) : Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 120,
            color: active ? const Color(0xff173EA6) : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
