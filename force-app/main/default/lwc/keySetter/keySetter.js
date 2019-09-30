import { LightningElement } from 'lwc';
import ID from '@salesforce/user/Id';
import API_KEY from '@salesforce/schema/User.API_Key__c';

export default class KeySetter extends LightningElement {
    
    userId = ID;
    apiKey = API_KEY;
    user = "User";
}