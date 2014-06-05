jQuery ->
   $('#ads').dataTable(
            sPaginationType: "full_numbers"
            sJQueryUI: true
            bProcessing: true
            bServerSide: true
            sAjaxSource: $('#ads').data('source'))