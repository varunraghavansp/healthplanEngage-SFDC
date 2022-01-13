/**
 * Created by varun on 12/14/2020.
 */

import { LightningElement, track, api, wire } from 'lwc';
import {FlowAttributeChangeEvent, FlowNavigationNextEvent} from 'lightning/flowSupport';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
/** Apex methods from ContactLookupController */
import search from '@salesforce/apex/IHA_ContactLookupController.search';
import getRecentlyViewed from '@salesforce/apex/IHA_ContactLookupController.getRecentlyViewed';

export default class GroupquotebasicsFc extends LightningElement {
    @track _account_record;
    @track _quote_effective_date;
    @track _contact_record_id;
    @api notifyViaAlerts = false;

    isMultiEntry = false;
    maxSelectionSize = 1;
    initialSelection = [
         {
             id: 'contact_record_id',
             sObjectType: 'Contact',
             icon: 'standard:contact',
             title: 'Inital selection',
             subtitle: 'Not a valid record'
         }
     ];
    errors = [];
    recentlyViewed = [];
    newRecordOptions = [
        { value: 'Contact', label: 'New Contact' }
    ];

     /**
     * Loads recently viewed records and set them as default lookpup search results (optional)
     */
    @wire(getRecentlyViewed)
    getRecentlyViewed({ data }) {
        if (data) {
            this.recentlyViewed = data;
            this.initLookupDefaultResults();
        }
    }

    connectedCallback() {
        this.initLookupDefaultResults();
    }
    /**
     * Initializes the lookup default results with a list of recently viewed records (optional)
     */
    initLookupDefaultResults() {
        // Make sure that the lookup is present and if so, set its default results
        const lookup = this.template.querySelector('c-lookup');
        if (lookup) {
            lookup.setDefaultResults(this.recentlyViewed);
        }
    }

    /**
     * Handles the lookup search event.
     * Calls the server to perform the search and returns the resuls to the lookup.
     * @param {event} event `search` event emmitted by the lookup
     */
    handleLookupSearch(event) {
        const lookupElement = event.target;
        // Call Apex endpoint to search for records and pass results to the lookup
        search(event.detail)
            .then((results) => {
                lookupElement.setSearchResults(results);
            })
            .catch((error) => {
                this.notifyUser('Lookup Error', 'An error occured while searching with the lookup field.', 'error');
                // eslint-disable-next-line no-console
                console.error('Lookup error', JSON.stringify(error));
                this.errors = [error];
            });
    }

    /**
     * Handles the lookup selection change
     * @param {event} event `selectionchange` event emmitted by the lookup.
     * The event contains the list of selected ids.
     */
    // eslint-disable-next-line no-unused-vars
    handleLookupSelectionChange(event) {
        this.checkForErrors();
    }

    handleClear() {
        this.initialSelection = [];
        this.errors = [];
    }

    checkForErrors() {
        this.errors = [];
        const selection = this.template.querySelector('c-lookup').getSelection();
        console.log(JSON.stringify(selection));
        // Custom validation rule
        if (this.isMultiEntry && selection.length > this.maxSelectionSize) {
            this.errors.push({ message: `You may only select up to ${this.maxSelectionSize} items.` });
        }
        // Enforcing required field
        else if (selection.length === 0) {
            this.errors.push({ message: 'Please make a selection.' });
        }
        else{
            this._contact_record_id = selection[0].id;
            console.log(this._contact_record_id);
        }
    }

    notifyUser(title, message, variant) {
        if (this.notifyViaAlerts) {
            // Notify via alert
            // eslint-disable-next-line no-alert
            alert(`${title}\n${message}`);
        } else {
            // Notify via toast (only works in LEX)
            const toastEvent = new ShowToastEvent({ title, message, variant });
            this.dispatchEvent(toastEvent);
        }
    }

    @api
    get account_record(){
        return this._account_record;
    }

    set account_record(set_account){
        this._account_record = set_account;
    }

    @api
    get quote_effective_date(){
        return this._quote_effective_date;
    }

    set quote_effective_date(quote_effective_date){
        this._quote_effective_date = quote_effective_date;
    }

    @api
    get contact_record_id(){
        return this._contact_record_id;
    }

    set contact_record_id(contact_record_id){
        this._contact_record_id = contact_record_id;
        console.log(this._quote_effective_date);
    }

    handleDateChange(event){
        console.log(event.target.value);
        this._quote_effective_date = event.target.value;
        //const attributeChangeEvent = new FlowAttributeChangeEvent('todos', this._todos);
          //      this.dispatchEvent(attributeChangeEvent);
    }
}