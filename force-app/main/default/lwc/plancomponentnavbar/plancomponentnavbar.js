/**
 * Created by varun on 3/20/2020.
 */

import { LightningElement, api, track, wire } from 'lwc';
import getRecords from '@salesforce/apex/be_standardComponentController.getRecords';

export default class Plancomponentnavbar extends LightningElement {
    @track sections = [];
    @api sobject;
    @api queryfields;
    @api searchfield;
    @api searchterm;
    @api searchorder;
    @api filter;
    @track data = [];
    @track options = [];
    @track items = [];
    @track initiallySelectedComponent = '';

    get jsonString() {
        return JSON.stringify({object: this.sobject, queryFields : this.queryfields, searchField : this.searchfield, searchTerm : this.searchterm, order: this.searchorder, filter: this.filter});
    }

    @wire(getRecords, {jsonString : '$jsonString' })
    parseResults({error, data}){
        if (data){
            var responsemsg = JSON.parse(data);
            if(responsemsg.isSuccess == true){
                this.data = responsemsg.results.data[0][this.sobject];
                this.data.forEach(planTemplateComponent => this.items.push({label: planTemplateComponent.Component_Name__c, name: planTemplateComponent.Plan_Component__c}));
                this.options = [{label: 'Modify Rider', items: this.items}];
                this.initiallySelectedComponent = this.items[0].name;
            }
            else{
                console.log(this.jsonString);
                console.log(responsemsg.errMsg);
            }
        } else if (error){
            console.log(JSON.stringify(error));
        }
    }

     handleSelect(event) {
        console.log(event.detail.name);
        const selectionChangeEvent = new CustomEvent('selectionchange', {
                    detail : {selectedcomponentid: event.detail.name},
        });
        this.dispatchEvent(selectionChangeEvent);
     }



}