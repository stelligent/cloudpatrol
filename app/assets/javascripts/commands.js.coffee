$(document).ready ->
  $(".commands-block td").find("span.undefined").each ->
    $(this).parents("tr").find("a.perform").hide()
