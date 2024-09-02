import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import FIRST_NAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LAST_NAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import { reduceErrors } from 'c/ldsutils';

const COLUMNS = [
    { label: 'First Name', fieldName: FIRST_NAME_FIELD.fieldApiName },
    { label: 'Last Name', fieldName: LAST_NAME_FIELD.fieldApiName },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName }
];

export default class ContactList extends LightningElement {
    contacts;
    rawErrors; // Stores raw error data
    columns = COLUMNS;

    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.rawErrors = undefined;
        } else if (error) {
            this.contacts = undefined;
            this.rawErrors = error;
        }
    }

    // Getter that processes errors using reduceErrors
    get errors() {
        return this.rawErrors ? reduceErrors(this.rawErrors) : [];
    }
}
