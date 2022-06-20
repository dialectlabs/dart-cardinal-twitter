import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:cardinal_namespaces/src/borsh/borsh_extensions.dart';
import 'package:solana/solana.dart';

part 'dtos.g.dart';

@BorshSerializable()
class ClaimRequest with _$ClaimRequest {
  factory ClaimRequest(
      {@BU8() required int bump,
      @BPublicKey() required Ed25519HDPublicKey requester,
      @BPublicKey() required Ed25519HDPublicKey namespace,
      @BBool() required bool isApproved,
      @BString() required String entryName}) = _ClaimRequest;

  factory ClaimRequest.fromBorsh(Uint8List data) =>
      _$ClaimRequestFromBorsh(data);

  ClaimRequest._();

  ClaimRequest fromBorsh(Uint8List data) {
    // TODO: implement fromBorsh
    throw UnimplementedError();
  }
}

@BorshSerializable()
class EntryData with _$EntryData {
  factory EntryData({
    @BU8() required int bump,
    @BPublicKey() required Ed25519HDPublicKey namespace,
    @BString() required String name,
    @BOption(BPublicKey()) required Ed25519HDPublicKey? data,
    @BOption(BPublicKey()) required Ed25519HDPublicKey? reverseEntry,
    @BPublicKey() required Ed25519HDPublicKey mint,
  }) = _EntryData;

  @override
  factory EntryData.fromBorsh(Uint8List data) => _$EntryDataFromBorsh(data);

  EntryData._();
}

@BorshSerializable()
class GlobalContext with _$GlobalContext {
  factory GlobalContext({
    @BU8() required int bump,
    @BPublicKey() required Ed25519HDPublicKey updateAuthority,
    @BPublicKey() required Ed25519HDPublicKey rentAuthority,
    @BU64() required BigInt feeBasisPoints,
  }) = _GlobalContext;

  @override
  factory GlobalContext.fromBorsh(Uint8List data) =>
      _$GlobalContextFromBorsh(data);

  GlobalContext._();
}

@BorshSerializable()
class NamespaceData with _$NamespaceData {
  factory NamespaceData(
      {@BU8() required int bump,
      @BString() required String name,
      @BPublicKey() required Ed25519HDPublicKey updateAuthority,
      @BPublicKey() required Ed25519HDPublicKey rentAuthority,
      @BOption(BPublicKey()) required Ed25519HDPublicKey? approveAuthority,
      @BU8() required int schema,
      @BU64() required BigInt paymentAmountDaily,
      @BU64() required BigInt minRentalSeconds,
      @BOption(BU64()) required BigInt? maxRentalSeconds,
      @BBool() required bool transferrableEntries}) = _NamespaceData;

  factory NamespaceData.fromBorsh(Uint8List data) =>
      _$NamespaceDataFromBorsh(data);

  NamespaceData._();
}

@BorshSerializable()
class ReverseEntryData with _$ReverseEntryData {
  factory ReverseEntryData(
      {@BU8() required int bump,
      @BString() required String entryName,
      @BString() required String namespaceName}) = _ReverseEntryData;

  factory ReverseEntryData.fromBorsh(Uint8List data) =>
      _$ReverseEntryDataFromBorsh(data);

  ReverseEntryData._();
}
