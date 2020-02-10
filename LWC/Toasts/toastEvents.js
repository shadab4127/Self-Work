import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ToastEvents extends LightningElement {
    @track show=false;
    showToast() {
        const event = new ShowToastEvent({
            title: 'Get Help',
            variant:'success',
            message: 'Salesforce documentation is available in the app. Click ? in the upper-right corner.',
        });
        this.dispatchEvent(event);
        this.show=true;
    }
    doclose(){
        this.show=false;
    }
}