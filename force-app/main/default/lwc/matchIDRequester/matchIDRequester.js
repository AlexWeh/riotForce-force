/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
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
        makeRequest({ matchId: this.matchId, userID: this.userID })
            .then(result => {
                this.result = result;
                this.error = undefined;
                this.handleSuccess(this.result);
            })
            .catch(error => {
                this.error = error;
                this.result = undefined;
                this.handleError(this.error);
            });
    }

    handleSuccess(result){
        const evt = new ShowToastEvent({
            title: "Success",
            message: result,
            variant: "success",
        });
        this.dispatchEvent(evt);
    }

    handleError(error){
        const evt = new ShowToastEvent({
            title: "Error",
            message: error,
            variant: "error",
        });
        this.dispatchEvent(evt);
    }
}