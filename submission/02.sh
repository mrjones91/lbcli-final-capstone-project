# How many new outputs were created by block 243,825?
sum=0
txs=$(bitcoin-cli -regtest getblock $(bitcoin-cli -regtest getblockhash 243825) | jq -r '.tx[]')

for tx in $txs
do
    # echo $tx
    count=$(bitcoin-cli -regtest decoderawtransaction $(bitcoin-cli -regtest getrawtransaction $tx) | jq '.vout | length')
    i=$((count + sum))
    sum=$i
done
echo $sum