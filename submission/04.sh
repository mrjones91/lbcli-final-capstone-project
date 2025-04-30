# Which public key signed input 0 in this tx: d948454ceab1ad56982b11cf6f7157b91d3c6c5640e05c041cd17db6fff698f7
tx=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction d948454ceab1ad56982b11cf6f7157b91d3c6c5640e05c041cd17db6fff698f7))
input0id=$(echo $tx | jq -r '.vin[0].txid')
input0vout=$(echo $tx | jq -r '.vin[0].vout')
bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction $input0id)
