/**
 * Created by varun on 9/4/2019.
 */

({
    sortData: function(component, fieldName, sortDirection) {
            var data = component.get("v.data");
            var reverse = sortDirection !== 'asc';
            data = Object.assign([],
                data.sort(this.sortBy(fieldName, reverse ? -1 : 1)));
            component.set("v.data", data);
    },

    sortBy: function(field, reverse, primer) {
        var key = primer ? function(x) {
            return primer(x[field]);
        } : function(x) {
            return x[field];
        };
        return function(a, b) {
            var A = key(a);
            var B = key(b);
            return reverse * ((A > B) - (B > A));
        };
    },

    downloadCSVFile : function(component, event, helper) {
        var gridColumns = component.get("v.columns");
        var gridRows = component.get("v.data");
        var downloadFileName = component.get("v.downloadfilename");
        // 6. CSV download.
        var csvHeaders = [];
        gridColumns.forEach(function(gridColumn){
            if(!$A.util.isUndefinedOrNull(gridColumn.label)){
               csvHeaders.push(gridColumn.label)
            }
        });
        var columnOrderMap = {};
        var idx = 0;
        var emptyRow = [];
        while (idx < gridColumns.length){
           if(!$A.util.isUndefinedOrNull(gridColumns[idx].fieldName)){
               columnOrderMap[gridColumns[idx].fieldName] =  idx;
               emptyRow.push('');
           }
           idx++;
        }

        var csv = csvHeaders.join(',');
        csv += "\n";

        gridRows.forEach(function(gridRow){
          var row = emptyRow;
          for(var key in columnOrderMap){
              if(!$A.util.isUndefinedOrNull(gridRow[key])){
                row.splice(columnOrderMap[key] , 1 , gridRow[key].includes(',') === true ? '"' + gridRow[key] + '"' : gridRow[key] );
              }
          }
           csv += row.join(",");
           csv += "\n";
        });

        // 6. To download table in CSV format.
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_blank';
        hiddenElement.download = downloadFileName +'.csv';
        hiddenElement.click();
    },

    readCSVFile: function(component, event, helper) {
        var helper = this;
        var columns = component.get("v.columns");
        var file = event.getSource().get("v.files")[0];
        var columnPlacement = {};
        var columnHeader = {};
        var rows = [];
        if (file) {
            var reader = new FileReader();
            reader.readAsText(file, "UTF-8");
            reader.onload = function(evt) {
                var textdata = evt.target.result;
                var valueArray = helper.CSVToArray(textdata, ",");
                var headerRow = true;
                valueArray.forEach(function(valueRow){
                    if(headerRow){
                        for(var idx  = 0; idx <  valueRow.length; idx++){
                            for(let column of columns){
                                if(column.label === valueRow[idx]){
                                    columnPlacement[idx] = column.colIdx;
                                    columnHeader[idx] = column.fieldName;
                                    break;
                                }
                            }
                        }
                        headerRow = false;
                    }else{
                        var row = {};
                        for(var idx  = 0; idx <  valueRow.length; idx++){
                            row[columnHeader[idx]] = valueRow[columnPlacement[idx]];
                        }
                        row["id"] = idx;
                        rows.push(row);
                    }
                    });
                    component.set("v.data", rows);
                    var dataupdatedEvt = component.getEvent("dataupdated");
                    dataupdatedEvt.setParam('data',{action: 'new' ,selectedrow:{}, rows: component.get("v.data")});
                    dataupdatedEvt.fire();
                }
                reader.onerror = function(evt) {
                    console.log("error reading file");
                }
            }
        },

        CSVToArray: function(strData, strDelimiter) {
            // Check to see if the delimiter is defined. If not, then default to comma.
            strDelimiter = (strDelimiter || ",");
            // Create a regular expression to parse the CSV values.
            var objPattern = new RegExp(
                (
                    // Delimiters.
                    "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +
                    // Quoted fields.
                    "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +
                    // Standard fields.
                    "([^\"\\" + strDelimiter + "\\r\\n]*))"
                ), "gi");
            // Create an array to hold our data. Give the array
            // a default empty first row.
            var arrData = [
                []
            ];
            // Create an array to hold our individual pattern
            // matching groups.
            var arrMatches = null;
            // Keep looping over the regular expression matches
            // until we can no longer find a match.
            while (arrMatches = objPattern.exec(strData)) {
                // Get the delimiter that was found.
                var strMatchedDelimiter = arrMatches[1];
                // Check to see if the given delimiter has a length
                // (is not the start of string) and if it matches
                // field delimiter. If id does not, then we know
                // that this delimiter is a row delimiter.
                if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter) {
                    // Since we have reached a new row of data,
                    // add an empty row to our data array.
                    arrData.push([]);
                }
                var strMatchedValue;
                // Now that we have our delimiter out of the way,
                // let's check to see which kind of value we
                // captured (quoted or unquoted).
                if (arrMatches[2]) {
                    // We found a quoted value. When we capture
                    // this value, unescape any double quotes.
                    strMatchedValue = arrMatches[2].replace(new RegExp("\"\"", "g"), "\"");
                } else {
                    // We found a non-quoted value.
                    strMatchedValue = arrMatches[3];
                }
                // Now that we have our value string, let's add
                // it to the data array.
                arrData[arrData.length - 1].push(strMatchedValue);
            }
            // Return the parsed data.
            return arrData;
        },
});