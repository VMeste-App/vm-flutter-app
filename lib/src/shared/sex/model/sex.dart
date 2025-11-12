typedef SexID = int;

enum Sex {
  male(0),
  female(1),
  mixed(2);

  final SexID id;

  const Sex(this.id);
}
