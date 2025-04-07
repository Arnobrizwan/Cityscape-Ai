import 'package:flutter/material.dart';
import 'package:kitahack2025/Dashboard/dashboardPage.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  int onTap = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {Navigator.pop(context)},
                    child: PhosphorIcon(
                      PhosphorIconsRegular.arrowLeft,
                    ),
                  ),
                  Text(
                    'Chatbot',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  PhosphorIcon(
                    PhosphorIconsRegular.mapPinArea,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIconsRegular
                            .magnifyingGlass,
                      ),
                      SizedBox(width: 5),
                      Text('Search city-related questions'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Navigation
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap:
                        () => {
                          setState(() {
                            onTap = 0;
                          }),
                        },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              onTap == 0
                                  ? BorderSide(
                                    width: 3,
                                    color: Colors.amber,
                                  )
                                  : BorderSide.none,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          'Traffic Info',
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                onTap == 0
                                    ? Colors.amber
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap:
                        () => {
                          setState(() {
                            onTap = 1;
                          }),
                        },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              onTap == 1
                                  ? BorderSide(
                                    width: 3,
                                    color: Colors.amber,
                                  )
                                  : BorderSide.none,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          'Policies',
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                onTap == 1
                                    ? Colors.amber
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap:
                        () => {
                          setState(() {
                            onTap = 2;
                          }),
                        },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              onTap == 2
                                  ? BorderSide(
                                    width: 3,
                                    color: Colors.amber,
                                  )
                                  : BorderSide.none,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        child: Text(
                          'Zoning Laws',
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                onTap == 2
                                    ? Colors.amber
                                    : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              onTap == 0
                  ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                          child: Text(
                            'Retrieve Documents',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                          child: Text(
                            'Back to Dashboard',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : onTap == 1
                  ? Text('Policies')
                  : Text('Zoning Laws'),
            ],
          ),
        ),
      ),
    );
  }
}
