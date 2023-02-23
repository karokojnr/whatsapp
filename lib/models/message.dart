class Message {
  String text;
  String myUid;
  String time;

  Message({
    required this.text,
    required this.myUid,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'myUid': myUid,
      'time': time,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      myUid: json['myUid'],
      time: json['time'],
    );
  }
}
