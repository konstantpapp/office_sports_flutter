class Player {
  late String nickname;
  late String emoji;

  Player(this.nickname, this.emoji);

  Player.fromJson(Map<String, dynamic> parsedJson)
      : nickname = parsedJson['nickname'],
        emoji = parsedJson['emoji'];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "nickname": nickname,
      "emoji": emoji,
    };
  }
}
