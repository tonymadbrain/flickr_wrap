$(function (){
  $('#delete_link').on('click', function(e){
   var check_item = $('input:checked','#delete_form'),
   _arr = [];
    e.preventDefault();
    check_item.each(function(item, index){
      _arr.push($(index).prop('value'));
    });
    $.ajax({
      type: "POST",
      url: "/delete",
      data: {"checkbox":_arr},
      dataType: "html",
      success: function(data) {
        location.reload();
      },
      error: function(xhr, status, error) {
        var err = JSON.parse(xhr.responseText)
        $('#alerts').html("<div class='alert alert-error'>"+xhr.status+" "+error+": "+err.message+"</div>")
      }
    });
  })
  $('#sync_link').on('click', function(e){
    e.preventDefault();
    $.ajax({
      type: "POST",
      url: "/sync",
      success: function() {
        location.reload();
      },
      error: function(xhr, status, error) {
        var err = JSON.parse(xhr.responseText)
        $('#alerts').html("<div class='alert alert-error'>"+xhr.status+" "+error+": "+err.message+"</div>")
      }
    });
  })
});
