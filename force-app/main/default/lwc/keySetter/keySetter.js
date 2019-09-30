import { LightningElement } from 'lwc';
import ID from '@salesforce/user/Id';
import API_KEY from '@salesforce/schema/User.API_Key__c';
import TIME_GENERATED from '@salesforce/schema/User.Time_Key_Generated__c';

export default class KeySetter extends LightningElement {
    
    userId = ID;
    apiKey = API_KEY;
    timeGenerated = TIME_GENERATED;
    //timeExpire = TIME_GENERATED + 86400000;
    user = "User";
}