/* eslint-disable no-console */
/* eslint-disable no-eval */
/* eslint-disable no-alert */
import { LightningElement,api, track,wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import updateRecord from '@salesforce/apex/contactRole.updateRecord';
import fatchPickListValue from '@salesforce/apex/contactRole.fatchPickListValue';
import getAccounts from '@salesforce/apex/contactRole.getAccounts';
export default class EditContactRoles extends LightningElement {
    @api shows=false;
    @api recordids;
    @track fields = [];
    @api isprimary=false;
    @api contactname;
    @api contactids;
    @api contactrole;
    @api accountsid;
    @track title;
    @wire(getAccounts,{accId :'$accountsid'})
    wiredAccounts({ data }) {
      if (data) {
            this.title = data;
        } 
    }
    @wire(fatchPickListValue,{objInfo: {'sobjectType' : 'AccountContactRole'},
    picklistFieldApi: 'Role'})
    wiredRoles({ data }) {
      if (data) {
        this.dataArray = data;
        let tempArray = [];
        this.dataArray.forEach(function (element) {
            var option=
            {
                label:element.slabel,
                value:element.svalue
            };
            tempArray.push(option);
        });
        this.fields=tempArray;
        } 
    }
    selectedContact(event){
        this.contactids = event.detail;
    }
    onValueSelection(event){
        this.contactrole=event.target.value;
        }
    onCheck(event){
        this.isprimary = event.target.checked;
    }  
    updateRecord(){
        updateRecord({recordId: this.recordids, isPrimary: this.isprimary, conId: this.contactids, role: this.contactrole})
            .then(results => {
                if(results){
                   if(results){
                    this.callToast();
                   }
                    this.dispatchEvent(new CustomEvent('refreshview'));
                }
            })   
        this.doClose();
    }
    callToast(){
        const event = new ShowToastEvent({
            title: 'Role Updated',
            variant:'success',
        });
        this.dispatchEvent(event);
    }
    doClose(){
        this.shows=false;
        this.dispatchEvent(new CustomEvent('newmodelfasle'));
    }
}
