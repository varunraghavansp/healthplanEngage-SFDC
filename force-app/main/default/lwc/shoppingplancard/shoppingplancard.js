/**
 * Created by varun on 1/4/2021.
 */

import { LightningElement, track, api } from 'lwc';

export default class Shoppingplancard extends LightningElement {
    @api marketingplanrecord;
    @api marketingplandisplaybenefits;
    @api allmarketingplanbenefits;
    @api allisconfigurable;
    currentplanbenefits  = [];
    currentplankeybenefits = [];
    compareplan = false;
    cartIconName = 'utility:cart';
    cartButtonLabel = 'Add To Cart';
    cartButtonVariant = 'brand';
    showMoreIconName = 'utility:edit';
    showMoreButtonLabel = 'Configure';
    showMoreButtonVariant = 'brand';
    @track isModalOpen = false;
    @track isComponentSelected = false;
    @track selectedComponentId = '';
    isConfigureDisabled  = false;
    @track isViewMoreOpened = false;
    @track marketingPlanIds = [];
    openModal() {
            // to open modal set isModalOpen tarck value as true
            this.isModalOpen = true;
        }
        closeModal() {
            // to close modal set isModalOpen tarck value as false
            this.isModalOpen = false;
        }
        submitDetails() {
            // to close modal set isModalOpen tarck value as false
            //Add your code to call apex method or do some processing
            this.isModalOpen = false;
            this.handleAddToCart();
        }

        openViewMore() {
            // to open modal set isModalOpen tarck value as true
            this.isViewMoreOpened = true;
        }
        closeViewMore() {
            // to close modal set isModalOpen tarck value as false
            this.isViewMoreOpened = false;
        }

    connectedCallback(){
        let marketingplanids = [];
        marketingplanids.push(this.marketingplanrecord.Id);
        this.marketingPlanIds = marketingplanids;

         for(let key in this.marketingplandisplaybenefits){
            if(this.marketingplanrecord.Id == key){
                let keyplanbenefits = this.marketingplandisplaybenefits[key];
                for(let benefit in keyplanbenefits) {
                        this.currentplankeybenefits.push({key: benefit, value: keyplanbenefits[benefit]});
                }
            }
        }
        for(let key in this.allmarketingplanbenefits){
                    if(this.marketingplanrecord.Id == key){
                        this.currentplanbenefits = this.allmarketingplanbenefits[key];
                    }
            }
        let isConfigurable = this.allisconfigurable[this.marketingplanrecord.Id];
        this.isConfigureDisabled = !isConfigurable;
    }

    componentSelectionChanged(event){
        this.isComponentSelected = false;
        console.log(JSON.stringify(event.detail));
        let selectedcomponentid = event.detail.selectedcomponentid;
        if(selectedcomponentid == null || selectedcomponentid === ''){
            this.isComponentSelected = false;
        }else{
            this.selectedComponentId = selectedcomponentid;
            this.isComponentSelected = true;
        }
    }

    attributeValueChanged(event){
         console.log(JSON.stringify(event.detail));
    }

     handleAddToCart() {
         let eventName = '';
         if (this.cartIconName === 'utility:cart') {
             this.cartIconName = 'utility:close';
             this.cartButtonLabel = 'Remove From Cart';
             this.cartButtonVariant = 'destructive';
             eventName = 'planadded';
         } else {
             this.cartIconName = 'utility:cart';
             this.cartButtonLabel = 'Add To Cart';
             this.cartButtonVariant = 'brand';
             eventName = 'planremoved';
         }
         const selectionChangeEvent = new CustomEvent(eventName, { detail: this.marketingplanrecord.Id });
         this.dispatchEvent(selectionChangeEvent);
     }

     handleCompareChange(event){
         let eventName = '';
         this.compareplan = event.target.checked;
         if( this.compareplan ){
           eventName = 'addcompare';
         }else{
             eventName = 'removecompare';
         }
        const selectionChangeEvent = new CustomEvent(eventName, { detail: this.marketingplanrecord.Id });
        this.dispatchEvent(selectionChangeEvent);
     }

     handleShowMore() {
         const contentBlockClasslist = this.template.querySelector(
                     '.lgc-id_content-toggle'
                 ).classList;
                 // toggle the hidden class
                 contentBlockClasslist.toggle('slds-hide');
          if (this.showMoreIconName === 'utility:down') {
              this.showMoreIconName = 'utility:up';
              this.showMoreButtonLabel = 'Show Less';
              this.showMoreButtonVariant = 'base';
          } else {
              this.showMoreIconName = 'utility:down';
              this.showMoreButtonLabel = 'Show More';
              this.showMoreButtonVariant = 'base';
          }
      }
}