@isTest
public class QuoteUpdateTriggerTest {
//Test if trigger triggered and if the amount was the same
    @isTest 
    static void testAfter(){
        Account acc=new Account(Name='Test Acc');
        insert acc;
       
        Id pricebookId=Test.getStandardPricebookId();
        
        Product2 prod=new Product2(
        	Name='Test Product',
            IsActive=true
        );
        insert prod;
        
        PricebookEntry pbe= new PricebookEntry(
        	Pricebook2Id=pricebookId,
            Product2Id=prod.Id,
            UnitPrice=100,
            IsActive=true
        );
        insert pbe;
        
               
        Opportunity opp=new Opportunity(
            Name='Test Opp',
            StageName='Prospecting',
            CloseDate=Date.today(),
            AccountId=acc.Id,
            Amount=1000,
            Pricebook2Id=pricebookId
            
        );
        insert opp;
     
        Test.startTest();
        Quote q=new Quote(
        	Name='Test Quote',
            OpportunityId=opp.Id,
            Approval_Status__c='Draft',
            Discount__c=12,
            Pricebook2Id=pricebookId
                     
        );
        insert q;
        
        QuoteLineItem qli=new QuoteLineItem(
            QuoteId=q.Id,
            PricebookEntryId=pbe.Id,
            Quantity=10,
            UnitPrice=100
        );
        insert qli;
        
       
        
        q.Approval_Status__c='Approved';
        update q;
       
      
        Test.stopTest();
        
        
        Opportunity updatedOpp =[SELECT Amount FROM Opportunity WHERE Id= :q.OpportunityId];
        Quote insertedQuote =[SELECT Total_Amount__c FROM Quote WHERE Id = :q.Id];
        System.debug(updatedOpp);
        System.debug(insertedQuote);
        System.assertEquals(insertedQuote.Total_Amount__c,updatedOpp.Amount,'Shoud be the same');
    }
    //test that the amount shouldnt change if it is NOT approved
    //
    @isTest
    static void testNotApproved(){
        Account acc=new Account(Name='Test Acc2');
        insert acc;
        
        Opportunity opp=new Opportunity (
        	Name='Test Opp2',
            StageName='Prospecting',
            CloseDate=Date.today(),
            AccountId=acc.Id,
            Amount=2000
        );
        insert opp;
        Quote q=new Quote(
        	Name='Test q2',
            OpportunityId=opp.Id,
            Approval_Status__c='Draft'
        );
        insert q;
        
        Opportunity opps=[SELECT Amount FROM Opportunity WHERE Id= :opp.Id];
        
        System.assertEquals(2000,opps.Amount);
        
       
    }
    
    
    
}