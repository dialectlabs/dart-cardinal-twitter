// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dtos.dart';

// **************************************************************************
// BorshSerializableGenerator
// **************************************************************************

mixin _$ClaimRequest {
  int get bump => throw UnimplementedError();
  Ed25519HDPublicKey get requester => throw UnimplementedError();
  Ed25519HDPublicKey get namespace => throw UnimplementedError();
  bool get isApproved => throw UnimplementedError();
  String get entryName => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, bump);
    const BPublicKey().write(writer, requester);
    const BPublicKey().write(writer, namespace);
    const BBool().write(writer, isApproved);
    const BString().write(writer, entryName);

    return writer.toArray();
  }
}

class _ClaimRequest extends ClaimRequest {
  _ClaimRequest({
    required this.bump,
    required this.requester,
    required this.namespace,
    required this.isApproved,
    required this.entryName,
  }) : super._();

  final int bump;
  final Ed25519HDPublicKey requester;
  final Ed25519HDPublicKey namespace;
  final bool isApproved;
  final String entryName;
}

class BClaimRequest implements BType<ClaimRequest> {
  const BClaimRequest();

  @override
  void write(BinaryWriter writer, ClaimRequest value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  ClaimRequest read(BinaryReader reader) {
    return ClaimRequest(
      bump: const BU8().read(reader),
      requester: const BPublicKey().read(reader),
      namespace: const BPublicKey().read(reader),
      isApproved: const BBool().read(reader),
      entryName: const BString().read(reader),
    );
  }
}

ClaimRequest _$ClaimRequestFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BClaimRequest().read(reader);
}

mixin _$EntryData {
  int get bump => throw UnimplementedError();
  Ed25519HDPublicKey get namespace => throw UnimplementedError();
  String get name => throw UnimplementedError();
  Ed25519HDPublicKey? get data => throw UnimplementedError();
  Ed25519HDPublicKey? get reverseEntry => throw UnimplementedError();
  Ed25519HDPublicKey get mint => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, bump);
    const BPublicKey().write(writer, namespace);
    const BString().write(writer, name);
    const BOption(BPublicKey()).write(writer, data);
    const BOption(BPublicKey()).write(writer, reverseEntry);
    const BPublicKey().write(writer, mint);

    return writer.toArray();
  }
}

class _EntryData extends EntryData {
  _EntryData({
    required this.bump,
    required this.namespace,
    required this.name,
    required this.data,
    required this.reverseEntry,
    required this.mint,
  }) : super._();

  final int bump;
  final Ed25519HDPublicKey namespace;
  final String name;
  final Ed25519HDPublicKey? data;
  final Ed25519HDPublicKey? reverseEntry;
  final Ed25519HDPublicKey mint;
}

class BEntryData implements BType<EntryData> {
  const BEntryData();

  @override
  void write(BinaryWriter writer, EntryData value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  EntryData read(BinaryReader reader) {
    return EntryData(
      bump: const BU8().read(reader),
      namespace: const BPublicKey().read(reader),
      name: const BString().read(reader),
      data: const BOption(BPublicKey()).read(reader),
      reverseEntry: const BOption(BPublicKey()).read(reader),
      mint: const BPublicKey().read(reader),
    );
  }
}

EntryData _$EntryDataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BEntryData().read(reader);
}

mixin _$GlobalContext {
  int get bump => throw UnimplementedError();
  Ed25519HDPublicKey get updateAuthority => throw UnimplementedError();
  Ed25519HDPublicKey get rentAuthority => throw UnimplementedError();
  BigInt get feeBasisPoints => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, bump);
    const BPublicKey().write(writer, updateAuthority);
    const BPublicKey().write(writer, rentAuthority);
    const BU64().write(writer, feeBasisPoints);

    return writer.toArray();
  }
}

class _GlobalContext extends GlobalContext {
  _GlobalContext({
    required this.bump,
    required this.updateAuthority,
    required this.rentAuthority,
    required this.feeBasisPoints,
  }) : super._();

  final int bump;
  final Ed25519HDPublicKey updateAuthority;
  final Ed25519HDPublicKey rentAuthority;
  final BigInt feeBasisPoints;
}

class BGlobalContext implements BType<GlobalContext> {
  const BGlobalContext();

  @override
  void write(BinaryWriter writer, GlobalContext value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  GlobalContext read(BinaryReader reader) {
    return GlobalContext(
      bump: const BU8().read(reader),
      updateAuthority: const BPublicKey().read(reader),
      rentAuthority: const BPublicKey().read(reader),
      feeBasisPoints: const BU64().read(reader),
    );
  }
}

GlobalContext _$GlobalContextFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BGlobalContext().read(reader);
}

mixin _$NamespaceData {
  int get bump => throw UnimplementedError();
  String get name => throw UnimplementedError();
  Ed25519HDPublicKey get updateAuthority => throw UnimplementedError();
  Ed25519HDPublicKey get rentAuthority => throw UnimplementedError();
  Ed25519HDPublicKey? get approveAuthority => throw UnimplementedError();
  int get schema => throw UnimplementedError();
  BigInt get paymentAmountDaily => throw UnimplementedError();
  BigInt get minRentalSeconds => throw UnimplementedError();
  BigInt? get maxRentalSeconds => throw UnimplementedError();
  bool get transferrableEntries => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, bump);
    const BString().write(writer, name);
    const BPublicKey().write(writer, updateAuthority);
    const BPublicKey().write(writer, rentAuthority);
    const BOption(BPublicKey()).write(writer, approveAuthority);
    const BU8().write(writer, schema);
    const BU64().write(writer, paymentAmountDaily);
    const BU64().write(writer, minRentalSeconds);
    const BOption(BU64()).write(writer, maxRentalSeconds);
    const BBool().write(writer, transferrableEntries);

    return writer.toArray();
  }
}

class _NamespaceData extends NamespaceData {
  _NamespaceData({
    required this.bump,
    required this.name,
    required this.updateAuthority,
    required this.rentAuthority,
    required this.approveAuthority,
    required this.schema,
    required this.paymentAmountDaily,
    required this.minRentalSeconds,
    required this.maxRentalSeconds,
    required this.transferrableEntries,
  }) : super._();

  final int bump;
  final String name;
  final Ed25519HDPublicKey updateAuthority;
  final Ed25519HDPublicKey rentAuthority;
  final Ed25519HDPublicKey? approveAuthority;
  final int schema;
  final BigInt paymentAmountDaily;
  final BigInt minRentalSeconds;
  final BigInt? maxRentalSeconds;
  final bool transferrableEntries;
}

class BNamespaceData implements BType<NamespaceData> {
  const BNamespaceData();

  @override
  void write(BinaryWriter writer, NamespaceData value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  NamespaceData read(BinaryReader reader) {
    return NamespaceData(
      bump: const BU8().read(reader),
      name: const BString().read(reader),
      updateAuthority: const BPublicKey().read(reader),
      rentAuthority: const BPublicKey().read(reader),
      approveAuthority: const BOption(BPublicKey()).read(reader),
      schema: const BU8().read(reader),
      paymentAmountDaily: const BU64().read(reader),
      minRentalSeconds: const BU64().read(reader),
      maxRentalSeconds: const BOption(BU64()).read(reader),
      transferrableEntries: const BBool().read(reader),
    );
  }
}

NamespaceData _$NamespaceDataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BNamespaceData().read(reader);
}

mixin _$ReverseEntryData {
  int get bump => throw UnimplementedError();
  String get entryName => throw UnimplementedError();
  String get namespaceName => throw UnimplementedError();

  Uint8List toBorsh() {
    final writer = BinaryWriter();

    const BU8().write(writer, bump);
    const BString().write(writer, entryName);
    const BString().write(writer, namespaceName);

    return writer.toArray();
  }
}

class _ReverseEntryData extends ReverseEntryData {
  _ReverseEntryData({
    required this.bump,
    required this.entryName,
    required this.namespaceName,
  }) : super._();

  final int bump;
  final String entryName;
  final String namespaceName;
}

class BReverseEntryData implements BType<ReverseEntryData> {
  const BReverseEntryData();

  @override
  void write(BinaryWriter writer, ReverseEntryData value) {
    writer.writeStruct(value.toBorsh());
  }

  @override
  ReverseEntryData read(BinaryReader reader) {
    return ReverseEntryData(
      bump: const BU8().read(reader),
      entryName: const BString().read(reader),
      namespaceName: const BString().read(reader),
    );
  }
}

ReverseEntryData _$ReverseEntryDataFromBorsh(Uint8List data) {
  final reader = BinaryReader(data.buffer.asByteData());

  return const BReverseEntryData().read(reader);
}
