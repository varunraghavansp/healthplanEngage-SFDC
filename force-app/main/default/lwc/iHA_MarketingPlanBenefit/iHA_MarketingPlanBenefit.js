import { LightningElement,api,track } from 'lwc';

export default class IHA_MarketingPlanBenefit extends LightningElement {

    @api key;
    @api mktplanname;
    @api attributecategory;
    @api attributedisplayname;
    @api attrcattomktplanbenmap;
    @track innetworkdisplayname;

    connectedCallback() {
        for(var index=0;index<this.attrcattomktplanbenmap.length;index++) {
            var catKey = this.attrcattomktplanbenmap[index].key;
            var catValue = this.attrcattomktplanbenmap[index].value;
            if(catKey===this.attributecategory) {
                console.log(catKey);
                console.log(this.attributecategory);
                for(var valueIndex=0;valueIndex<catValue.length;valueIndex++) {
                    console.log(this.attributedisplayname);
                    console.log(JSON.stringify(catValue[valueIndex]));
                    console.log(this.mktplanname);
                    if(catValue[valueIndex].Attribute_Display_Name__c===this.attributedisplayname && catValue[valueIndex].Marketing_Plan_Name__c === this.mktplanname) {
                        this.innetworkdisplayname = catValue[valueIndex].In_Network_Display_Name__c;
                        break;
                    }
                }
            }
        }

    }
}