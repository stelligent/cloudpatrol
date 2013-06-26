synchronize = (trigger) ->
  form = trigger.parents("tr")
  id = form.find("input#setting_id").val()
  $("img#loader").css({"display": "inline"})
  $.ajax
    type: "PUT"
    url: "settings/"+id
    data: form.find("input[type!=hidden], select").serialize()

$(document).ready ->
  $("select[id^=setting_protected]").on "change", ->
    form = $(this).parents("tr")
    key = form.find("input#setting_key")
    value = form.find("input#setting_value")
    remove = form.find("a#setting_delete")
    lock = form.find("i#setting_lock")
    if $(this).val() is "none"
      key.prop "disabled", false
      value.prop "disabled", false
      remove.css { display: "inline-block" }
      lock.css { display: "none" }
    else if $(this).val() is "key"
      key.prop "disabled", true
      value.prop "disabled", false
      remove.css { display: "none" }
      lock.css { display: "inline-block" }
    else if $(this).val() is "both"
      key.prop "disabled", true
      value.prop "disabled", true
      remove.css { display: "none" }
      lock.css { display: "inline-block" }
    synchronize($(this))

  $("input[id^=setting_]").on "change", ->
    synchronize($(this))
