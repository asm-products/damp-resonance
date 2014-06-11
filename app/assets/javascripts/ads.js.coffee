jQuery ->
  $('#ads').dataTable(
    aaSorting: []
    sPaginationType: "full_numbers"
    sJQueryUI: true
    bProcessing: true
    bServerSide: true
    sAjaxSource: $('#ads').data('source')
    aoColumns: [
     null, 
     null, 
     null, 
     null, 
     null, 
     null, 
     null,
     null, 
     null ])