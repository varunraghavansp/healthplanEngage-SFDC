import { LightningElement,track, api } from 'lwc';
import IndependentHealthLogo from '@salesforce/resourceUrl/IndependentHealth';
import getQuoteLineBenefits from '@salesforce/apex/QuoteLineBenefitsController.getQuoteLineBenefits';

export default class Groupbenefitscomparison extends LightningElement {
    @api recordId;
    @api quotelineids = [];
    @track quoteLineBenefits = [];
    @track attrCatToAttrDispName = [];
    @track quotelines = [];
    @track totalMKTPlans;
    @track tableSectionColSpan;
    @track error;

    // Expose the static resource URL for use in the template
    indHealthLogoUrl = IndependentHealthLogo;

    //executes on load of component.
    connectedCallback() {
        this.quotelineids = [this.recordId];
        getQuoteLineBenefits({ quoteLineIds: this.quotelineids })
        .then(result => {
            var atCatToMKTBMap = result.attrCategoryToMKTPBMap;
            for(var key in atCatToMKTBMap) {
                this.quoteLineBenefits.push({value:atCatToMKTBMap[key], key:key});
            }

            var retAttrCatToAttrDispName = result.attrCatToAttrDispNameMap;
            for(var key in retAttrCatToAttrDispName) {
                this.attrCatToAttrDispName.push({value:retAttrCatToAttrDispName[key], key:key});
            }

            this.quotelines = result.quoteLines;
            this.totalMKTPlans = result.totalMKTPlans;
            console.log(JSON.stringify(this.quotelines));
           console.log(JSON.stringify(this.quoteLineBenefits));
           console.log(JSON.stringify(this.attrCatToAttrDispName));
            this.tableSectionColSpan = this.totalMKTPlans+3;
        })
        .catch(error => {
            this.error = error;
            console.log("error:::::"+JSON.stringify(error));
        });
    }
}