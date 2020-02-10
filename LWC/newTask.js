/* eslint-disable guard-for-in */
/* eslint-disable no-console */
/* eslint-disable no-alert */
import {LightningElement, api, track, wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAllTask from '@salesforce/apex/TastsControllers.getAllTask';
import getUpdateTask from '@salesforce/apex/TastsControllers.getUpdateTask';
import saveStatus from '@salesforce/apex/TastsControllers.saveStatus';
import getStatus from '@salesforce/apex/TastsControllers.getStatus';
import { refreshApex } from '@salesforce/apex';
export default class TaskTest extends NavigationMixin(LightningElement) {
    @api optionsList = [{
            value: 'menuItemOne',
            label: "Today's Tasks",
            checked: 'true'
        },
        {
            value: 'menuItemTwo',
            label: "My Tasks",
            checked: 'false'
        },
        {
            value: 'menuItemThree',
            label: "All Overdue Tasks",
            checked: 'false'
        },
        {
            value: 'menuItemFour',
            label: "Completed Within Last 7 Days",
            checked: 'false'
        }
    ];
    @track models = false;
    @track dataId;
    @track maps;
    @track heading = "Today's Tasks";
    @track filter = this.heading;
    @track tasks;
    @track tdy=false;
    @track messge=false;
    @wire(getAllTask, { filter: '$filter' })
    returnResult(results) 
    {
        if (results) {
            this.tasks = results;
            //console.log('111111111111'+this.tasks);
            console.log('tasks----',JSON.stringify(this.tasks));
            if(results.data=== '' || results.data == null || results.data=== "undefined" || results.data===[]) {
                console.log('if is running');
            } else {
                if(results.data.length >0) {
                    this.messge=false;
                } else {
                    this.messge=true;
                    if(this.heading ==="Today's Tasks")
                    {
                        this.tdy=true;
                    }
                    else
                    {
                        this.tdy=false;
                    }
                }
            }
        }
    }
    handleButtonselect(event) 
    {
        let selectedValue = event.detail.value;
        this.optionsList.forEach(elements => 
            {
            if (elements.checked === 'true') 
            {
                elements.checked = 'false';
            }
            let selectedObject = this.optionsList.find(function(element) 
            {
                return element.value === selectedValue;
            });
            if (elements.value === selectedValue) 
            {
                if (selectedValue === 'menuItemFour') 
                {
                    this.heading = 'Completed Task';
                    this.filter = selectedObject.label;
                } 
                else 
                {
                    this.heading = selectedObject.label;
                    this.filter = selectedObject.label;
                }
                selectedObject.checked = 'true';
            }
            return refreshApex(this.tasks);
        });
    }
    changeStatus(event) {
        let checkedId = event.target.value;
        let checkedbox = event.target.checked;
        this.dataId = checkedId;
        if (checkedbox) 
        {
            getUpdateTask({
                    tskid: checkedId
                })
                .then(results => 
                    {
                    this.data = results;
                    this.template.querySelector(`[data-id="${checkedId}"]`).style.textDecoration = "line-through";
                })
        }
        else 
        {
            getStatus()
                .then(results => {
                    const options = [];
                    for (let key in results) 
                    {
                        if (key) 
                        {
                            options.push({
                                key: key,
                                value: results[key]
                            })
                            console.log('keys-->' + key);
                            console.log('Options-->' + options);
                        }
                    }
                    //console.log('Options-->'+results);
                    this.maps = options;
                    console.log('this.maps-->' + this.maps);
                    this.models = true;
                })
        }
    }
    updateStatus() 
    {
        let sId = this.dataId;
        console.log('sId-->' + sId);
        let st = this.ststs;
        saveStatus({
                tskId: sId,
                status: st
            })
            .then(results => {
                this.data = results;
                this.template.querySelector(`[data-id="${sId}"]`).style.textDecoration = "none";
                this.models = false;
            })
    }
    getRadioValue(event) 
    {
        this.ststs = event.target.value;
        this.dataId = event.target.dataset.id;
        console.log("this.dataId-->" + this.dataId);
    }
    doCancle() {
        this.models = false;
    }
    navigateToViewTask(event) {
        let taskIds=event.target.dataset.id;
        console.log('View Task Id --> '+taskIds);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: taskIds,
                objectApiName: 'Task',
                actionName: 'view'
            },
        });
    }
    navigateToViewLead(event)
    {
        let leadIds=event.target.dataset.id;
        console.log('View Lead Id --> '+leadIds);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: leadIds,
                objectApiName: 'Lead',
                actionName: 'view'
            },
        });
    }
}