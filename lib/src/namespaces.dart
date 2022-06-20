import 'package:borsh_annotation/borsh_annotation.dart';
import 'package:cardinal_namespaces/src/borsh/borsh_extensions.dart';
import 'package:cardinal_namespaces/src/classes/account_data.dart' as ad;
import 'package:cardinal_namespaces/src/classes/dtos.dart';
import 'package:cardinal_namespaces/src/constants.dart';
import 'package:cardinal_namespaces/src/pda.dart';
import 'package:solana/dto.dart';
import 'package:solana/solana.dart';

List<String> breakName(String fullName) {
  if (fullName.startsWith(twitterPrefix)) {
    return [twitterNamespace, fullName.split(twitterPrefix)[1]];
  }
  return fullName.split(nsDelim).sublist(0, 2);
}

String displayAddress({required String address, bool shorten = true}) {
  return shorten ? shortenAddress(address: address) : address;
}

String formatName(String namespace, String name) {
  return namespace == twitterNamespace
      ? "$twitterPrefix$name"
      : "$name$nsDelim$namespace";
}

Future<List<ad.AccountData<NamespaceData>>> getAllNamespaces(
    RpcClient client, String namespaceName, String entryName) async {
  final programAccounts = await client.getProgramAccounts(
      NAMESPACES_PROGRAM_ID.toBase58(),
      encoding: Encoding.base64,
      filters: [
        ProgramDataFilter.memcmp(
            offset: 0, bytes: accountDiscriminator("namespace"))
      ]);

  final List<ad.AccountData<NamespaceData>> namespaces = [];
  for (var programAccount in programAccounts) {
    try {
      var data = programAccount.account.data as BinaryAccountData;
      namespaces.add(ad.AccountData(
          NamespaceData.fromBorsh(Uint8List.fromList(data.data)),
          Ed25519HDPublicKey.fromBase58(programAccount.pubkey)));
    } catch (e) {
      print("failed to decode namespace");
    }
  }
  namespaces
      .sort((n1, n2) => n1.pubKey.toBase58().compareTo(n2.pubKey.toBase58()));
  return namespaces;
}

Future<ad.AccountData<ClaimRequest>> getClaimRequest(
    RpcClient client,
    String namespaceName,
    String entryName,
    Ed25519HDPublicKey requester) async {
  final namespaceResult = await findNamespaceId(namespaceName);
  final claimRequestResult =
      await findClaimRequestId(namespaceResult.publicKey, entryName, requester);
  final account =
      await client.getAccountInfo(claimRequestResult.publicKey.toBase58());
  final parsed = parseBytesFromAccount(account, ClaimRequest.fromBorsh);
  return ad.AccountData(parsed, claimRequestResult.publicKey);
}

Future<ad.AccountData<GlobalContext>> getGlobalContext(RpcClient client) async {
  final globalContextResult = await findGlobalContextId();
  final account =
      await client.getAccountInfo(globalContextResult.publicKey.toBase58());
  final parsed = parseBytesFromAccount(account, GlobalContext.fromBorsh);
  return ad.AccountData(parsed, globalContextResult.publicKey);
}

Future<List<NameEntryResult>> getNameEntriesForNamespace(
    RpcClient client, String namespaceName, List<String> entryNames) async {
  final namespaceResult = await findNamespaceId(namespaceName);
  final entries = await Future.wait(entryNames
      .map((e) => findNameEntryId(namespaceResult.publicKey, e))
      .toList());
  final entryIds = entries.map((e) => e.publicKey.toBase58()).toList();
  final accounts = await client.getMultipleAccounts(entryIds);

  final dataAccounts =
      accounts.map((account) => account?.data as BinaryAccountData);
  final parsedAccounts = dataAccounts
      .map((data) => EntryData.fromBorsh(Uint8List.fromList(data.data)))
      .toList();
  List<NameEntryResult> results = [];
  parsedAccounts.asMap().forEach((key, value) {
    results.add(NameEntryResult(
        ad.AccountData(value, Ed25519HDPublicKey.fromBase58(entryIds[key])),
        entryNames[key]));
  });
  return results;
}

Future<ad.AccountData<EntryData>> getNameEntry(
    RpcClient client, String namespaceName, String entryName) async {
  final namespaceResult = await findNamespaceId(namespaceName);
  final nameEntryResult =
      await findNameEntryId(namespaceResult.publicKey, entryName);
  final account = await client.getAccountInfo(
      nameEntryResult.publicKey.toBase58(),
      encoding: Encoding.base64);
  final parsed = parseBytesFromAccount(account, EntryData.fromBorsh);
  return ad.AccountData(parsed, nameEntryResult.publicKey);
}

Future<ad.AccountData<NamespaceData>> getNamespace(
    RpcClient client, Ed25519HDPublicKey namespaceId) async {
  final account = await client.getAccountInfo(namespaceId.toBase58());
  final parsed = parseBytesFromAccount(account, NamespaceData.fromBorsh);
  return ad.AccountData(parsed, namespaceId);
}

Future<ad.AccountData<NamespaceData>> getNamespaceByName(
    RpcClient client, String namespaceName) async {
  final namespaceResult = await findNamespaceId(namespaceName);
  return getNamespace(client, namespaceResult.publicKey);
}

Future<ad.AccountData<ReverseEntryData>> getReverseEntry(RpcClient client,
    Ed25519HDPublicKey namespace, Ed25519HDPublicKey publicKey) async {
  try {
    final reverseEntry = await findReverseEntryId(namespace, publicKey);
    final account = await client.getAccountInfo(
        reverseEntry.publicKey.toBase58(),
        encoding: Encoding.base58);
    final parsed = parseBytesFromAccount(account, ReverseEntryData.fromBorsh);
    return ad.AccountData(parsed, publicKey);
  } catch (e) {
    final reverseEntry = await findDeprecatedReverseEntryId(publicKey);
    final account = await client.getAccountInfo(
        reverseEntry.publicKey.toBase58(),
        encoding: Encoding.base58);
    final parsed = parseBytesFromAccount(account, ReverseEntryData.fromBorsh);
    return ad.AccountData(parsed, publicKey);
  }
}

Future<String> nameForDisplay(RpcClient client, Ed25519HDPublicKey namespace,
    Ed25519HDPublicKey pubKey) async {
  final name = await tryGetName(client, namespace, pubKey);
  return name ?? displayAddress(address: pubKey.toBase58());
}

String shortenAddress({required String address, int chars = 5}) {
  return "${address.substring(0, chars)}...${address.substring(address.length - chars)}";
}

Future<String?> tryGetName(RpcClient client, Ed25519HDPublicKey namespace,
    Ed25519HDPublicKey publicKey) async {
  try {
    final reverseEntry = await getReverseEntry(client, namespace, publicKey);
    return formatName(
        reverseEntry.parsed.namespaceName, reverseEntry.parsed.entryName);
  } catch (e) {
    print(e);
  }
  return null;
}

Future<ad.AccountData<ReverseEntryData>?> tryGetReverseEntry(RpcClient client,
    Ed25519HDPublicKey namespace, Ed25519HDPublicKey publicKey) async {
  try {
    return await getReverseEntry(client, namespace, publicKey);
  } catch (e) {
    return null;
  }
}

class NameEntryResult {
  String name;
  ad.AccountData<EntryData> account;
  NameEntryResult(this.account, this.name);
}
