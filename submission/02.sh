# How many new outputs were created by block 243,825?
sum=0
txs=$(bitcoin-cli -signet getblock $(bitcoin-cli -signet getblockhash 243825) | jq -r '.tx[]')

for tx in $txs
do
    # echo $tx
    count=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction $tx) | jq '.vout | length')
    i=$((count + sum))
    sum=$i
done
echo $sum