class Todo {
  Todo({
    required this.name,
    required this.checked,
  });

  final String name;
  bool checked;

  Todo copyWith({
    String? name,
    bool? checked,
  }) =>
      Todo(
        name: name ?? this.name,
        checked: checked ?? this.checked,
      );
}
