/**
 * Created by varun on 7/31/2019.
 */

import { LightningElement, track, api } from 'lwc';

export default class Censustblwrapper extends LightningElement {
    @api title;
    @api icon;
    @api columns;
    @track tblselectedrow = [];
    @api rows;

    getSelectedName(event) {
        var previousRows = this.tblselectedrow;
        var previousRowRecords = [];
        const selectedRows = event.detail.selectedRows;
        //Reset Selection
        const deselectionEvent = new CustomEvent('selectionchange', {
            detail : {selectedrowid: '', selectedrow: {}},
        });
        this.dispatchEvent(deselectionEvent);
        //Set Selection
        var currSelectedRow = [];
        for(let i = 0; i < selectedRows.length; i++){
            if(previousRows.length == 0){
                previousRows.push(selectedRows[i].Id);
                previousRowRecords.push(selectedRows[i]);
            }else{
                if(selectedRows[i].Id != previousRows[0]){
                    previousRows = [];
                    previousRowRecords = [];
                    previousRows.push(selectedRows[i].Id);
                    previousRowRecords.push(selectedRows[i]);
                    break;
                }
            }
        }

        this.tblselectedrow = previousRows;

        const selectionChangeEvent = new CustomEvent('selectionchange', {
                    detail : {selectedrowid: previousRows.length == 0 ? '': previousRows[0], selectedrow : previousRowRecords.length === 0 ? {} : previousRowRecords[0]},
        });
        this.dispatchEvent(selectionChangeEvent);
    }
}