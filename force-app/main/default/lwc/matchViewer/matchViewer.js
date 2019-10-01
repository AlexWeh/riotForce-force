import { LightningElement, track } from 'lwc';

const columns = [
    {
        type: 'text',
        fieldName: 'recordName',
        label: 'Name'
    },
    {
        type: 'date',
        fieldName: 'Creation_Time__c',
        label: 'Date Played'
    }
];

const nestedData = [
    {
        "name": "123555",
        "recordName": "Rewis Inc",
        "Creation_Time__c": "2019-09-04T11:46:24.000+0000"
    },
    {
        "name": "123556",
        "recordName": "Acme Corporation",
        "_children": [
            {
                "name": "123556-A",
                "recordName": "Acme Corporation (Bay Area)",
                "Creation_Time__c": "2019-09-04T14:27:33.000+0000",
                "_children": [
                    {
                        "name": "123556-A-A",
                        "recordName": "Acme Corporation (Oakland)"
                    },
                    {
                        "name": "123556-A-B",
                        "recordName": "Acme Corporation (San Francisco)"
                    }
                ]
            }
        ]
    },
];

export default class MatchViewer extends LightningElement {
    @track columns = columns;
    @track data = nestedData;

}