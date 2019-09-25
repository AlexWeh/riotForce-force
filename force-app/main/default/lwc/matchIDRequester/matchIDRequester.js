import { LightningElement } from 'lwc';
import makeRequest from '@salesforce/apex/RiotMatchIdRequester.makeRequest';

export default class MatchIDRequester extends LightningElement {
    handleRequest(event){
        makeRequest(event);
    }
}