/* eslint-disable no-console */
/* eslint-disable no-eval */
/* eslint-disable no-alert */
import { LightningElement,api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getSaveRole from '@salesforce/apex/contactRole.getSaveRole';
import fatchPickListValue from '@salesforce/apex/contactRole.fatchPickListValue';
export default class NewContactRoles extends LightningElement {
    @api shows=false;
    @track selectConId;
    @api recordids;
    @track roles;
    @track title = 'Create New Role';
    @track pickValue;
    @track isPrimary=false;
    connectedCallback(){
        this.getPicklist();
    }
    getPicklist(){
        fatchPickListValue({
            objInfo: {'sobjectType' : 'AccountContactRole'},
            picklistFieldApi: 'Role'
           })
            .then(results => {
            this.roles = results;
        })   
    }
    selectedContact(event){
        this.selectConId = event.detail;
    }
    onValueSelection(event){
        this.pickValue=event.target.value;
        }
    onCheck(event){
        this.isPrimary = event.target.checked;
    }  

   /*-------------------DML operations---------------------*/
    doSave(){
        getSaveRole({recordId:this.recordids, isPrimary:this.isPrimary,conId:this.selectConId,role:this.pickValue})
            .then(results => {
                if(results){
                    this.callToast();
                    this.dispatchEvent(new CustomEvent('refreshview'));
                }
            })   
        this.clear();
        this.doClose();
    }
    clear(){
        this.selectConId='';
        this.pickValue='';
        this.isPrimary=false;
    }
    callToast(){
        const event = new ShowToastEvent({
            title: 'Role Created',
            variant:'success',
        });
        this.dispatchEvent(event);
    }
    doClose(){
        this.shows=false;
        this.dispatchEvent(new CustomEvent('newmodelfasle'));
    }
}