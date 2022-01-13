/**
 * Created by varun on 9/6/2019.
 */

import { LightningElement, track, api  } from 'lwc';

export default class TreeGridBasic extends LightningElement {
    @api title;
    @api icon;
    @api gridColumns;
    @api gridExpandedRows = [];
    @api gridData = [];

}