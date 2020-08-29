#cleanup any old data
rm etl.db accounts.csv contacts.csv;

#Extract and Transform from CSV
sqlite3 etl.db < etl.sql;

#Upsert accounts to SFDC
sfdx force:data:bulk:upsert --sobjecttype=Account --csvfile=accounts.csv --externalid=shahin__external__c --targetusername=dev-org --wait=5 --json 

#Upsert related contacts
sfdx force:data:bulk:upsert --sobjecttype=Contact --csvfile=contacts.csv --externalid=shahin__key__c --targetusername=dev-org --wait=5 --json 

sfdx force:org:open -u dev-org -p /750