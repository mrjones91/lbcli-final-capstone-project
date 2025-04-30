# How many satoshis did this transaction pay for fee?: b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb
# 0.20731298 - 0.00010000 - 0.20710602 - 0.00010000
vin=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction 6d5d134b8d3c02d88196d8f483fbff5a9bb121bf8c53e5967f287cdf17f6d0bc) | jq '.vout[0].value')
vout=$(bitcoin-cli -signet decoderawtransaction $(bitcoin-cli -signet getrawtransaction b71fb9ab7707407cc7265591e0c0d47d07afede654f91de1f63c0cb522914bcb) | jq '.vout[].value' | tr ' ' '\n' | paste -sd+ - | bc)
vi=$(echo "$vin * 100000000" | bc)
vo=$(echo "$vout * 100000000" | bc)
echo "($vi - $vo)/1" | bc