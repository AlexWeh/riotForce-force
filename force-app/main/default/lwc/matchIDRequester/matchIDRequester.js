/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';
import ID from '@salesforce/user/Id';
import makeRequest from '@salesforce/apex/RiotMatchIdRequester.makeRequest';

export default class MatchIDRequester extends LightningElement {
    userID = ID;
    @track result;
    @track matchId = '';

    handleMatchId(event){
        this.matchId = event.target.value;
    }

    handleKey(event){
        this.key = event.target.value;
    }

    handleRequest(){
        console.log('Fire!');
        console.log(this.userID);
        makeRequest({ matchId: this.matchId, userID: this.userID })
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