// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String name;
    String id;
    List<Message> messages;
    List<dynamic> notes;

    User({
        @required this.name,
        @required this.id,
        @required this.messages,
        @required this.notes,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "notes": List<dynamic>.from(notes.map((x) => x)),
    };
}

class Message {
    String receiver;
    String text;

    Message({
        @required this.receiver,
        @required this.text,
    });

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        receiver: json["receiver"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "receiver": receiver,
        "text": text,
    };
}
