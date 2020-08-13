# Mint Apple Card Import Tool
Use this tool to import your Apple Card transactions to [Mint Intuit.](https://www.mint.com/)

## Getting the Apple Card Transactions
Using the Apple Wallet App, view your Card Balance and select the applicable Statement.

Select the bottom option, **Export Transactions**, and select **Comma Separated Values (CSV).**

Save this somewhere on your iCloud Drive where you will be able to access this on your personal computer.

## Formatting the CSV File
You will be uploading statements based on the fourth column merchant names, so take a chance to review and modify any names you want.
Rename the file to transactions.csv

## Editing the Script
Each time you run this script you will have to modify it. 

Log into your Mint account, and use your inspect tool to monitor network traffic. Add a test transaction and look for the network call for `updateTransaction.xevent`. Copy the cURL command for this network call, and paste it into the `<INSERT CURL COMMAND HERE>` section in your script.

In the curl command, modify the part of the line where the merchant, date, and amounts are set. Add the following parameters:
`merchant='$merchant'&date='$tdate'&amount='$amount'`

## Running Script
Open Terminal and run the following command:

`chmod +x applecard.sh`

`./applecard.sh`

Make sure that the transaction CSV file is in the same directory. At this point, check to make sure your transactions were uploaded properly.
