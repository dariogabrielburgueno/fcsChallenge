Overview
This technical challenge is designed to assess candidates on the fundamental skills required for the Junior 
Salesforce Developer role. It focuses on Salesforce development, Apex 
programming, declarative tools (Flows), and problem-solving skills.

Part 1

●Create a Record-Triggered Flow that activates when a Quote record is created or updated. 
● If the Discount__c field on the Quote is greater than or equal to 15%, update the 
Approval_Status__c field to "Pending Approval". 
● Send an Email Alert to a designated Manager (Manager__c lookup field) when approval is 
required. 
● Ensure the flow only runs when the status is not already "Pending Approval".

Part 2

● Write a bulkified Apex trigger on the Quote object that: 
○ Fires after insert and after update. 
○ Checks if the Approval_Status__c field on the Quote has been changed to "Approved". 
○ If so, updates the Amount field on the related Opportunity record with the 
Total_Amount__c from the Quote. 
○ Ensures that only the most recently approved Quote updates the Opportunity. 


Part 3
● Create a Lightning Web Component (LWC) that displays a list of all pending Quotes for the 
logged-in user. 
● The LWC should: 
○ Retrieve all Quotes where Approval_Status__c = "Pending Approval". 
○ Display a table with Quote Name, Opportunity Name, Discount__c, Total_Amount__c, 
and an "Approve" button. 
○ Clicking "Approve" should update the Approval_Status__c field of the Quote to 
"Approved". 
● This should work together with the Apex Trigger built for Part 2. So the related Opportunity 
Amount field should be updated with the most recent approved Quote.
