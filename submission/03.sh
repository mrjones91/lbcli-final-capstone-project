# Which tx in block 216,351 spends the coinbase output of block 216,128?
block=$(bitcoin-cli -signet getblock $(bitcoin-cli -signet getblockhash 216351))
# 0000000e120ff9801366e9c75f1fbe6b72cc6a577bf16a402fd1521c3653f24d
# coinbase txid f3c6453448e45007b4b42c58357bd3a1fd9ac5b72ff6bf88f70f3b2bb3df381d - wrong ?
# answer -> 0e302b600d32b86c3362647f422e5605165a1e5c89c760d0d972e102f390c84e ???
coin_tx=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction $(bitcoin-cli -signet getblock $(bitcoin-cli -signet getblockhash 216128) | jq -r '.tx[0]')) | jq -r '.txid')
coin=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction $coin_tx) | jq -r '.vin[0].coinbase')
# echo "coin_tx: $coin_tx"
txs=$(echo $block | jq -r '.tx[]')
# echo "txs: "
# echo $txs

for tx in $txs
do
    # echo $tx
    test=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction $tx) | jq -r '.vin[].txid' | grep $coin_tx)
    # echo "test: $test"
    # echo "coin_tx: $coin_tx"

    if [[ $test == $coin_tx ]]; then
        echo $tx
        exit 0
    fi
done