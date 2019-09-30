/* eslint-disable no-console */

import { LightningElement, track } from 'lwc';
import makeRequest from '@salesforce/apex/RiotMatchIdRequester.makeRequest';
export default class MatchIDRequester extends LightningElement {
    @track result;
    @track matchId = '';
    key = 'RGAPI-e12a538a-51e7-446f-9569-c523b4034f3e';
    

    handleMatchId(event){
        this.matchId = event.target.value;
    }

    handleKey(event){
        this.key = event.target.value;
    }

    handleRequest(){
        console.log('Fire!');
        console.log(this.matchId);
        makeRequest({ matchId: this.matchId, key: this.key })
            .then(result => {
                this.result = result;
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.result = undefined;
            });
        console.log(this.result);
        console.log(this.error);
    }
}