#!/usr/bin/env bash


# This script queries facet and counts the number of occurrences of string "sportsbookMarketId", thus giving away the
# number of sportsbook markets returned by facet.

echo "[1] - prdss"
echo "[2] - prdwv"
echo "[3] - nxt"
echo "[4] - intbs1"

read -p "Your environment: " usr_in

if [[ $usr_in -lt 0 || $usr_in -gt 4 ]]
then
  echo "Not a valid environment"
  exit 1
elif [ $usr_in -eq 1 ]
then
  uri="http://prdss-scanfd-prdss.prd.fndlsb.net/api/sports/navigation/facet/v1/search"
elif [ $usr_in -eq 2 ]
then
  uri="http://prdwv-scanfd-prdwv.prd.fndlsb.net/api/sports/navigation/facet/v1/search"
elif [ $usr_in -eq 3 ]
then
  uri="http://njss1-scanfd-nxt.dev.fndlsb.net/api/sports/navigation/facet/v1/search"
elif [ $usr_in -eq 4 ]
then
  uri="http://njss1-scanfd-intbs1.dev.fndlsb.net/api/sports/navigation/facet/v1/search"
fi

echo "Querying $uri for string \"sportsbookMarketId\""
echo "=================================================================="

NUMBER_SB_MARKETS=$(curl --location --request POST $uri --header 'X-Application: dyMLAanpRyIsjkpJ' --header 'cache-control: no-cache' --header 'Content-Type: application/json' --header 'Cookie: ssoid=PLTBXSHGVFCU9ICM7NIUG8IC3ZWT95P4; ssoid=0AR3PII6XZO6L0FT338G8JK1YNTLBL41' --data-raw '{
  "filter": {
  }
}' | grep -o sportsbookMarketId | wc -l | tr -d ' ')

echo "=================================================================="
echo "Number of sportsbook markets: $NUMBER_SB_MARKETS"

exit 0