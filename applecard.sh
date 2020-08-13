#!/usr/bin/env bash

# Program uploads Mint transactions using their "public API"
# Steps to run this program:
# 1. Go into your Wallet app, and click on Card Balance. Select the Statement you want to import.
# 2. Click Export Transactions and select Comma Separated Values (CSV). Save this file on your iCloud drive so you can access it on your computer.
# 3. Manually edit any poorly formatted merchant names.
# 4. Rename the CSV file as transactions.csv
# 5. Open Google Chrome and log in to Mint. Go to the transaction page, and open Chromes Inspect tab. In that tab, select Network.
# 6. Make a test transaction. Before you actually log it, clear the network calls. Add the transaction.
# 7. Find the network call for updateTransaction.xevent. Right click and select copy -> copy cURL.
# 8. Inside this code, delete lines 30 through 44 and re-paste with the cURL command you just copied. Keep && echo
# 9. Inside the CURL command, reference the merchant, date, amount variables. IE merchant='$merchant'&date='$tdate'&amount='$amount'&mtIsExpense='$expense'
# 10. Save file!!!!!!!!!!!
# 11. Give terminal permissions to this file by running chmod +x applecard.sh
# 12. Run script in terminal with ./applecard.sh
# 13. Make sure your transactions were uploaded properly.

# By default, Apple Card does not add a newline to the end of the file.
# in order for all transactions to be read, this newline needs to be added.
printf "Adding End of Line to CSV file\n"
echo >> transactions.csv

printf "Start reading file\n\n"

while read p; do
  # Apple Card CSV's are formatted with comma delimitation.
  IFS=$',' read -ra COLS <<< "$p"

  if [ "${COLS[2]}" == "Description" ]
  then
  	printf "First section is header: skipping\n"
  	continue
  fi

  # This application considers the "date" to be the Clearing data, AKA the second column.
  prettydate="${COLS[1]}20"
  tdate="${prettydate//$'/'/%2F}"

  # If we got to the newline at the end, stop running the program.
  if [ "$prettydate" == "20" ]
  then
  	printf "End of file reached: ending\n"
  	continue
  fi

  # Amount is found in column 6, Mint API does not take a $
  amount="${COLS[6]}"

  # This application takes column 3 to be the merchant, as it's usually the more descriptive value.
  merchant="$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "${COLS[3]}")"

  # Display data for user
  printf "Query String = %q \n" 'merchant='$merchant'&date='$tdate'&amount='$amount
  printf "Merchant = " 
  echo ${COLS[3]}
  printf "Date = " 
  echo $prettydate
  printf "Amount = " 
  echo $amount
  printf "See cURL response below\n"

  <INSERT CURL COMMAND HERE> && echo
done <transactions.csv

printf "Complete reading file\n"