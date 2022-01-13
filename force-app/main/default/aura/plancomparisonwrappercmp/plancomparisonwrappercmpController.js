/**
 * Created by varun on 1/6/2021.
 */

({
    onPageReferenceChange: function(cmp, evt, helper) {
        var myPageRef = cmp.get("v.pageReference");
        if(myPageRef != null){
            var marketingplanids = myPageRef.state.c__marketingplanids;
            console.log(marketingplanids);
            let marketingplanidList = marketingplanids.split(",");
            console.log(marketingplanidList);
            cmp.set("v.marketingplanids", marketingplanidList);
            console.log(cmp.get("v.marketingplanids"));
        }
    },
});