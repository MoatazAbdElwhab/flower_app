import 'package:gql/ast.dart';

class Input$LoginInput {
  factory Input$LoginInput({
    required String email,
    required String password,
  }) =>
      Input$LoginInput._({
        r'email': email,
        r'password': password,
      });

  Input$LoginInput._(this._$data);

  factory Input$LoginInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Input$LoginInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Input$LoginInput<Input$LoginInput> get copyWith =>
      CopyWith$Input$LoginInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$LoginInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$password = password;
    return Object.hashAll([
      l$email,
      l$password,
    ]);
  }
}

abstract class CopyWith$Input$LoginInput<TRes> {
  factory CopyWith$Input$LoginInput(
    Input$LoginInput instance,
    TRes Function(Input$LoginInput) then,
  ) = _CopyWithImpl$Input$LoginInput;

  factory CopyWith$Input$LoginInput.stub(TRes res) =
      _CopyWithStubImpl$Input$LoginInput;

  TRes call({
    String? email,
    String? password,
  });
}

class _CopyWithImpl$Input$LoginInput<TRes>
    implements CopyWith$Input$LoginInput<TRes> {
  _CopyWithImpl$Input$LoginInput(
    this._instance,
    this._then,
  );

  final Input$LoginInput _instance;

  final TRes Function(Input$LoginInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? email = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Input$LoginInput._({
        ..._instance._$data,
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Input$LoginInput<TRes>
    implements CopyWith$Input$LoginInput<TRes> {
  _CopyWithStubImpl$Input$LoginInput(this._res);

  TRes _res;

  call({
    String? email,
    String? password,
  }) =>
      _res;
}

class Input$SignUpInput {
  factory Input$SignUpInput({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    String? phone,
    String? gender,
  }) =>
      Input$SignUpInput._({
        r'firstName': firstName,
        r'lastName': lastName,
        r'email': email,
        r'password': password,
        r'rePassword': rePassword,
        if (phone != null) r'phone': phone,
        if (gender != null) r'gender': gender,
      });

  Input$SignUpInput._(this._$data);

  factory Input$SignUpInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$firstName = data['firstName'];
    result$data['firstName'] = (l$firstName as String);
    final l$lastName = data['lastName'];
    result$data['lastName'] = (l$lastName as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    final l$rePassword = data['rePassword'];
    result$data['rePassword'] = (l$rePassword as String);
    if (data.containsKey('phone')) {
      final l$phone = data['phone'];
      result$data['phone'] = (l$phone as String?);
    }
    if (data.containsKey('gender')) {
      final l$gender = data['gender'];
      result$data['gender'] = (l$gender as String?);
    }
    return Input$SignUpInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get firstName => (_$data['firstName'] as String);

  String get lastName => (_$data['lastName'] as String);

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  String get rePassword => (_$data['rePassword'] as String);

  String? get phone => (_$data['phone'] as String?);

  String? get gender => (_$data['gender'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$firstName = firstName;
    result$data['firstName'] = l$firstName;
    final l$lastName = lastName;
    result$data['lastName'] = l$lastName;
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    final l$rePassword = rePassword;
    result$data['rePassword'] = l$rePassword;
    if (_$data.containsKey('phone')) {
      final l$phone = phone;
      result$data['phone'] = l$phone;
    }
    if (_$data.containsKey('gender')) {
      final l$gender = gender;
      result$data['gender'] = l$gender;
    }
    return result$data;
  }

  CopyWith$Input$SignUpInput<Input$SignUpInput> get copyWith =>
      CopyWith$Input$SignUpInput(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$SignUpInput || runtimeType != other.runtimeType) {
      return false;
    }
    final l$firstName = firstName;
    final lOther$firstName = other.firstName;
    if (l$firstName != lOther$firstName) {
      return false;
    }
    final l$lastName = lastName;
    final lOther$lastName = other.lastName;
    if (l$lastName != lOther$lastName) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    final l$rePassword = rePassword;
    final lOther$rePassword = other.rePassword;
    if (l$rePassword != lOther$rePassword) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (_$data.containsKey('phone') != other._$data.containsKey('phone')) {
      return false;
    }
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$gender = gender;
    final lOther$gender = other.gender;
    if (_$data.containsKey('gender') != other._$data.containsKey('gender')) {
      return false;
    }
    if (l$gender != lOther$gender) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$firstName = firstName;
    final l$lastName = lastName;
    final l$email = email;
    final l$password = password;
    final l$rePassword = rePassword;
    final l$phone = phone;
    final l$gender = gender;
    return Object.hashAll([
      l$firstName,
      l$lastName,
      l$email,
      l$password,
      l$rePassword,
      _$data.containsKey('phone') ? l$phone : const {},
      _$data.containsKey('gender') ? l$gender : const {},
    ]);
  }
}

abstract class CopyWith$Input$SignUpInput<TRes> {
  factory CopyWith$Input$SignUpInput(
    Input$SignUpInput instance,
    TRes Function(Input$SignUpInput) then,
  ) = _CopyWithImpl$Input$SignUpInput;

  factory CopyWith$Input$SignUpInput.stub(TRes res) =
      _CopyWithStubImpl$Input$SignUpInput;

  TRes call({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  });
}

class _CopyWithImpl$Input$SignUpInput<TRes>
    implements CopyWith$Input$SignUpInput<TRes> {
  _CopyWithImpl$Input$SignUpInput(
    this._instance,
    this._then,
  );

  final Input$SignUpInput _instance;

  final TRes Function(Input$SignUpInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? firstName = _undefined,
    Object? lastName = _undefined,
    Object? email = _undefined,
    Object? password = _undefined,
    Object? rePassword = _undefined,
    Object? phone = _undefined,
    Object? gender = _undefined,
  }) =>
      _then(Input$SignUpInput._({
        ..._instance._$data,
        if (firstName != _undefined && firstName != null)
          'firstName': (firstName as String),
        if (lastName != _undefined && lastName != null)
          'lastName': (lastName as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
        if (rePassword != _undefined && rePassword != null)
          'rePassword': (rePassword as String),
        if (phone != _undefined) 'phone': (phone as String?),
        if (gender != _undefined) 'gender': (gender as String?),
      }));
}

class _CopyWithStubImpl$Input$SignUpInput<TRes>
    implements CopyWith$Input$SignUpInput<TRes> {
  _CopyWithStubImpl$Input$SignUpInput(this._res);

  TRes _res;

  call({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? rePassword,
    String? phone,
    String? gender,
  }) =>
      _res;
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

class Query$GetCurrentUser {
  Query$GetCurrentUser({
    this.me,
    this.$__typename = 'Query',
  });

  factory Query$GetCurrentUser.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    final l$$__typename = json['__typename'];
    return Query$GetCurrentUser(
      me: l$me == null
          ? null
          : Query$GetCurrentUser$me.fromJson((l$me as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$GetCurrentUser$me? me;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$me = me;
    _resultData['me'] = l$me?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$me = me;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$me,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCurrentUser || runtimeType != other.runtimeType) {
      return false;
    }
    final l$me = me;
    final lOther$me = other.me;
    if (l$me != lOther$me) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCurrentUser on Query$GetCurrentUser {
  CopyWith$Query$GetCurrentUser<Query$GetCurrentUser> get copyWith =>
      CopyWith$Query$GetCurrentUser(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetCurrentUser<TRes> {
  factory CopyWith$Query$GetCurrentUser(
    Query$GetCurrentUser instance,
    TRes Function(Query$GetCurrentUser) then,
  ) = _CopyWithImpl$Query$GetCurrentUser;

  factory CopyWith$Query$GetCurrentUser.stub(TRes res) =
      _CopyWithStubImpl$Query$GetCurrentUser;

  TRes call({
    Query$GetCurrentUser$me? me,
    String? $__typename,
  });
  CopyWith$Query$GetCurrentUser$me<TRes> get me;
}

class _CopyWithImpl$Query$GetCurrentUser<TRes>
    implements CopyWith$Query$GetCurrentUser<TRes> {
  _CopyWithImpl$Query$GetCurrentUser(
    this._instance,
    this._then,
  );

  final Query$GetCurrentUser _instance;

  final TRes Function(Query$GetCurrentUser) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? me = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCurrentUser(
        me: me == _undefined ? _instance.me : (me as Query$GetCurrentUser$me?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$GetCurrentUser$me<TRes> get me {
    final local$me = _instance.me;
    return local$me == null
        ? CopyWith$Query$GetCurrentUser$me.stub(_then(_instance))
        : CopyWith$Query$GetCurrentUser$me(local$me, (e) => call(me: e));
  }
}

class _CopyWithStubImpl$Query$GetCurrentUser<TRes>
    implements CopyWith$Query$GetCurrentUser<TRes> {
  _CopyWithStubImpl$Query$GetCurrentUser(this._res);

  TRes _res;

  call({
    Query$GetCurrentUser$me? me,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$GetCurrentUser$me<TRes> get me =>
      CopyWith$Query$GetCurrentUser$me.stub(_res);
}

const documentNodeQueryGetCurrentUser = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'GetCurrentUser'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'me'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: '_id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'email'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'phone'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'gender'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'profileImg'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'role'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'wishlist'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'addresses'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: '_id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'street'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'city'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'phone'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'lat'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'long'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Query$GetCurrentUser$me {
  Query$GetCurrentUser$me({
    required this.$_id,
    required this.name,
    required this.email,
    this.phone,
    this.gender,
    this.profileImg,
    this.role,
    this.wishlist,
    this.addresses,
    this.$__typename = 'User',
  });

  factory Query$GetCurrentUser$me.fromJson(Map<String, dynamic> json) {
    final l$$_id = json['_id'];
    final l$name = json['name'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$gender = json['gender'];
    final l$profileImg = json['profileImg'];
    final l$role = json['role'];
    final l$wishlist = json['wishlist'];
    final l$addresses = json['addresses'];
    final l$$__typename = json['__typename'];
    return Query$GetCurrentUser$me(
      $_id: (l$$_id as String),
      name: (l$name as String),
      email: (l$email as String),
      phone: (l$phone as String?),
      gender: (l$gender as String?),
      profileImg: (l$profileImg as String?),
      role: (l$role as String?),
      wishlist:
          (l$wishlist as List<dynamic>?)?.map((e) => (e as String?)).toList(),
      addresses: (l$addresses as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : Query$GetCurrentUser$me$addresses.fromJson(
                  (e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final String $_id;

  final String name;

  final String email;

  final String? phone;

  final String? gender;

  final String? profileImg;

  final String? role;

  final List<String?>? wishlist;

  final List<Query$GetCurrentUser$me$addresses?>? addresses;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$_id = $_id;
    _resultData['_id'] = l$$_id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$gender = gender;
    _resultData['gender'] = l$gender;
    final l$profileImg = profileImg;
    _resultData['profileImg'] = l$profileImg;
    final l$role = role;
    _resultData['role'] = l$role;
    final l$wishlist = wishlist;
    _resultData['wishlist'] = l$wishlist?.map((e) => e).toList();
    final l$addresses = addresses;
    _resultData['addresses'] = l$addresses?.map((e) => e?.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$_id = $_id;
    final l$name = name;
    final l$email = email;
    final l$phone = phone;
    final l$gender = gender;
    final l$profileImg = profileImg;
    final l$role = role;
    final l$wishlist = wishlist;
    final l$addresses = addresses;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$$_id,
      l$name,
      l$email,
      l$phone,
      l$gender,
      l$profileImg,
      l$role,
      l$wishlist == null ? null : Object.hashAll(l$wishlist.map((v) => v)),
      l$addresses == null ? null : Object.hashAll(l$addresses.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCurrentUser$me || runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id = $_id;
    final lOther$$_id = other.$_id;
    if (l$$_id != lOther$$_id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$gender = gender;
    final lOther$gender = other.gender;
    if (l$gender != lOther$gender) {
      return false;
    }
    final l$profileImg = profileImg;
    final lOther$profileImg = other.profileImg;
    if (l$profileImg != lOther$profileImg) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$wishlist = wishlist;
    final lOther$wishlist = other.wishlist;
    if (l$wishlist != null && lOther$wishlist != null) {
      if (l$wishlist.length != lOther$wishlist.length) {
        return false;
      }
      for (int i = 0; i < l$wishlist.length; i++) {
        final l$wishlist$entry = l$wishlist[i];
        final lOther$wishlist$entry = lOther$wishlist[i];
        if (l$wishlist$entry != lOther$wishlist$entry) {
          return false;
        }
      }
    } else if (l$wishlist != lOther$wishlist) {
      return false;
    }
    final l$addresses = addresses;
    final lOther$addresses = other.addresses;
    if (l$addresses != null && lOther$addresses != null) {
      if (l$addresses.length != lOther$addresses.length) {
        return false;
      }
      for (int i = 0; i < l$addresses.length; i++) {
        final l$addresses$entry = l$addresses[i];
        final lOther$addresses$entry = lOther$addresses[i];
        if (l$addresses$entry != lOther$addresses$entry) {
          return false;
        }
      }
    } else if (l$addresses != lOther$addresses) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCurrentUser$me on Query$GetCurrentUser$me {
  CopyWith$Query$GetCurrentUser$me<Query$GetCurrentUser$me> get copyWith =>
      CopyWith$Query$GetCurrentUser$me(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$GetCurrentUser$me<TRes> {
  factory CopyWith$Query$GetCurrentUser$me(
    Query$GetCurrentUser$me instance,
    TRes Function(Query$GetCurrentUser$me) then,
  ) = _CopyWithImpl$Query$GetCurrentUser$me;

  factory CopyWith$Query$GetCurrentUser$me.stub(TRes res) =
      _CopyWithStubImpl$Query$GetCurrentUser$me;

  TRes call({
    String? $_id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? profileImg,
    String? role,
    List<String?>? wishlist,
    List<Query$GetCurrentUser$me$addresses?>? addresses,
    String? $__typename,
  });
  TRes addresses(
      Iterable<Query$GetCurrentUser$me$addresses?>? Function(
              Iterable<
                  CopyWith$Query$GetCurrentUser$me$addresses<
                      Query$GetCurrentUser$me$addresses>?>?)
          _fn);
}

class _CopyWithImpl$Query$GetCurrentUser$me<TRes>
    implements CopyWith$Query$GetCurrentUser$me<TRes> {
  _CopyWithImpl$Query$GetCurrentUser$me(
    this._instance,
    this._then,
  );

  final Query$GetCurrentUser$me _instance;

  final TRes Function(Query$GetCurrentUser$me) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id = _undefined,
    Object? name = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? gender = _undefined,
    Object? profileImg = _undefined,
    Object? role = _undefined,
    Object? wishlist = _undefined,
    Object? addresses = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCurrentUser$me(
        $_id: $_id == _undefined || $_id == null
            ? _instance.$_id
            : ($_id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        phone: phone == _undefined ? _instance.phone : (phone as String?),
        gender: gender == _undefined ? _instance.gender : (gender as String?),
        profileImg: profileImg == _undefined
            ? _instance.profileImg
            : (profileImg as String?),
        role: role == _undefined ? _instance.role : (role as String?),
        wishlist: wishlist == _undefined
            ? _instance.wishlist
            : (wishlist as List<String?>?),
        addresses: addresses == _undefined
            ? _instance.addresses
            : (addresses as List<Query$GetCurrentUser$me$addresses?>?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes addresses(
          Iterable<Query$GetCurrentUser$me$addresses?>? Function(
                  Iterable<
                      CopyWith$Query$GetCurrentUser$me$addresses<
                          Query$GetCurrentUser$me$addresses>?>?)
              _fn) =>
      call(
          addresses: _fn(_instance.addresses?.map((e) => e == null
              ? null
              : CopyWith$Query$GetCurrentUser$me$addresses(
                  e,
                  (i) => i,
                )))?.toList());
}

class _CopyWithStubImpl$Query$GetCurrentUser$me<TRes>
    implements CopyWith$Query$GetCurrentUser$me<TRes> {
  _CopyWithStubImpl$Query$GetCurrentUser$me(this._res);

  TRes _res;

  call({
    String? $_id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? profileImg,
    String? role,
    List<String?>? wishlist,
    List<Query$GetCurrentUser$me$addresses?>? addresses,
    String? $__typename,
  }) =>
      _res;

  addresses(_fn) => _res;
}

class Query$GetCurrentUser$me$addresses {
  Query$GetCurrentUser$me$addresses({
    required this.$_id,
    required this.street,
    required this.city,
    required this.phone,
    this.lat,
    this.long,
    this.$__typename = 'Address',
  });

  factory Query$GetCurrentUser$me$addresses.fromJson(
      Map<String, dynamic> json) {
    final l$$_id = json['_id'];
    final l$street = json['street'];
    final l$city = json['city'];
    final l$phone = json['phone'];
    final l$lat = json['lat'];
    final l$long = json['long'];
    final l$$__typename = json['__typename'];
    return Query$GetCurrentUser$me$addresses(
      $_id: (l$$_id as String),
      street: (l$street as String),
      city: (l$city as String),
      phone: (l$phone as String),
      lat: (l$lat as String?),
      long: (l$long as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String $_id;

  final String street;

  final String city;

  final String phone;

  final String? lat;

  final String? long;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$_id = $_id;
    _resultData['_id'] = l$$_id;
    final l$street = street;
    _resultData['street'] = l$street;
    final l$city = city;
    _resultData['city'] = l$city;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$lat = lat;
    _resultData['lat'] = l$lat;
    final l$long = long;
    _resultData['long'] = l$long;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$_id = $_id;
    final l$street = street;
    final l$city = city;
    final l$phone = phone;
    final l$lat = lat;
    final l$long = long;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$$_id,
      l$street,
      l$city,
      l$phone,
      l$lat,
      l$long,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$GetCurrentUser$me$addresses ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id = $_id;
    final lOther$$_id = other.$_id;
    if (l$$_id != lOther$$_id) {
      return false;
    }
    final l$street = street;
    final lOther$street = other.street;
    if (l$street != lOther$street) {
      return false;
    }
    final l$city = city;
    final lOther$city = other.city;
    if (l$city != lOther$city) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$lat = lat;
    final lOther$lat = other.lat;
    if (l$lat != lOther$lat) {
      return false;
    }
    final l$long = long;
    final lOther$long = other.long;
    if (l$long != lOther$long) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$GetCurrentUser$me$addresses
    on Query$GetCurrentUser$me$addresses {
  CopyWith$Query$GetCurrentUser$me$addresses<Query$GetCurrentUser$me$addresses>
      get copyWith => CopyWith$Query$GetCurrentUser$me$addresses(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Query$GetCurrentUser$me$addresses<TRes> {
  factory CopyWith$Query$GetCurrentUser$me$addresses(
    Query$GetCurrentUser$me$addresses instance,
    TRes Function(Query$GetCurrentUser$me$addresses) then,
  ) = _CopyWithImpl$Query$GetCurrentUser$me$addresses;

  factory CopyWith$Query$GetCurrentUser$me$addresses.stub(TRes res) =
      _CopyWithStubImpl$Query$GetCurrentUser$me$addresses;

  TRes call({
    String? $_id,
    String? street,
    String? city,
    String? phone,
    String? lat,
    String? long,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$GetCurrentUser$me$addresses<TRes>
    implements CopyWith$Query$GetCurrentUser$me$addresses<TRes> {
  _CopyWithImpl$Query$GetCurrentUser$me$addresses(
    this._instance,
    this._then,
  );

  final Query$GetCurrentUser$me$addresses _instance;

  final TRes Function(Query$GetCurrentUser$me$addresses) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id = _undefined,
    Object? street = _undefined,
    Object? city = _undefined,
    Object? phone = _undefined,
    Object? lat = _undefined,
    Object? long = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$GetCurrentUser$me$addresses(
        $_id: $_id == _undefined || $_id == null
            ? _instance.$_id
            : ($_id as String),
        street: street == _undefined || street == null
            ? _instance.street
            : (street as String),
        city: city == _undefined || city == null
            ? _instance.city
            : (city as String),
        phone: phone == _undefined || phone == null
            ? _instance.phone
            : (phone as String),
        lat: lat == _undefined ? _instance.lat : (lat as String?),
        long: long == _undefined ? _instance.long : (long as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$GetCurrentUser$me$addresses<TRes>
    implements CopyWith$Query$GetCurrentUser$me$addresses<TRes> {
  _CopyWithStubImpl$Query$GetCurrentUser$me$addresses(this._res);

  TRes _res;

  call({
    String? $_id,
    String? street,
    String? city,
    String? phone,
    String? lat,
    String? long,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$SignIn {
  factory Variables$Mutation$SignIn({
    required String email,
    required String password,
  }) =>
      Variables$Mutation$SignIn._({
        r'email': email,
        r'password': password,
      });

  Variables$Mutation$SignIn._(this._$data);

  factory Variables$Mutation$SignIn.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Variables$Mutation$SignIn._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Variables$Mutation$SignIn<Variables$Mutation$SignIn> get copyWith =>
      CopyWith$Variables$Mutation$SignIn(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$SignIn ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$password = password;
    return Object.hashAll([
      l$email,
      l$password,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$SignIn<TRes> {
  factory CopyWith$Variables$Mutation$SignIn(
    Variables$Mutation$SignIn instance,
    TRes Function(Variables$Mutation$SignIn) then,
  ) = _CopyWithImpl$Variables$Mutation$SignIn;

  factory CopyWith$Variables$Mutation$SignIn.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SignIn;

  TRes call({
    String? email,
    String? password,
  });
}

class _CopyWithImpl$Variables$Mutation$SignIn<TRes>
    implements CopyWith$Variables$Mutation$SignIn<TRes> {
  _CopyWithImpl$Variables$Mutation$SignIn(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SignIn _instance;

  final TRes Function(Variables$Mutation$SignIn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? email = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Variables$Mutation$SignIn._({
        ..._instance._$data,
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$SignIn<TRes>
    implements CopyWith$Variables$Mutation$SignIn<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SignIn(this._res);

  TRes _res;

  call({
    String? email,
    String? password,
  }) =>
      _res;
}

class Mutation$SignIn {
  Mutation$SignIn({
    this.login,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SignIn.fromJson(Map<String, dynamic> json) {
    final l$login = json['login'];
    final l$$__typename = json['__typename'];
    return Mutation$SignIn(
      login: l$login == null
          ? null
          : Mutation$SignIn$login.fromJson((l$login as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SignIn$login? login;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$login = login;
    _resultData['login'] = l$login?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$login = login;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$login,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignIn || runtimeType != other.runtimeType) {
      return false;
    }
    final l$login = login;
    final lOther$login = other.login;
    if (l$login != lOther$login) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SignIn on Mutation$SignIn {
  CopyWith$Mutation$SignIn<Mutation$SignIn> get copyWith =>
      CopyWith$Mutation$SignIn(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SignIn<TRes> {
  factory CopyWith$Mutation$SignIn(
    Mutation$SignIn instance,
    TRes Function(Mutation$SignIn) then,
  ) = _CopyWithImpl$Mutation$SignIn;

  factory CopyWith$Mutation$SignIn.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignIn;

  TRes call({
    Mutation$SignIn$login? login,
    String? $__typename,
  });
  CopyWith$Mutation$SignIn$login<TRes> get login;
}

class _CopyWithImpl$Mutation$SignIn<TRes>
    implements CopyWith$Mutation$SignIn<TRes> {
  _CopyWithImpl$Mutation$SignIn(
    this._instance,
    this._then,
  );

  final Mutation$SignIn _instance;

  final TRes Function(Mutation$SignIn) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? login = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignIn(
        login: login == _undefined
            ? _instance.login
            : (login as Mutation$SignIn$login?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$SignIn$login<TRes> get login {
    final local$login = _instance.login;
    return local$login == null
        ? CopyWith$Mutation$SignIn$login.stub(_then(_instance))
        : CopyWith$Mutation$SignIn$login(local$login, (e) => call(login: e));
  }
}

class _CopyWithStubImpl$Mutation$SignIn<TRes>
    implements CopyWith$Mutation$SignIn<TRes> {
  _CopyWithStubImpl$Mutation$SignIn(this._res);

  TRes _res;

  call({
    Mutation$SignIn$login? login,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$SignIn$login<TRes> get login =>
      CopyWith$Mutation$SignIn$login.stub(_res);
}

const documentNodeMutationSignIn = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'SignIn'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'email')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'password')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'login'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'loginInput'),
            value: ObjectValueNode(fields: [
              ObjectFieldNode(
                name: NameNode(value: 'email'),
                value: VariableNode(name: NameNode(value: 'email')),
              ),
              ObjectFieldNode(
                name: NameNode(value: 'password'),
                value: VariableNode(name: NameNode(value: 'password')),
              ),
            ]),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'token'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: '_id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'email'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'phone'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'gender'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'profileImg'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Mutation$SignIn$login {
  Mutation$SignIn$login({
    this.message,
    this.token,
    this.user,
    this.$__typename = 'AuthResponse',
  });

  factory Mutation$SignIn$login.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$token = json['token'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Mutation$SignIn$login(
      message: (l$message as String?),
      token: (l$token as String?),
      user: l$user == null
          ? null
          : Mutation$SignIn$login$user.fromJson(
              (l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String? message;

  final String? token;

  final Mutation$SignIn$login$user? user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$token = token;
    _resultData['token'] = l$token;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$token = token;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$token,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignIn$login || runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SignIn$login on Mutation$SignIn$login {
  CopyWith$Mutation$SignIn$login<Mutation$SignIn$login> get copyWith =>
      CopyWith$Mutation$SignIn$login(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SignIn$login<TRes> {
  factory CopyWith$Mutation$SignIn$login(
    Mutation$SignIn$login instance,
    TRes Function(Mutation$SignIn$login) then,
  ) = _CopyWithImpl$Mutation$SignIn$login;

  factory CopyWith$Mutation$SignIn$login.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignIn$login;

  TRes call({
    String? message,
    String? token,
    Mutation$SignIn$login$user? user,
    String? $__typename,
  });
  CopyWith$Mutation$SignIn$login$user<TRes> get user;
}

class _CopyWithImpl$Mutation$SignIn$login<TRes>
    implements CopyWith$Mutation$SignIn$login<TRes> {
  _CopyWithImpl$Mutation$SignIn$login(
    this._instance,
    this._then,
  );

  final Mutation$SignIn$login _instance;

  final TRes Function(Mutation$SignIn$login) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? token = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignIn$login(
        message:
            message == _undefined ? _instance.message : (message as String?),
        token: token == _undefined ? _instance.token : (token as String?),
        user: user == _undefined
            ? _instance.user
            : (user as Mutation$SignIn$login$user?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$SignIn$login$user<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Mutation$SignIn$login$user.stub(_then(_instance))
        : CopyWith$Mutation$SignIn$login$user(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$SignIn$login<TRes>
    implements CopyWith$Mutation$SignIn$login<TRes> {
  _CopyWithStubImpl$Mutation$SignIn$login(this._res);

  TRes _res;

  call({
    String? message,
    String? token,
    Mutation$SignIn$login$user? user,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$SignIn$login$user<TRes> get user =>
      CopyWith$Mutation$SignIn$login$user.stub(_res);
}

class Mutation$SignIn$login$user {
  Mutation$SignIn$login$user({
    required this.$_id,
    required this.name,
    required this.email,
    this.phone,
    this.gender,
    this.profileImg,
    this.$__typename = 'User',
  });

  factory Mutation$SignIn$login$user.fromJson(Map<String, dynamic> json) {
    final l$$_id = json['_id'];
    final l$name = json['name'];
    final l$email = json['email'];
    final l$phone = json['phone'];
    final l$gender = json['gender'];
    final l$profileImg = json['profileImg'];
    final l$$__typename = json['__typename'];
    return Mutation$SignIn$login$user(
      $_id: (l$$_id as String),
      name: (l$name as String),
      email: (l$email as String),
      phone: (l$phone as String?),
      gender: (l$gender as String?),
      profileImg: (l$profileImg as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String $_id;

  final String name;

  final String email;

  final String? phone;

  final String? gender;

  final String? profileImg;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$_id = $_id;
    _resultData['_id'] = l$$_id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$phone = phone;
    _resultData['phone'] = l$phone;
    final l$gender = gender;
    _resultData['gender'] = l$gender;
    final l$profileImg = profileImg;
    _resultData['profileImg'] = l$profileImg;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$_id = $_id;
    final l$name = name;
    final l$email = email;
    final l$phone = phone;
    final l$gender = gender;
    final l$profileImg = profileImg;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$$_id,
      l$name,
      l$email,
      l$phone,
      l$gender,
      l$profileImg,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignIn$login$user ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id = $_id;
    final lOther$$_id = other.$_id;
    if (l$$_id != lOther$$_id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$phone = phone;
    final lOther$phone = other.phone;
    if (l$phone != lOther$phone) {
      return false;
    }
    final l$gender = gender;
    final lOther$gender = other.gender;
    if (l$gender != lOther$gender) {
      return false;
    }
    final l$profileImg = profileImg;
    final lOther$profileImg = other.profileImg;
    if (l$profileImg != lOther$profileImg) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SignIn$login$user
    on Mutation$SignIn$login$user {
  CopyWith$Mutation$SignIn$login$user<Mutation$SignIn$login$user>
      get copyWith => CopyWith$Mutation$SignIn$login$user(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$SignIn$login$user<TRes> {
  factory CopyWith$Mutation$SignIn$login$user(
    Mutation$SignIn$login$user instance,
    TRes Function(Mutation$SignIn$login$user) then,
  ) = _CopyWithImpl$Mutation$SignIn$login$user;

  factory CopyWith$Mutation$SignIn$login$user.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignIn$login$user;

  TRes call({
    String? $_id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? profileImg,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$SignIn$login$user<TRes>
    implements CopyWith$Mutation$SignIn$login$user<TRes> {
  _CopyWithImpl$Mutation$SignIn$login$user(
    this._instance,
    this._then,
  );

  final Mutation$SignIn$login$user _instance;

  final TRes Function(Mutation$SignIn$login$user) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id = _undefined,
    Object? name = _undefined,
    Object? email = _undefined,
    Object? phone = _undefined,
    Object? gender = _undefined,
    Object? profileImg = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignIn$login$user(
        $_id: $_id == _undefined || $_id == null
            ? _instance.$_id
            : ($_id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        phone: phone == _undefined ? _instance.phone : (phone as String?),
        gender: gender == _undefined ? _instance.gender : (gender as String?),
        profileImg: profileImg == _undefined
            ? _instance.profileImg
            : (profileImg as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$SignIn$login$user<TRes>
    implements CopyWith$Mutation$SignIn$login$user<TRes> {
  _CopyWithStubImpl$Mutation$SignIn$login$user(this._res);

  TRes _res;

  call({
    String? $_id,
    String? name,
    String? email,
    String? phone,
    String? gender,
    String? profileImg,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Mutation$SignUp {
  factory Variables$Mutation$SignUp({required Input$SignUpInput input}) =>
      Variables$Mutation$SignUp._({
        r'input': input,
      });

  Variables$Mutation$SignUp._(this._$data);

  factory Variables$Mutation$SignUp.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$input = data['input'];
    result$data['input'] =
        Input$SignUpInput.fromJson((l$input as Map<String, dynamic>));
    return Variables$Mutation$SignUp._(result$data);
  }

  Map<String, dynamic> _$data;

  Input$SignUpInput get input => (_$data['input'] as Input$SignUpInput);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$input = input;
    result$data['input'] = l$input.toJson();
    return result$data;
  }

  CopyWith$Variables$Mutation$SignUp<Variables$Mutation$SignUp> get copyWith =>
      CopyWith$Variables$Mutation$SignUp(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$SignUp ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$input = input;
    final lOther$input = other.input;
    if (l$input != lOther$input) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$input = input;
    return Object.hashAll([l$input]);
  }
}

abstract class CopyWith$Variables$Mutation$SignUp<TRes> {
  factory CopyWith$Variables$Mutation$SignUp(
    Variables$Mutation$SignUp instance,
    TRes Function(Variables$Mutation$SignUp) then,
  ) = _CopyWithImpl$Variables$Mutation$SignUp;

  factory CopyWith$Variables$Mutation$SignUp.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SignUp;

  TRes call({Input$SignUpInput? input});
  CopyWith$Input$SignUpInput<TRes> get input;
}

class _CopyWithImpl$Variables$Mutation$SignUp<TRes>
    implements CopyWith$Variables$Mutation$SignUp<TRes> {
  _CopyWithImpl$Variables$Mutation$SignUp(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SignUp _instance;

  final TRes Function(Variables$Mutation$SignUp) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? input = _undefined}) => _then(Variables$Mutation$SignUp._({
        ..._instance._$data,
        if (input != _undefined && input != null)
          'input': (input as Input$SignUpInput),
      }));

  CopyWith$Input$SignUpInput<TRes> get input {
    final local$input = _instance.input;
    return CopyWith$Input$SignUpInput(local$input, (e) => call(input: e));
  }
}

class _CopyWithStubImpl$Variables$Mutation$SignUp<TRes>
    implements CopyWith$Variables$Mutation$SignUp<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SignUp(this._res);

  TRes _res;

  call({Input$SignUpInput? input}) => _res;

  CopyWith$Input$SignUpInput<TRes> get input =>
      CopyWith$Input$SignUpInput.stub(_res);
}

class Mutation$SignUp {
  Mutation$SignUp({
    this.signup,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SignUp.fromJson(Map<String, dynamic> json) {
    final l$signup = json['signup'];
    final l$$__typename = json['__typename'];
    return Mutation$SignUp(
      signup: l$signup == null
          ? null
          : Mutation$SignUp$signup.fromJson((l$signup as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SignUp$signup? signup;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$signup = signup;
    _resultData['signup'] = l$signup?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$signup = signup;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$signup,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignUp || runtimeType != other.runtimeType) {
      return false;
    }
    final l$signup = signup;
    final lOther$signup = other.signup;
    if (l$signup != lOther$signup) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SignUp on Mutation$SignUp {
  CopyWith$Mutation$SignUp<Mutation$SignUp> get copyWith =>
      CopyWith$Mutation$SignUp(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SignUp<TRes> {
  factory CopyWith$Mutation$SignUp(
    Mutation$SignUp instance,
    TRes Function(Mutation$SignUp) then,
  ) = _CopyWithImpl$Mutation$SignUp;

  factory CopyWith$Mutation$SignUp.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignUp;

  TRes call({
    Mutation$SignUp$signup? signup,
    String? $__typename,
  });
  CopyWith$Mutation$SignUp$signup<TRes> get signup;
}

class _CopyWithImpl$Mutation$SignUp<TRes>
    implements CopyWith$Mutation$SignUp<TRes> {
  _CopyWithImpl$Mutation$SignUp(
    this._instance,
    this._then,
  );

  final Mutation$SignUp _instance;

  final TRes Function(Mutation$SignUp) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? signup = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignUp(
        signup: signup == _undefined
            ? _instance.signup
            : (signup as Mutation$SignUp$signup?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$SignUp$signup<TRes> get signup {
    final local$signup = _instance.signup;
    return local$signup == null
        ? CopyWith$Mutation$SignUp$signup.stub(_then(_instance))
        : CopyWith$Mutation$SignUp$signup(local$signup, (e) => call(signup: e));
  }
}

class _CopyWithStubImpl$Mutation$SignUp<TRes>
    implements CopyWith$Mutation$SignUp<TRes> {
  _CopyWithStubImpl$Mutation$SignUp(this._res);

  TRes _res;

  call({
    Mutation$SignUp$signup? signup,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$SignUp$signup<TRes> get signup =>
      CopyWith$Mutation$SignUp$signup.stub(_res);
}

const documentNodeMutationSignUp = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'SignUp'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'input')),
        type: NamedTypeNode(
          name: NameNode(value: 'SignUpInput'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'signup'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'signupInput'),
            value: VariableNode(name: NameNode(value: 'input')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'token'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                name: NameNode(value: '_id'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'name'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: 'email'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
              FieldNode(
                name: NameNode(value: '__typename'),
                alias: null,
                arguments: [],
                directives: [],
                selectionSet: null,
              ),
            ]),
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Mutation$SignUp$signup {
  Mutation$SignUp$signup({
    this.message,
    this.token,
    this.user,
    this.$__typename = 'AuthResponse',
  });

  factory Mutation$SignUp$signup.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$token = json['token'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Mutation$SignUp$signup(
      message: (l$message as String?),
      token: (l$token as String?),
      user: l$user == null
          ? null
          : Mutation$SignUp$signup$user.fromJson(
              (l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String? message;

  final String? token;

  final Mutation$SignUp$signup$user? user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$token = token;
    _resultData['token'] = l$token;
    final l$user = user;
    _resultData['user'] = l$user?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$token = token;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$token,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignUp$signup || runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SignUp$signup on Mutation$SignUp$signup {
  CopyWith$Mutation$SignUp$signup<Mutation$SignUp$signup> get copyWith =>
      CopyWith$Mutation$SignUp$signup(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SignUp$signup<TRes> {
  factory CopyWith$Mutation$SignUp$signup(
    Mutation$SignUp$signup instance,
    TRes Function(Mutation$SignUp$signup) then,
  ) = _CopyWithImpl$Mutation$SignUp$signup;

  factory CopyWith$Mutation$SignUp$signup.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignUp$signup;

  TRes call({
    String? message,
    String? token,
    Mutation$SignUp$signup$user? user,
    String? $__typename,
  });
  CopyWith$Mutation$SignUp$signup$user<TRes> get user;
}

class _CopyWithImpl$Mutation$SignUp$signup<TRes>
    implements CopyWith$Mutation$SignUp$signup<TRes> {
  _CopyWithImpl$Mutation$SignUp$signup(
    this._instance,
    this._then,
  );

  final Mutation$SignUp$signup _instance;

  final TRes Function(Mutation$SignUp$signup) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? token = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignUp$signup(
        message:
            message == _undefined ? _instance.message : (message as String?),
        token: token == _undefined ? _instance.token : (token as String?),
        user: user == _undefined
            ? _instance.user
            : (user as Mutation$SignUp$signup$user?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$SignUp$signup$user<TRes> get user {
    final local$user = _instance.user;
    return local$user == null
        ? CopyWith$Mutation$SignUp$signup$user.stub(_then(_instance))
        : CopyWith$Mutation$SignUp$signup$user(
            local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$SignUp$signup<TRes>
    implements CopyWith$Mutation$SignUp$signup<TRes> {
  _CopyWithStubImpl$Mutation$SignUp$signup(this._res);

  TRes _res;

  call({
    String? message,
    String? token,
    Mutation$SignUp$signup$user? user,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$SignUp$signup$user<TRes> get user =>
      CopyWith$Mutation$SignUp$signup$user.stub(_res);
}

class Mutation$SignUp$signup$user {
  Mutation$SignUp$signup$user({
    required this.$_id,
    required this.name,
    required this.email,
    this.$__typename = 'User',
  });

  factory Mutation$SignUp$signup$user.fromJson(Map<String, dynamic> json) {
    final l$$_id = json['_id'];
    final l$name = json['name'];
    final l$email = json['email'];
    final l$$__typename = json['__typename'];
    return Mutation$SignUp$signup$user(
      $_id: (l$$_id as String),
      name: (l$name as String),
      email: (l$email as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String $_id;

  final String name;

  final String email;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$$_id = $_id;
    _resultData['_id'] = l$$_id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$$_id = $_id;
    final l$name = name;
    final l$email = email;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$$_id,
      l$name,
      l$email,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$SignUp$signup$user ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$$_id = $_id;
    final lOther$$_id = other.$_id;
    if (l$$_id != lOther$$_id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SignUp$signup$user
    on Mutation$SignUp$signup$user {
  CopyWith$Mutation$SignUp$signup$user<Mutation$SignUp$signup$user>
      get copyWith => CopyWith$Mutation$SignUp$signup$user(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$SignUp$signup$user<TRes> {
  factory CopyWith$Mutation$SignUp$signup$user(
    Mutation$SignUp$signup$user instance,
    TRes Function(Mutation$SignUp$signup$user) then,
  ) = _CopyWithImpl$Mutation$SignUp$signup$user;

  factory CopyWith$Mutation$SignUp$signup$user.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignUp$signup$user;

  TRes call({
    String? $_id,
    String? name,
    String? email,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$SignUp$signup$user<TRes>
    implements CopyWith$Mutation$SignUp$signup$user<TRes> {
  _CopyWithImpl$Mutation$SignUp$signup$user(
    this._instance,
    this._then,
  );

  final Mutation$SignUp$signup$user _instance;

  final TRes Function(Mutation$SignUp$signup$user) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? $_id = _undefined,
    Object? name = _undefined,
    Object? email = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignUp$signup$user(
        $_id: $_id == _undefined || $_id == null
            ? _instance.$_id
            : ($_id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        email: email == _undefined || email == null
            ? _instance.email
            : (email as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$SignUp$signup$user<TRes>
    implements CopyWith$Mutation$SignUp$signup$user<TRes> {
  _CopyWithStubImpl$Mutation$SignUp$signup$user(this._res);

  TRes _res;

  call({
    String? $_id,
    String? name,
    String? email,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$GuestLogin {
  Mutation$GuestLogin({
    this.guestLogin,
    this.$__typename = 'Mutation',
  });

  factory Mutation$GuestLogin.fromJson(Map<String, dynamic> json) {
    final l$guestLogin = json['guestLogin'];
    final l$$__typename = json['__typename'];
    return Mutation$GuestLogin(
      guestLogin: l$guestLogin == null
          ? null
          : Mutation$GuestLogin$guestLogin.fromJson(
              (l$guestLogin as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$GuestLogin$guestLogin? guestLogin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$guestLogin = guestLogin;
    _resultData['guestLogin'] = l$guestLogin?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$guestLogin = guestLogin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$guestLogin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$GuestLogin || runtimeType != other.runtimeType) {
      return false;
    }
    final l$guestLogin = guestLogin;
    final lOther$guestLogin = other.guestLogin;
    if (l$guestLogin != lOther$guestLogin) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$GuestLogin on Mutation$GuestLogin {
  CopyWith$Mutation$GuestLogin<Mutation$GuestLogin> get copyWith =>
      CopyWith$Mutation$GuestLogin(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$GuestLogin<TRes> {
  factory CopyWith$Mutation$GuestLogin(
    Mutation$GuestLogin instance,
    TRes Function(Mutation$GuestLogin) then,
  ) = _CopyWithImpl$Mutation$GuestLogin;

  factory CopyWith$Mutation$GuestLogin.stub(TRes res) =
      _CopyWithStubImpl$Mutation$GuestLogin;

  TRes call({
    Mutation$GuestLogin$guestLogin? guestLogin,
    String? $__typename,
  });
  CopyWith$Mutation$GuestLogin$guestLogin<TRes> get guestLogin;
}

class _CopyWithImpl$Mutation$GuestLogin<TRes>
    implements CopyWith$Mutation$GuestLogin<TRes> {
  _CopyWithImpl$Mutation$GuestLogin(
    this._instance,
    this._then,
  );

  final Mutation$GuestLogin _instance;

  final TRes Function(Mutation$GuestLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? guestLogin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$GuestLogin(
        guestLogin: guestLogin == _undefined
            ? _instance.guestLogin
            : (guestLogin as Mutation$GuestLogin$guestLogin?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$GuestLogin$guestLogin<TRes> get guestLogin {
    final local$guestLogin = _instance.guestLogin;
    return local$guestLogin == null
        ? CopyWith$Mutation$GuestLogin$guestLogin.stub(_then(_instance))
        : CopyWith$Mutation$GuestLogin$guestLogin(
            local$guestLogin, (e) => call(guestLogin: e));
  }
}

class _CopyWithStubImpl$Mutation$GuestLogin<TRes>
    implements CopyWith$Mutation$GuestLogin<TRes> {
  _CopyWithStubImpl$Mutation$GuestLogin(this._res);

  TRes _res;

  call({
    Mutation$GuestLogin$guestLogin? guestLogin,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$GuestLogin$guestLogin<TRes> get guestLogin =>
      CopyWith$Mutation$GuestLogin$guestLogin.stub(_res);
}

const documentNodeMutationGuestLogin = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'GuestLogin'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'guestLogin'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'token'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Mutation$GuestLogin$guestLogin {
  Mutation$GuestLogin$guestLogin({
    this.message,
    this.token,
    this.$__typename = 'AuthResponse',
  });

  factory Mutation$GuestLogin$guestLogin.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$token = json['token'];
    final l$$__typename = json['__typename'];
    return Mutation$GuestLogin$guestLogin(
      message: (l$message as String?),
      token: (l$token as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? message;

  final String? token;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$token = token;
    _resultData['token'] = l$token;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$token = token;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$token,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$GuestLogin$guestLogin ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$GuestLogin$guestLogin
    on Mutation$GuestLogin$guestLogin {
  CopyWith$Mutation$GuestLogin$guestLogin<Mutation$GuestLogin$guestLogin>
      get copyWith => CopyWith$Mutation$GuestLogin$guestLogin(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$GuestLogin$guestLogin<TRes> {
  factory CopyWith$Mutation$GuestLogin$guestLogin(
    Mutation$GuestLogin$guestLogin instance,
    TRes Function(Mutation$GuestLogin$guestLogin) then,
  ) = _CopyWithImpl$Mutation$GuestLogin$guestLogin;

  factory CopyWith$Mutation$GuestLogin$guestLogin.stub(TRes res) =
      _CopyWithStubImpl$Mutation$GuestLogin$guestLogin;

  TRes call({
    String? message,
    String? token,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$GuestLogin$guestLogin<TRes>
    implements CopyWith$Mutation$GuestLogin$guestLogin<TRes> {
  _CopyWithImpl$Mutation$GuestLogin$guestLogin(
    this._instance,
    this._then,
  );

  final Mutation$GuestLogin$guestLogin _instance;

  final TRes Function(Mutation$GuestLogin$guestLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? token = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$GuestLogin$guestLogin(
        message:
            message == _undefined ? _instance.message : (message as String?),
        token: token == _undefined ? _instance.token : (token as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$GuestLogin$guestLogin<TRes>
    implements CopyWith$Mutation$GuestLogin$guestLogin<TRes> {
  _CopyWithStubImpl$Mutation$GuestLogin$guestLogin(this._res);

  TRes _res;

  call({
    String? message,
    String? token,
    String? $__typename,
  }) =>
      _res;
}

class Mutation$Logout {
  Mutation$Logout({
    this.logout,
    this.$__typename = 'Mutation',
  });

  factory Mutation$Logout.fromJson(Map<String, dynamic> json) {
    final l$logout = json['logout'];
    final l$$__typename = json['__typename'];
    return Mutation$Logout(
      logout: l$logout == null
          ? null
          : Mutation$Logout$logout.fromJson((l$logout as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$Logout$logout? logout;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$logout = logout;
    _resultData['logout'] = l$logout?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$logout = logout;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$logout,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$Logout || runtimeType != other.runtimeType) {
      return false;
    }
    final l$logout = logout;
    final lOther$logout = other.logout;
    if (l$logout != lOther$logout) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$Logout on Mutation$Logout {
  CopyWith$Mutation$Logout<Mutation$Logout> get copyWith =>
      CopyWith$Mutation$Logout(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$Logout<TRes> {
  factory CopyWith$Mutation$Logout(
    Mutation$Logout instance,
    TRes Function(Mutation$Logout) then,
  ) = _CopyWithImpl$Mutation$Logout;

  factory CopyWith$Mutation$Logout.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Logout;

  TRes call({
    Mutation$Logout$logout? logout,
    String? $__typename,
  });
  CopyWith$Mutation$Logout$logout<TRes> get logout;
}

class _CopyWithImpl$Mutation$Logout<TRes>
    implements CopyWith$Mutation$Logout<TRes> {
  _CopyWithImpl$Mutation$Logout(
    this._instance,
    this._then,
  );

  final Mutation$Logout _instance;

  final TRes Function(Mutation$Logout) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? logout = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Logout(
        logout: logout == _undefined
            ? _instance.logout
            : (logout as Mutation$Logout$logout?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$Logout$logout<TRes> get logout {
    final local$logout = _instance.logout;
    return local$logout == null
        ? CopyWith$Mutation$Logout$logout.stub(_then(_instance))
        : CopyWith$Mutation$Logout$logout(local$logout, (e) => call(logout: e));
  }
}

class _CopyWithStubImpl$Mutation$Logout<TRes>
    implements CopyWith$Mutation$Logout<TRes> {
  _CopyWithStubImpl$Mutation$Logout(this._res);

  TRes _res;

  call({
    Mutation$Logout$logout? logout,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$Logout$logout<TRes> get logout =>
      CopyWith$Mutation$Logout$logout.stub(_res);
}

const documentNodeMutationLogout = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'Logout'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'logout'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'message'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
]);

class Mutation$Logout$logout {
  Mutation$Logout$logout({
    this.message,
    this.$__typename = 'LogoutResponse',
  });

  factory Mutation$Logout$logout.fromJson(Map<String, dynamic> json) {
    final l$message = json['message'];
    final l$$__typename = json['__typename'];
    return Mutation$Logout$logout(
      message: (l$message as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String? message;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$message = message;
    _resultData['message'] = l$message;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$message = message;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$message,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$Logout$logout || runtimeType != other.runtimeType) {
      return false;
    }
    final l$message = message;
    final lOther$message = other.message;
    if (l$message != lOther$message) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$Logout$logout on Mutation$Logout$logout {
  CopyWith$Mutation$Logout$logout<Mutation$Logout$logout> get copyWith =>
      CopyWith$Mutation$Logout$logout(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$Logout$logout<TRes> {
  factory CopyWith$Mutation$Logout$logout(
    Mutation$Logout$logout instance,
    TRes Function(Mutation$Logout$logout) then,
  ) = _CopyWithImpl$Mutation$Logout$logout;

  factory CopyWith$Mutation$Logout$logout.stub(TRes res) =
      _CopyWithStubImpl$Mutation$Logout$logout;

  TRes call({
    String? message,
    String? $__typename,
  });
}

class _CopyWithImpl$Mutation$Logout$logout<TRes>
    implements CopyWith$Mutation$Logout$logout<TRes> {
  _CopyWithImpl$Mutation$Logout$logout(
    this._instance,
    this._then,
  );

  final Mutation$Logout$logout _instance;

  final TRes Function(Mutation$Logout$logout) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? message = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$Logout$logout(
        message:
            message == _undefined ? _instance.message : (message as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Mutation$Logout$logout<TRes>
    implements CopyWith$Mutation$Logout$logout<TRes> {
  _CopyWithStubImpl$Mutation$Logout$logout(this._res);

  TRes _res;

  call({
    String? message,
    String? $__typename,
  }) =>
      _res;
}

const possibleTypesMap = <String, Set<String>>{};
