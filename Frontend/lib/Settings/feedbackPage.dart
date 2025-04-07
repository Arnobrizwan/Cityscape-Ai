import 'package:flutter/material.dart';
import 'package:kitahack2025/bottomNavigation.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Feedbackpage extends StatefulWidget {
  const Feedbackpage({super.key});

  @override
  State<Feedbackpage> createState() => _FeedbackpageState();
}

class _FeedbackpageState extends State<Feedbackpage> {
  int? selectedIconIndex;

  // Variable to track selected containers
  List<bool> isSelected = List.generate(6, (_) => false);
  List<String> selectedText = [
    "Service",
    "Quantity",
    'Payment',
    'Delivery',
    'Promotion',
    'Gift',
  ];

  // Function to toggle the selection and change the button
  void toggleSelection(int index) {
    setState(() {
      isSelected[index] =
          !isSelected[index]; // Toggle the selection state
    });
  }

  int selectedStars = 0;

  // Function to handle star tap
  void onStarTapped(int index) {
    setState(() {
      selectedStars =
          index +
          1; // Update the selected star count (index starts from 0)
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PhosphorIcon(PhosphorIconsRegular.x),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIconIndex =
                              0; // Update the selected index to 0 (smiley)
                        });
                      },
                      child: PhosphorIcon(
                        PhosphorIconsRegular.smiley,
                        size: 50,
                        color:
                            selectedIconIndex == 0
                                ? Colors.yellow
                                : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIconIndex =
                              1; // Update the selected index to 1 (smileyMeh)
                        });
                      },
                      child: PhosphorIcon(
                        PhosphorIconsRegular.smileyMeh,
                        size: 50,
                        color:
                            selectedIconIndex == 1
                                ? Colors.yellow
                                : Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIconIndex =
                              2; // Update the selected index to 2 (smileyAngry)
                        });
                      },
                      child: PhosphorIcon(
                        PhosphorIconsRegular.smileyAngry,
                        size: 50,
                        color:
                            selectedIconIndex == 2
                                ? Colors.yellow
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Column(
                  children: [
                    Wrap(
                      spacing:
                          10.0, // Space between containers
                      runSpacing:
                          10.0, // Space between rows
                      children: List.generate(6, (index) {
                        return GestureDetector(
                          onTap:
                              () => toggleSelection(
                                index,
                              ), // Toggle selection on tap
                          child: Container(
                            width: 130,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(20),
                              color:
                                  isSelected[index]
                                      ? Colors.yellow
                                      : Colors
                                          .grey, // Change color based on selection
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  selectedText[index], // Dynamic text for each container
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 10),
                                PhosphorIcon(
                                  isSelected[index]
                                      ? PhosphorIconsRegular
                                          .checkCircle // Show check when selected
                                      : PhosphorIconsRegular
                                          .plus, // Show plus when not selected
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Care to share more',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: Text('Type your feedbacks'),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Upload images',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: Colors.grey,
                      ),
                      child: PhosphorIcon(
                        PhosphorIconsRegular.plus,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Rating',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap:
                          () => onStarTapped(
                            index,
                          ), // Handle tap on each star
                      child: Icon(
                        index < selectedStars
                            ? Icons.star
                            : Icons
                                .star_border, // Filled star if selected
                        color:
                            index < selectedStars
                                ? Colors.yellow
                                : Colors
                                    .grey, // Yellow for selected, grey for unselected
                        size: 30, // Star size
                      ),
                    );
                  }),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => BottomNaivgation(
                              onSelect: 3,
                            ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      color: Colors.amberAccent,
                    ),
                    child: Center(child: Text('Submit')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
