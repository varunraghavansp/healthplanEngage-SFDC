/**
 * Created by varun on 8/18/2019.
 */

import { LightningElement, track, api } from 'lwc';

export default class Multiselecttablewrapper extends LightningElement {
    @api title;
    @api icon;
    @api columns;
    @api hidecheckbox = false;
    @track tblselectedrow = [];
    @api rows;

    getselectedrecord(event) {
        //Set Selection
        const selectedRows = event.detail.selectedRows;
        const selectionChangeEvent = new CustomEvent('selectionchange', {
                    detail : {selectedrows: selectedRows},
        });
        this.dispatchEvent(selectionChangeEvent);
    }

    //Bubbles Up the row values
    disconnectedCallback() {
            console.log(JSON.stringify(tblselectedrow));
    }
}