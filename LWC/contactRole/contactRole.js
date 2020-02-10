/* eslint-disable no-alert */
    /* eslint-disable no-console */
    import { LightningElement, wire, track, api } from 'lwc';
    import { ShowToastEvent } from 'lightning/platformShowToastEvent';
    import { NavigationMixin } from 'lightning/navigation';
    import getAccountRoles from '@salesforce/apex/contactRole.getAccountRoles';
    import deleteRecord from '@salesforce/apex/contactRole.deleteRecord';
    import recordToEdit from '@salesforce/apex/contactRole.recordToEdit';
    import { refreshApex } from '@salesforce/apex';
    export default class ContactRole extends NavigationMixin (LightningElement) {
    @track record;
    @track newshow=false;
    @track editshow=false;
    @track contactName;
    @track accountIds;
    @track contactId;
    @track contactRole;
    @track isPrimary;
    @api recordId;
    @api rolesId;
    @wire(getAccountRoles,{accId:'$recordId'}) record;
    deleteRecord(event)
    {
      let roleId=event.currentTarget.id;
    if (confirm("Are you sure...?")) {
      deleteRecord({
      roleId: roleId,
     })
      .then(results => {
     if(results){
      this.showToast();
     }
     return refreshApex(this.record);
      })       
    }
  }
    getContact(event){
      let contactId = event.target.dataset.id;
      this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId: contactId,
            objectApiName: 'Contact', // objectApiName is optional
            actionName: 'view'
        }
    });
    }
    getAccount(event){
      let accountId = event.target.dataset.id;
      this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
          recordId: accountId,
          objectApiName: 'Account', // objectApiName is optional
          actionName: 'view'
        }
      });
    }
    showToast() {
      const event = new ShowToastEvent({
          title:  'Role Deleted',
          variant:'error',
      });
      this.dispatchEvent(event);
  }
createNewRecord(){
    this.newshow=true; 
  }
  newClose(){
    this.newshow=false;
  }
  refreshRecord(){
    return refreshApex(this.record);
  }
  editRecord(event){
    let ContId=event.currentTarget.id;
    recordToEdit({roleId : ContId})
        .then(results=>{
          this.rolesId=results.getAccConRole.Id;
          this.accountIds=results.getAccConRole.Account.Id;
          this.contactId=results.getAccConRole.Contact.Id;
          this.contactName=results.getAccConRole.Contact.Name;
          this.contactRole=results.svalue;
          this.isPrimary=results.getAccConRole.IsPrimary;
      })
    this.editshow=true; 
  }
  editClose(){
    this.editshow=false;
  }
}
