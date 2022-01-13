/**
 * Created by varun on 1/4/2021.
 */

import { LightningElement, track, api } from 'lwc';
import getMarketingPlans from '@salesforce/apex/IHA_ShoppingCartController.getMarketingPlans';
import getAllShoppingDetails from '@salesforce/apex/IHA_ShoppingCartController.getAllShoppingDetails';
import { NavigationMixin } from 'lightning/navigation';

//TODO Merge the toggle class for footer
export default class GroupshoppingplanFc extends NavigationMixin(LightningElement) {
    @track marketingPlans = [];
    @track marketingPlanDisplayBenefits = [];

    @track plantypeoptions = [];
    @track plantypevalues = [];
    @track planfamilyoptions = [];
    @track planfamilyvalues = [];
    @track metalleveloptions = [];
    @track metallevelvalues = [];
    @track deductiblevel = 0;
    @track mindeductible = 0;
    @track maxdeductible = 100;
    @track planfamilysortoption = [];
    @track planfamilysortvalue = [];
    @track error;
    @track marketingplansloaded = false;
    @api selectedMarketingPlanIds = [];
    @api selectedMarketingPlans = [];
    @api selectedPlansForCompare = [];
    @track allMarketingPlanBenefits = [];
    @track isconfigurable = [];
    rowLimit =10;
    rowOffSet=0;
    compare_count = 0;
    activeSections = [];

    connectedCallback() {
       // document.body.setAttribute('style', 'overflow: hidden;'); //Used to hide the scrollbar on the body
        this.loadShoppingDetails();
        this.loadMarketingPlans();
    }

    loadShoppingDetails(){
        return getAllShoppingDetails()
        .then(result => {
            //console.log(JSON.stringify(result));
            for(var key in result.planTypeFilter){
                this.plantypeoptions.push({value:result.planTypeFilter[key], label:key});
                this.plantypevalues.push(key);
            }
            for(var key in result.metalLevelFilter){
                this.metalleveloptions.push({value:result.metalLevelFilter[key], label:key});
                this.metallevelvalues.push(key);
            }
            for(var key in result.planFamilyFilter){
                this.planfamilyoptions.push({value:result.planFamilyFilter[key], label:key});
                this.planfamilyvalues.push(key);
            }
            this.planfamilysortoption.push({value: 'PlanFamily', label: 'Plan Family'})
            this.planfamilysortvalue.push('PlanFamily');
            this.mindeductible = result.deductibleLowHigh['Low'];
            this.maxdeductible = result.deductibleLowHigh['High'];
            this.deductiblevel = result.deductibleLowHigh['Low'];
            this.marketingPlanDisplayBenefits = result.marketingPlanDisplayBenefits;
            this.allMarketingPlanBenefits = result.allMarketingPlanBenefits;
            this.isconfigurable = result.isConfigurable;
            this.marketingplansloaded = true;
        })
    }

    loadMarketingPlans(){
        return  getMarketingPlans({ limitSize: this.rowLimit , offset : this.rowOffSet })
        .then(result => {
            let updatedRecords = [...this.marketingPlans, ...result];
            this.marketingPlans = updatedRecords;
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.marketingPlans = undefined;
        });
    }

     handleScroll(event) {
        const currentRecord = this.marketingPlans;
        this.rowOffSet = this.rowOffSet + this.rowLimit;
        let area = this.template.querySelector('.scrollArea');
        let threshold = 2 * event.target.clientHeight;
        let areaHeight = area.clientHeight;
        let scrollTop = event.target.scrollTop;
        if(areaHeight - threshold < scrollTop) {
            let i = 0, t = this.marketingPlans.length;
            this.loadMarketingPlans();
        }
     }

     removeplanselection(event){
         this.selectedMarketingPlanIds = this.selectedMarketingPlanIds.filter(value => value !== event.detail);
         this.selectedMarketingPlans = this.selectedMarketingPlans.filter(value => value.Id !== event.detail);
         console.log(this.selectedMarketingPlans);
     }

     addplanselection(event){
         let selectedPlans = [...this.selectedMarketingPlanIds, event.detail]

         this.selectedMarketingPlanIds = selectedPlans;
         let nSelectedMarketingPlans = [];
         for(let planIdKey in this.selectedMarketingPlanIds){
             for(let marketingPlanKey in this.marketingPlans){
                 if (this.marketingPlans[marketingPlanKey].Id == this.selectedMarketingPlanIds[planIdKey]){
                     nSelectedMarketingPlans = [...nSelectedMarketingPlans, this.marketingPlans[marketingPlanKey]];
                 }
             }
         }
         this.selectedMarketingPlans = nSelectedMarketingPlans;
         console.log(this.selectedMarketingPlans);
     }

     removeplancompare(event){
        this.selectedPlansForCompare = this.selectedPlansForCompare.filter(value => value !== event.detail);
        if(this.selectedPlansForCompare.length > 1){
            const contentBlockClasslist = this.template.querySelector(
                 '.lgc-id_compare-toggle'
             ).classList;
             contentBlockClasslist.remove('slds-hidden');
        }else{
            const contentBlockClasslist = this.template.querySelector(
                 '.lgc-id_compare-toggle'
             ).classList;
             contentBlockClasslist.add('slds-hidden')
        }
     }

     addplancompare(event){
        let selectedPlans = [...this.selectedPlansForCompare, event.detail]
        this.selectedPlansForCompare = selectedPlans;
        if(this.selectedPlansForCompare.length > 1){
            const contentBlockClasslist = this.template.querySelector(
                 '.lgc-id_compare-toggle'
             ).classList;
             contentBlockClasslist.remove('slds-hidden');
        }else{
            const contentBlockClasslist = this.template.querySelector(
                 '.lgc-id_compare-toggle'
             ).classList;
             contentBlockClasslist.add('slds-hidden')
        }
     }

     handleClearCompare(){
        this.selectedPlansForCompare = [];
        const contentBlockClasslist = this.template.querySelector(
             '.lgc-id_compare-toggle'
         ).classList;
         contentBlockClasslist.add('slds-hidden')
     }

     handleCompare(){
         console.log(this.selectedPlansForCompare);

         this[NavigationMixin.GenerateUrl]({
             type: 'standard__component',
             attributes: {
                 componentName: 'c__plancomparisonwrappercmp'
             },state: {
                c__marketingplanids: this.selectedPlansForCompare
             }
         }).then(url => {
                window.open(url);})

     }

}