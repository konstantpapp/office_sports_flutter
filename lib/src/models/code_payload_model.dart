class CodePayload {
  final String userId;
  final String nickname;
  final int sport;

  CodePayload(this.userId, this.nickname, this.sport);

  CodePayload.fromJson(Map<String, dynamic> parsedJson)
      : userId = parsedJson['userId'],
        nickname = parsedJson['nickname'],
        sport = parsedJson['sport'];

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "nickname": nickname,
      "sport": sport,
    };
  }
}
