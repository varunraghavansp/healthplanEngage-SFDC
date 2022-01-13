/**
 * Created by varun on 6/14/2020.
 */

import { LightningElement, api , track} from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import MDB from '@salesforce/resourceUrl/mdb';


export default class Bootstrapstepper extends LightningElement {
    @api currentstage;
    @api stages = [];
    @api currentstagetext;
    @track stagestates = [];
    renderedCallback() { // invoke the method when component rendered or loaded
            Promise.all([
                loadStyle(this, MDB + '/mdb/css/bootstrap.min.css'),
                loadStyle(this, MDB + '/mdb/css/mdb.min.css'),
                loadStyle(this, MDB + '/mdb/css/style.css'),
                loadScript(this, MDB + '/mdb/js/jquery.min.js'),
                loadScript(this, MDB + '/mdb/js/popper.min.js'),
                loadScript(this, MDB + '/mdb/js/bootstrap.min.js'),
                loadScript(this, MDB + '/mdb/js/mdb.min.js'),
            ])
            .then(() => {
                console.log('Scripts Loaded');
                this.initalizeStepper();
            })
            .catch(error => {
                this.error = error;
                console.log('Error ' + error + this.error);
            });

        }
        connectedCallback(){
            var state = 'completed'
            for(var idx in this.stages){
                if(this.stages[idx] === this.currentstage){
                    state = 'active'
                    this.stagestates.push({'idx' : Number(idx) + 1, 'state': state, 'label': this.stages[idx], 'currenstagetext': this.currentstagetext});
                    state = '';
                }else{
                    this.stagestates.push({'idx' : Number(idx) + 1, 'state': state, 'label': this.stages[idx]});
                }
            }
            console.log(this.currentstage);
            console.log(JSON.stringify(this.stagestates));
        }
        initalizeStepper(){
              console.log('Initalized');
        }
        showSuccessMessage() { // call back method
           this.successMessage = 'Scripts are loaded successfully!!';
           alert('Scripts are loaded successfully!!!');
        }
}