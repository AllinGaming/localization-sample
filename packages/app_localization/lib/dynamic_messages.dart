import 'messages.i69n.dart';

class DynamicMessages implements Messages {
  final Map<String, dynamic> _data;
  // ignore: unused_field
  final Messages? _parent;

  DynamicMessages(this._data, [this._parent]);

  @override
  GenericMessages get generic => DynamicGenericMessages(_data['generic'] as Map<String, dynamic>? ?? {}, this);

  @override
  MainMessages get main => DynamicMainMessages(_data['main'] as Map<String, dynamic>? ?? {}, this);

  @override
  Object operator [](String key) => _data[key] ?? '';
}

class DynamicGenericMessages implements GenericMessages {
  // ignore: unused_field
  final DynamicMessages _parent;
  final Map<String, dynamic> _data;

  DynamicGenericMessages(this._data, this._parent);

  @override
  String get ok => _data['ok'] as String? ?? 'OK';

  @override
  String get done => _data['done'] as String? ?? 'Done';

  @override
  String get cancel => _data['cancel'] as String? ?? 'Cancel';

  @override
  Object operator [](String key) => _data[key] ?? '';
}

class DynamicMainMessages implements MainMessages {
  final Map<String, dynamic> _data;
  // ignore: unused_field
  final DynamicMessages _parent;

  DynamicMainMessages(this._data, this._parent);

  @override
  String get title => _data['title'] as String? ?? 'Title';

  @override
  String welcome(String name) {
    final template = _data['welcome'] as String? ?? 'Welcome \$name';
    return template.replaceAll('\$name', name);
  }

  @override
  CounterMainMessages get counter => DynamicCounterMessages(_data['counter'] as Map<String, dynamic>? ?? {}, this);

  @override
  Object operator [](String key) => _data[key] ?? '';
}

class DynamicCounterMessages implements CounterMainMessages {
  final Map<String, dynamic> _data;
  // ignore: unused_field
  final DynamicMainMessages _parent;

  DynamicCounterMessages(this._data, this._parent);

  @override
  String get zero => _data['zero'] as String? ?? 'Zero';

  @override
  String get one => _data['one'] as String? ?? 'One';

  @override
  String many(int count) => (_data['many'] as String? ?? 'Many \$count').replaceAll('\$count', count.toString());

  @override
  Object operator [](String key) => _data[key] ?? '';
}
