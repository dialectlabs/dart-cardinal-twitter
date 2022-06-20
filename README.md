
[![Twitter Follow](https://img.shields.io/twitter/follow/saydialect?style=social)](https://twitter.com/saydialect)
[![Discord](https://img.shields.io/discord/944285706963017758?label=Discord)](https://discord.gg/cxtZVyrJ)

## Dart library for Cardinal namespaces

This library is a partial dart implementation of Cardinal's namespace protocol, specifically enabling the use of Twitter handles as wallet identification in Flutter applications.

## Implementation

1. Return a given wallet's registered Twitter handle

    ```dart
    final String twitterHandle = await tryGetName(
        environment: SolanaEnvironment, // mainnet | devnet | localnet
        namespacePublicKey: PublicKey, // Cardinal namespaces program's public key, value provided in this package as 'NAMESPACES_PROGRAM_ID'
        publicKey: PublicKey // wallet's public key to query as a string
    );
    ```
    ```

2. Return a given Twitter handle's registered wallet public key

    ```dart
    final PublicKey publicKey = await getNameEntry(
        environment: SolanaEnvironment, // mainnet | devnet | localnet
        namespace: String, // Twitter namespaces id, value provided in this package as 'twitterNamespace'
        twitterHandle: String // Twitter handle to query as a string
    );
    ```


## Further Help & Documentation

We will continue to update documentation as often as possible. But if you need help, feel free to reach out in our [Dialect Discord server](https://discord.gg/wK6WX7974J).