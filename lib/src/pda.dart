import 'dart:convert';

import 'package:solana/solana.dart';

import 'constants.dart';

const _maxBumpSeed = 255;
const _maxSeedLength = 32;
const _maxSeeds = 16;

Future<ProgramAddressResult> findClaimRequestId(Ed25519HDPublicKey namespaceId,
    String entryName, Ed25519HDPublicKey requester) async {
  return findProgramAddressWithNonce(seeds: [
    utf8.encode(CLAIM_REQUEST_SEED),
    namespaceId.bytes,
    utf8.encode(entryName),
    requester.bytes
  ], programId: NAMESPACES_PROGRAM_ID);
}

Future<ProgramAddressResult> findDeprecatedReverseEntryId(
    Ed25519HDPublicKey publicKey) async {
  return findProgramAddressWithNonce(seeds: [
    utf8.encode(REVERSE_ENTRY_SEED),
    publicKey.bytes,
  ], programId: NAMESPACES_PROGRAM_ID);
}

Future<ProgramAddressResult> findGlobalContextId() async {
  return findProgramAddressWithNonce(seeds: [
    utf8.encode(GLOBAL_CONTEXT_SEED),
  ], programId: NAMESPACES_PROGRAM_ID);
}

Future<ProgramAddressResult> findNameEntryId(
    Ed25519HDPublicKey namespaceId, String entryName) async {
  return findProgramAddressWithNonce(seeds: [
    utf8.encode(ENTRY_SEED),
    namespaceId.bytes,
    utf8.encode(entryName)
  ], programId: NAMESPACES_PROGRAM_ID);
}

Future<ProgramAddressResult> findNamespaceId(String namespaceName) async {
  return findProgramAddressWithNonce(
      seeds: [utf8.encode(NAMESPACE_SEED), utf8.encode(namespaceName)],
      programId: NAMESPACES_PROGRAM_ID);
}

Future<ProgramAddressResult> findProgramAddressWithNonce({
  required Iterable<Iterable<int>> seeds,
  required Ed25519HDPublicKey programId,
}) async {
  if (seeds.length > _maxSeeds) {
    throw const FormatException('you can give me up to $_maxSeeds seeds');
  }
  final overflowingSeed = seeds.where((s) => s.length > _maxSeedLength);
  if (overflowingSeed.isNotEmpty) {
    throw const FormatException(
      'one or more of the seeds provided is too big',
    );
  }
  final flatSeeds = seeds.fold(<int>[], _flatten);
  int bumpSeed = _maxBumpSeed;
  while (bumpSeed >= 0) {
    try {
      final pubKey = await Ed25519HDPublicKey.createProgramAddress(
        seeds: [...flatSeeds, bumpSeed],
        programId: programId,
      );
      return ProgramAddressResult(publicKey: pubKey, nonce: bumpSeed);
    } on FormatException {
      bumpSeed -= 1;
    }
  }

  throw const FormatException('cannot find program address with these seeds');
}

Future<ProgramAddressResult> findReverseEntryId(
    Ed25519HDPublicKey namespace, Ed25519HDPublicKey publicKey) async {
  return findProgramAddressWithNonce(seeds: [
    utf8.encode(REVERSE_ENTRY_SEED),
    namespace.bytes,
    publicKey.bytes,
  ], programId: NAMESPACES_PROGRAM_ID);
}

Iterable<int> _flatten(Iterable<int> concatenated, Iterable<int> current) =>
    concatenated.followedBy(current).toList();

class ProgramAddressResult {
  Ed25519HDPublicKey publicKey;
  int nonce;
  ProgramAddressResult({required this.publicKey, required this.nonce});
}
