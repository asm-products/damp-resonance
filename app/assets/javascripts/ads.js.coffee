jQuery ->
   $('#ads_list').dataTable().columnFilter({
         aoColumns: [ null,
                      { type: "select" },
                      { type: "text" },
                      null,  
                      { type: "text" },  
                      null, 
                      { type: "select" },
                      { type: "select" },
                      { type: "select" },
                      null,
                      null
                      ] });
    