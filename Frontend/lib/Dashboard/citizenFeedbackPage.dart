import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CitizenFeedbackPage extends StatefulWidget {
  const CitizenFeedbackPage({super.key});

  @override
  State<CitizenFeedbackPage> createState() =>
      _CitizenFeedbackPageState();
}

class _CitizenFeedbackPageState
    extends State<CitizenFeedbackPage> {
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
                    'Citizen Feedback',
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
                      Text('Search proposals'),
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
                          'Home',
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
                          'Proposals',
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
                          'My Profile',
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
              SizedBox(height: 10),
              onTap == 0
                  ? Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(width: 0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(
                                      8.0,
                                    ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Park Proposal',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Create a community park in the downtown area to provide green space and recreational activities for all ages',
                                      softWrap: true,
                                      // overflow:
                                      //     TextOverflow
                                      //         .ellipsis,
                                      // maxLines: 3,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Submitted: 2 days ago',
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(
                                              horizontal:
                                                  10,
                                              vertical: 5,
                                            ),
                                        child: Text(
                                          'Comment',
                                          style: TextStyle(
                                            color:
                                                Colors
                                                    .amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text('Image'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                          border: Border.all(width: 0),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(
                                      8.0,
                                    ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Text(
                                      'Bike Lanes',
                                      style: TextStyle(
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Develop a network of bike lanes to improve transportation options and reduce traffic congestion',
                                      softWrap: true,
                                      // overflow:
                                      //     TextOverflow
                                      //         .ellipsis,
                                      // maxLines: 3,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Submitted: 5 days ago',
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(
                                              5,
                                            ),
                                        border: Border.all(
                                          color:
                                              Colors.amber,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(
                                              horizontal:
                                                  10,
                                              vertical: 5,
                                            ),
                                        child: Text(
                                          'Comment',
                                          style: TextStyle(
                                            color:
                                                Colors
                                                    .amber,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              child: Text('Image'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : onTap == 1
                  ? Text('Proposals')
                  : Text('My Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
