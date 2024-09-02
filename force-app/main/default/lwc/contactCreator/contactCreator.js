import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// Import fields from the Contact object
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';

export default class ContactCreator extends LightningElement {
    // Define the fields to be used in the lightning-record-form
    fields = [FIRST_NAME_FIELD, LAST_NAME_FIELD, EMAIL_FIELD];

    handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: 'Contact Created',
            message: 'Contact ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(toastEvent);
    }
}
