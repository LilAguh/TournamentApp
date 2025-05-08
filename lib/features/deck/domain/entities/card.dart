class Card {
  final int Id;
  final String Name;
  final int Attack;
  final int Defense;
  final String IllustrationUrl;
  final DateTime CreatedAt;
  final int CreatedBy;

  Card({
    required this.Id,
    required this.Name,
    required this.Attack,
    required this.Defense,
    required this.IllustrationUrl,
    required this.CreatedAt,
    required this.CreatedBy,
  });
}
