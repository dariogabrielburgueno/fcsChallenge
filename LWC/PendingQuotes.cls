public with sharing class PendingQuotes {
    
    @AuraEnabled(cacheable=true)
    public static List<Quote> getPendingQuotes() {
        return [SELECT Id, Name, Approval_Status__c, Total_Amount__c, Opportunity.Name
                FROM Quote 
                WHERE Approval_Status__c = 'Pending Approval' 
                AND Manager__c = :UserInfo.getUserId()
                Limit 100];
    }
    @AuraEnabled
    public static void approveQuote(Id quoteId) {
        Quote q = [SELECT Id, Approval_Status__c FROM Quote WHERE Id = :quoteId LIMIT 1];
        q.Approval_Status__c = 'Approved';
        update q;
    }

}
