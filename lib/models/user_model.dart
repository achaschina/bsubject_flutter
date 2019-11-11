// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String name;
    String id;
    String email;
    List<Message> messages;
    List<Note> notes;

    User({
        this.name,
        this.id,
        this.email,
        this.messages,
        this.notes,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        id: json["id"],
        email: json["email"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "email": email,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    };
}

class Message {
    String receiver;
    String text;

    Message({
        this.receiver,
        this.text,
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

class Note {
    String what;
    DateTime when;

    Note({
        this.what,
        this.when,
    });

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        what: json["what"],
        when: DateTime.parse(json["when"]),
    );

    Map<String, dynamic> toJson() => {
        "what": what,
        "when": when.toIso8601String(),
    };
}
