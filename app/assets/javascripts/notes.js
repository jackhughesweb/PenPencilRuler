$(document).ready(function() {
  $("article.note a.show").click(function(e) {
    $(this).parent().find("div.text").slideDown();
    $(this).parent().find("a.show").hide();
    $(this).parent().find("a.hide").show();
    e.preventDefault();
  });
  $("article.note a.hide").click(function(e) {
    $(this).parent().find("div.text").slideUp();
    $(this).parent().find("a.hide").hide();
    $(this).parent().find("a.show").show();
    e.preventDefault();
  });
  $("a.showall").click(function(e) {
    $("article.note div.text").slideDown();
    $("article.note a.show").hide();
    $("article.note a.hide").show();
    e.preventDefault();
  });
  $("a.hideall").click(function(e) {
    $("article.note div.text").slideUp();
    $("article.note a.hide").hide();
    $("article.note a.show").show();
    e.preventDefault();
  });
});
