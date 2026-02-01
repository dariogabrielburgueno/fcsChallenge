public class QuoteToOppUpdate {

    public static void updateOpp(List<Quote> newQuotes, Map<Id, Quote> oldQuotesMap) {
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        
        for (Quote q : newQuotes) {
            
            if (q.Approval_Status__c == 'Approved' && (oldQuotesMap == null || oldQuotesMap.get(q.Id).Approval_Status__c != 'Approved') && q.Total_Amount__c>0) {
                oppsToUpdate.add(new Opportunity(
                	Id=q.OpportunityId,
                    Amount=q.Total_Amount__c
                ));
                
            }
        }
        if (!oppsToUpdate.isEmpty()){
            update oppsToUpdate;
        }
        
        
        
    }
}