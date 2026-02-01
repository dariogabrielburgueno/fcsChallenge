import { LightningElement, wire } from 'lwc';
import getPendingQuotes from '@salesforce/apex/PendingQuotes.getPendingQuotes';
import approveQuote from '@salesforce/apex/PendingQuotes.approveQuote';
import { refreshApex } from '@salesforce/apex';

const columns = [
    { label: 'Quote Name', fieldName: 'Name' },
    { label: 'Opportunity Name', fieldName: 'OpportunityName' },
    { label: 'Discount', fieldName: 'Discount__c', type: 'percent' },
    { label: 'Total Amount', fieldName: 'Total_Amount__c', type: 'currency' },
    { 
        type: 'button', 
        typeAttributes: {
            iconName: 'utility:approval',
            iconPosition: 'center',
            label: 'Approve', 
            name: 'approve' 
        }
    }
];

export default class Part3 extends LightningElement {
    columns = columns;
    data = [];
    wiredQuotesResult;

    @wire(getPendingQuotes)
    wiredQuotes(result) {
        this.wiredQuotesResult = result;
        if (result.data) {
            this.data = result.data.map(quote => ({
                ...quote,
                OpportunityName: quote.Opportunity ? quote.Opportunity.Name : ''
            }));
        }
    }

    handleRowAction(event) {
        const quoteId = event.detail.row.Id;
        approveQuote({ quoteId })
            .then(() => {
                refreshApex(this.wiredQuotesResult);
            });
    }
}