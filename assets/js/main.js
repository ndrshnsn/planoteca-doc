---
include_in_search: false
layout: null
---
$(document).ready(function() {
    $(document).on('keypress', '.td-search-input', function(e) {
       if (e.keyCode !== 13) {
         return
     }
     var query = $(this).val();
     var searchPage = "{{ site.url }}/pesquisa/?q=" + query;
     document.location = searchPage;
     return false;
   });
});

