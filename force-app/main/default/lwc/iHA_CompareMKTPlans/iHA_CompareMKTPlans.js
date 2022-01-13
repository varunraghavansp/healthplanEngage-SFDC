import { LightningElement,track, api } from 'lwc';
import IndependentHealthLogo from '@salesforce/resourceUrl/IndependentHealth';
import EmailIcon from '@salesforce/resourceUrl/EmailIcon';
import DownloadIcon from '@salesforce/resourceUrl/DownloadIcon';
import PrintIcon from '@salesforce/resourceUrl/PrintIcon';
import getMarketingPlanBenefits from '@salesforce/apex/IHA_CompareMKTPlansController.getMarketingPlanBenefits';
export default class IHA_CompareMKTPlans extends LightningElement {
    @api marketingplanids = [];
    @track marketingPlanBenefits = [];
    @track attrCatToAttrDispName = [];
    @track marketingPlans = [];
    @track totalMKTPlans;
    @track tableSectionColSpan;
    @track error;

    // Expose the static resource URL for use in the template
    indHealthLogoUrl = IndependentHealthLogo;
    emailIcon = EmailIcon;
    printIcon = PrintIcon;
    downloadIcon = DownloadIcon;

    //executes on load of component.
    connectedCallback() {
        getMarketingPlanBenefits({ marketingplanids: this.marketingplanids })
        .then(result => {
            var atCatToMKTBMap = result.attrCategoryToMKTPBMap;
            for(var key in atCatToMKTBMap) {
                this.marketingPlanBenefits.push({value:atCatToMKTBMap[key], key:key});
            }

            var retAttrCatToAttrDispName = result.attrCatToAttrDispNameMap;
            for(var key in retAttrCatToAttrDispName) {
                this.attrCatToAttrDispName.push({value:retAttrCatToAttrDispName[key], key:key});
            }
            
            this.marketingPlans = result.marketingPlans;
            this.totalMKTPlans = result.totalMKTPlans;
            this.tableSectionColSpan = this.totalMKTPlans+1;
        })
        .catch(error => {
            this.error = error;
            console.log("error:::::"+JSON.stringify(error));
        });
    }

}