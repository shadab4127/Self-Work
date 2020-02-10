/* eslint-disable no-alert */
import { LightningElement, track} from 'lwc';
//import getObjects from '@salesforce/apex/FieldExplorerController.getObjects';
import getFields from '@salesforce/apex/FieldExplorerController.getFields';

export default class FieldAccessExplorer extends LightningElement {
   // @track objects = [];
    @track fields = [];
   connectedCallback(){
       this.handleObjectChange();
   }
    handleObjectChange()
    {   
        //const selectedOption = event.detail.value;  
        getFields({
            objInfo: {'sobjectType' : 'AccountContactRole'},
            picklistFieldApi: 'Role'
           })
        .then(result => {
            this.dataArray = result;
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
        })
        .catch(error => {
            this.error = error;
        });

    }
    handleFieldChange(event){
        const selectedOption = event.detail.value;
        alert(selectedOption);
    }
}