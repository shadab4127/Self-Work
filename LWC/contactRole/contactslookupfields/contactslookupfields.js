/* eslint-disable no-alert */
/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement,track,wire, api } from 'lwc';
import getContact from '@salesforce/apex/contactRole.getContact';
const DELAY = 100;
export default class Contactslookupfields extends LightningElement {
    @track search = '';
    @track pills=false;
    @track inputbox=true;
    @track contacts;
    @track message;
    @api contactIds;
    @track contactName;
    @wire(getContact, { searchText: '$search' })
    wiredContact({ data }) {
        if (data) {
            this.contacts = data;
        } else {
            this.message ='No record found';
        }
    }
    onfocus(){
        this.search = '';
        this.template.querySelector('.slds-dropdown').classList.remove('slds-hide');
        this.template.querySelector('.slds-dropdown').classList.add('slds-show');
    }
    onblure(){
        this.template.querySelector('.slds-dropdown').classList.remove('slds-hide');
        this.template.querySelector('.slds-dropdown').classList.add('slds-hide');
    }
    handleKeyUp(event) {
        const searchKey = event.target.value;
    if (searchKey !== '') {
        this.template.querySelector('.slds-dropdown').classList.remove('slds-hide');
        this.template.querySelector('.slds-dropdown').classList.add('slds-show');
    }
    else{
        this.template.querySelector('.slds-dropdown').classList.remove('slds-hide');
        this.template.querySelector('.slds-dropdown').classList.add('slds-hide');
    }
        window.clearTimeout(this.delayTimeout);
        this.delayTimeout = setTimeout(() => {
            this.search = searchKey;
        }, DELAY);
    }
    selectContact(event){
        let name = event.currentTarget.dataset.name;
        if(name){
        this.contactName=name;
        this.contactIds=event.currentTarget.dataset.id;
        const selectedId = new CustomEvent("selectedcontactid", {
            detail: this.contactIds
          });
          // Dispatches the event.
        this.dispatchEvent(selectedId);
        this.template.querySelector('.slds-pill').classList.remove('slds-hide');
        this.template.querySelector('.contactIcons').classList.add('slds-hide');
        this.template.querySelector('.slds-combobox').classList.add('slds-hide');
       }
        this.contactIds = event.currentTarget.dataset.id;
        this.template.querySelector('.slds-dropdown').classList.remove('slds-hide');
        this.template.querySelector('.slds-dropdown').classList.add('slds-hide');
        this.template.querySelector('.slds-combobox__form-element').classList.add('slds-input-has-border_padding');
    }
    removePills(){
        this.template.querySelector('.slds-pill').classList.add('slds-hide');
        this.template.querySelector('.contactIcons').classList.remove('slds-hide');
        this.template.querySelector('.slds-combobox').classList.remove('slds-hide');
    }
}
