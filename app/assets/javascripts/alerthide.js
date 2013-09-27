$(document).ready(function() {
  $("div.alert span.alert-close").click(function(e) {
    $(this).closest('.alert').slideUp(500);
    e.preventDefault();
  });
});