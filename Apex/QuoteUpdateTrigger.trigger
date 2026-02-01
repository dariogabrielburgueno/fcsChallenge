trigger QuoteUpdateTrigger on Quote (after insert, after update) {
    
            QuoteToOppUpdate.updateOpp(Trigger.new, Trigger.oldMap);
        
    
}