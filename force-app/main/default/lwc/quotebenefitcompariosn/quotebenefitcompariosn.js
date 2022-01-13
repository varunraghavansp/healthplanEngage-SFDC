/**
 * Created by varun on 2/22/2021.
 */

import { LightningElement,api,track } from 'lwc';


export default class Quotebenefitcompariosn extends LightningElement {
    @api displayvalue;
    @api quotelineid;
    @api key;
    @api mktplanname;
    @api attributecategory;
    @api attributedisplayname;
    @api attrcattomktplanbenmap;
    @track innetworkdisplayname;
    @track outofnetworkdisplayname;
    @track limitsandexceptions;

    connectedCallback() {
        for(var index=0;index<this.attrcattomktplanbenmap.length;index++) {
            var catKey = this.attrcattomktplanbenmap[index].key;
            var catValue = this.attrcattomktplanbenmap[index].value;
            if(catKey===this.attributecategory) {
                for(var valueIndex=0;valueIndex<catValue.length;valueIndex++) {
                    if(catValue[valueIndex].Attribute_Display_Name__c===this.attributedisplayname && catValue[valueIndex].Marketing_Plan_Name__c === this.mktplanname) {
                        if(this.displayvalue === "InNetwork"){
                            this.innetworkdisplayname = catValue[valueIndex].In_Network_Display_Name__c;
                        }else if(this.displayvalue ==="OutNetwork"){
                            this.outofnetworkdisplayname = catValue[valueIndex].Out_of_Network_Display_Value__c;
                        }else if(this.displayvalue === "Limits"){
                            this.limitsandexceptions = catValue[valueIndex].Limits_and_Exceptions__c;
                        }
                        break;
                    }
                }
            }
        }

    }
}