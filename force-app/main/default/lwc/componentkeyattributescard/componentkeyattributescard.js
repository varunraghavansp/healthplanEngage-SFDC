/**
 * Created by varun on 3/22/2020.
 */

import { LightningElement, api, track, wire } from 'lwc';
import getRecords from '@salesforce/apex/be_standardComponentController.getRecords';

export default class Componentkeyattributescard extends LightningElement {
    @api sobject;
    @api selectedcomponent;
    @api queryfields;
    @api searchfield;
    @api searchterm;
    @api searchorder;
    @api filter;
    @api planfamily;
    @api marketingplanbenefits = [];
    @track data = [];

    get jsonString() {
            return JSON.stringify({object: this.sobject, queryFields : this.queryfields, searchField : this.searchfield, searchTerm : this.searchterm, order: this.searchorder, filter: this.filter});
    }

    @wire(getRecords, {jsonString : '$jsonString' })
    parseResults({error, data}){
        if (data){
            var responsemsg = JSON.parse(data);
            if(responsemsg.isSuccess == true){
                console.log(responsemsg.results.data[0][this.sobject]);
                this.data = responsemsg.results.data[0][this.sobject];
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
        const selectionChangeEvent = new CustomEvent('attributevaluechange', {
                    detail : event.detail,
        });
        this.dispatchEvent(selectionChangeEvent);
    }
}