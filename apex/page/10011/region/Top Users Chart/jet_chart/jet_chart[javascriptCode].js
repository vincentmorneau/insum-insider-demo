function( options ){ 

    this.pieSliceLabel = function(dataContext) {
        var series_name,
            percent = Math.round(dataContext.value/dataContext.totalValue*100);
        
        if ( dataContext.seriesData ) {
            series_name = dataContext.seriesData.name;
        } else {
            series_name = 'Other';
        }
        return series_name + " " + percent + "% ( " + dataContext.value + " )";
    }
    
    // Set chart initialization options 
    options.dataLabel = pieSliceLabel; 
    return options; 
}