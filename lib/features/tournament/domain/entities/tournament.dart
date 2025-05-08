class Tournament {
  final int Id;
  final String Name;
  final int OrganizerID;
  final DateTime StartDate;
  final DateTime EndDate;
  final String CountryCode;
  final int MaxPlayers;
  final int MaxGames;
  final int CountPlayers;
  final Enum Phase; //aca va phase enum
  final int WinnerID;

  Tournament({
    required this.Id,
    required this.Name,
    required this.OrganizerID,
    required this.StartDate,
    required this.EndDate,
    required this.CountryCode,
    required this.MaxPlayers,
    required this.MaxGames,
    required this.CountPlayers,
    required this.Phase,
    required this.WinnerID,
  });
}
