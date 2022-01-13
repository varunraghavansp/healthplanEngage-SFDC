/**
 * Created by varun on 3/20/2020.
 */

import { LightningElement, api, track, wire } from 'lwc';
import getRecords from '@salesforce/apex/be_standardComponentController.getRecords';

export default class Componentkeybenefitselectionradio extends LightningElement {
    @api label;
    @api sObject;
    @api selectedComponent;
    @api queryFields;
    @api searchField;
    @api searchTerm;
    @api searchOrder;
    @track data = [];
    @track options = [];
    @track value = [];
    @api planfamily = '';
    @api marketingplanbenefits = [];

    get jsonString() {
            return JSON.stringify({object: this.sObject, queryFields : this.queryFields, searchField : this.searchField, searchTerm : this.searchTerm, order: this.searchOrder, filter: "Plan_Family__c = '" + this.planfamily + "'"});
    }

    connectedCallback() {
        for(let marketingplanbenefit of this.marketingplanbenefits){
            if(this.searchTerm === marketingplanbenefit.Attribute_Id__c){
                this.value = marketingplanbenefit.Attribute_Value__c;
                break;
            }
        }
    }

    @wire(getRecords, {jsonString : '$jsonString' })
    parseResults({error, data}){
        if (data){
            console.log(this.jsonString);
            var responsemsg = JSON.parse(data);
            if(responsemsg.isSuccess == true){
                this.data = responsemsg.results.data[0][this.sObject];
                //attributeValue.In_Network_Display_Value__c + ' : ' +
                this.data.forEach(attributeValue => this.options.push({label: attributeValue.Name + ' : ' +  attributeValue.Limits_And_Exceptions_Text_Area__c , value: attributeValue.Id}));
            }
            else{
                console.log(this.jsonString);
                console.log(responsemsg.errMsg);
            }
        } else if (error){
            console.log(JSON.stringify(error));
        }
    }

    attributevaluechanged(event) {
       /* for(let marketingplanbenefit of this.marketingplanbenefits){
            if(this.searchTerm === marketingplanbenefit.Attribute_Id__c){
                marketingplanbenefit.Attribute_Value__c = event.detail.value;
                break;
            }
        }*/
        const selectionChangeEvent = new CustomEvent('attributevaluechange', {
                    detail : {attribute: this.searchTerm, attributevalueid: event.detail.value},
        });
        this.dispatchEvent(selectionChangeEvent);
    }

}