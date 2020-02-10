public with sharing class taskApex {
    public taskApex() {

    }
     /* eslint-disable @lwc/lwc/no-document-query */
/* eslint-disable no-console */
/* eslint-disable no-alert */
import { LightningElement, api, track,wire } from 'lwc';
import getAllTask from '@salesforce/apex/TastsControllers.getAllTask';
export default class TaskTest extends LightningElement {
@api optionsList = [
    {value : 'menuItemOne' , label :"Today's Tasks",checked:'true'} , 
    {value : 'menuItemTwo' , label :"My Tasks",checked:'false'} , 
    {value : 'menuItemThree' , label :"All Overdue Tasks",checked:'false'} , 
    {value : 'menuItemFour' , label :"Completed Within Last 7 Days",checked:'false'}];
@track heading ="Today's Tasks";
@track filter=this.heading;

@wire(getAllTask, { filter: '$filter' })
tasks;

handleButtonselect (event){
    let selectedValue = event.detail.value;
        // eslint-disable-next-line no-console
        console.log('--->'+selectedValue);
    this.optionsList.forEach(elements => {
        if(elements.checked ==='true'){
            elements.checked='false';
        }
        let selectedObject  = this.optionsList.find(function(element){
            return element.value === selectedValue;
});
        if(elements.value ===selectedValue){
            if(selectedValue ==='menuItemFour'){
                this.heading='Completed Task';
                this.filter=selectedObject.label;                  
            }
            else{
                this.heading=selectedObject.label;
                this.filter=selectedObject.label;
                // eslint-disable-next-line no-console
                console.log(this.filter);
            }
            selectedObject.checked='true';
        }
});
}
}
}
