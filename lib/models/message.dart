class MessageModel {
  final String id;
  final String body;
  final int delay;
  final int no;
  // final int coins;
  // final int referralCoins;

  MessageModel({
    required this.id,
    required this.body,
    required this.delay,
    required this.no,
    // required this.coins,
    // required this.referralCoins,
  });

  factory MessageModel.fromMap(dynamic json) {
    return MessageModel(
      id: json['id'],
      body: json['body'],
      delay: json['delay'],
      // coins: json['coins'],
      no: json['no'],
      // referralCoins: json['referralCoins'],
    );
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['delay'] = delay;
    data['no'] = no;
    // data['coins'] = coins;
    // data['referralCoins'] = referralCoins;
    return data;
  }
}
