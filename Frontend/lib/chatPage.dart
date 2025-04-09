// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ChatPage extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _controller =
//       TextEditingController();
//   final FirebaseFirestore _firestore =
//       FirebaseFirestore.instance;
//   String _chatResponse = '';

//   // Function to call the Gemini API and get a response
//   Future<String> getGeminiResponse(String prompt) async {
//     final apiUrl ='https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDuMjLsfRPpu8nDf8Er-LcIlAAVARmYmDA';
        

//     final headers = {'Content-Type': 'application/json'};

//     final body = json.encode({
//       'contents': [
//         {
//           'parts': [
//             {'text': prompt},
//           ],
//         },
//       ],
//     });

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: headers,
//         body: body,
//       );

//       // Log the response
//       print("Gemini API Response: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         // Correctly extract the response text from the 'candidates' field
//         return data['candidates'][0]['content']['parts'][0]['text'];
//       } else {
//         throw Exception('Failed to load response');
//       }
//     } catch (e) {
//       throw Exception('Error: $e');
//     }
//   }

//   // Send message to Firestore and get response from Gemini API
//   Future<void> _sendMessage(String message) async {
//     if (message.isNotEmpty) {
//       // Save the user message to Firestore
//       await _firestore.collection('messages').add({
//         'text': message,
//         'sender': 'user',
//         'timestamp': FieldValue.serverTimestamp(),
//       });

//       // Call the Gemini API to get the response
//       try {
//         final aiResponse = await getGeminiResponse(message);

//         // Save the AI response to Firestore
//         await _firestore.collection('messages').add({
//           'text': aiResponse,
//           'sender': 'bot',
//           'timestamp': FieldValue.serverTimestamp(),
//         });

//         // Update UI with the AI response
//         setState(() {
//           _chatResponse = aiResponse;
//         });
//       } catch (e) {
//         setState(() {
//           _chatResponse = 'Error: $e';
//         });
//       }

//       // Clear the text input field
//       _controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('AI Chatbot')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream:
//                   _firestore
//                       .collection('messages')
//                       .orderBy('timestamp')
//                       .snapshots(),
//               builder: (ctx, snapshot) {
//                 if (snapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }

//                 final messages = snapshot.data?.docs ?? [];
//                 return ListView.builder(
//                   itemCount: messages.length,
//                   itemBuilder: (ctx, index) {
//                     final message = messages[index];
//                     final text = message['text'] as String;
//                     final sender =
//                         message['sender'] as String;

//                     return ListTile(
//                       title: Text(text),
//                       subtitle: Text(sender),
//                       tileColor:
//                           sender == 'user'
//                               ? Colors.blue[100]
//                               : Colors.green[100],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: () {
//                     _sendMessage(_controller.text);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/firebase_token_service.dart'; // ✅ Import the token service

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _chatResponse = '';

  // ✅ Function to call your ML backend securely
  // Future<String> getGeminiResponse(String prompt) async {
  //   final token = await getIdToken();

  //   final apiUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyDuMjLsfRPpu8nDf8Er-LcIlAAVARmYmDA'; 

  //   final headers = {
  //     'Content-Type': 'application/json',
  //     if (token != null) 'Authorization': 'Bearer $token',
  //   };

  //   final body = json.encode({'prompt': prompt});

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: headers,
  //       body: body,
  //     );

  //     print("ML Backend Response: ${response.body}");

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       return data['response'] ?? '⚠️ No response from backend.';
  //     } else {
  //       return '❌ Backend error: ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     return '⚠️ Error contacting ML backend: $e';
  //   }
  // }

  Future<String> getGeminiResponse(String prompt) async {
  final token = await getIdToken();

  // final apiUrl = 'http://10.0.2.2:8000/ask';// ✅ local server from Android Emulator

final apiUrl = 'https://448d-2001-e68-824e-b800-a96c-653a-d863-f917.ngrok-free.app/ask'; 
  final headers = {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };

  final body = json.encode({'prompt': prompt});

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    print("ML Backend Response: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['response'] ?? '⚠️ No response from backend.';
    } else {
      return '❌ Backend error: ${response.statusCode}';
    }
  } catch (e) {
    return '⚠️ Error contacting ML backend: $e';
  }
}

  // Send message to Firestore and get response from Gemini API
  Future<void> _sendMessage(String message) async {
    if (message.isNotEmpty) {
      // Save the user message to Firestore
      await _firestore.collection('messages').add({
        'text': message,
        'sender': 'user',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Call the ML backend to get the response
      try {
        final aiResponse = await getGeminiResponse(message);

        // Save the AI response to Firestore
        await _firestore.collection('messages').add({
          'text': aiResponse,
          'sender': 'bot',
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Update UI with the AI response
        setState(() {
          _chatResponse = aiResponse;
        });
      } catch (e) {
        setState(() {
          _chatResponse = 'Error: $e';
        });
      }

      // Clear the text input field
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AI Chatbot')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (ctx, index) {
                    final message = messages[index];
                    final text = message['text'] as String;
                    final sender = message['sender'] as String;

                    return ListTile(
                      title: Text(text),
                      subtitle: Text(sender),
                      tileColor: sender == 'user' ? Colors.blue[100] : Colors.green[100],
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
