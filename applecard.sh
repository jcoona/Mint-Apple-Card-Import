#!/usr/bin/env bash

# Program uploads Mint transactions using their "public API"
# Steps to run this program:
# 1. Go into your Wallet app, and click on Card Balance. Select the Statement you want to import.
# 2. Click Export Transactions and select Comma Separated Values (CSV). Save this file on your iCloud drive so you can access it on your computer.
# 3. Open the CSV file, and order the columns like: Date - Amount - Merchant - Type
# 4. Manually edit any poorly formatted merchant names. Manually enter the terms Expense or Income in the Type column.
# 5. Add a line at the end of the CSV file. Add text like "DONE". SAVE FILE!!!
# 6. Rename the CSV file as transactions.csv
# 7. Open Google Chrome and log in to Mint. Go to the transaction page, and open Chromes Inspect tab. In that tab, select Network.
# 8. Make a test transaction. Before you actually log it, clear the network calls. Add the transaction.
# 9. Find the network call for updateTransaction.xevent. Right click and select copy -> copy cURL.
# 10. Inside this code, delete lines 30 through 44 and re-paste with the cURL command you just copied. Keep && echo
# 11. Inside the CURL command, reference the merchant, date, amount variables. IE merchant='$merchant'&date='$tdate'&amount='$amount'&mtIsExpense='$expense'
# 12. Save file!!!!!!!!!!!
# 13. Give terminal permissions to this file by running chmod +x applecard.sh
# 14. Run script in terminal with ./applecard.sh
# 15. Make sure your transactions were uploaded properly.

while read p; do
	# Apple Card CSV's are formatted with comma delimitation.
  IFS=$',' read -ra COLS <<< "$p"

  printf "Start reading file\n"

  # This application considers the "date" to be the Clearing data, AKA the second column.
  prettydate="${COLS[1]}20"
  tdate="${prettydate//$'/'/%2F}"

  # Amount is found in column 6, Mint API does not take a $
  amount="${COLS[6]}"

  # This application takes column 3 to be the merchant, as it's usually the more descriptive value.
  merchant="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "${COLS[3]}")"

  printf "Query String = %q \n" 'merchant='$merchant'&date='$tdate'&amount='$amount
  printf "See cURL response below\n"

  <INSERT CURL COMMAND> && echo
done <transactions.csv

printf "Complete reading file\n"