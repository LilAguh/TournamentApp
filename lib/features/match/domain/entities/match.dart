class Match {
  final int Id;
  final int TournamentID;
  final int MatchNumber;
  final int TotalMatches;
  final int Player1ID;
  final int Player2ID;
  final DateTime MatchStartTime;
  final Enum Status; //aca va matchenum
  final int WinnerID;

  Match({
    required this.Id,
    required this.TournamentID,
    required this.MatchNumber,
    required this.TotalMatches,
    required this.Player1ID,
    required this.Player2ID,
    required this.MatchStartTime,
    required this.Status,
    required this.WinnerID,
  });
}
