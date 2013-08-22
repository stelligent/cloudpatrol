synchronize = (trigger) ->
  form = trigger.parents("tr")
  id = form.find("input#setting_id").val()
  masked = form.find("input#setting_masked").val()

  $("img#loader").css {"display": "inline"}
  if masked == "true" and trigger.attr("id") != "setting_value"
    form.find("input#setting_value").attr("type", "hidden")
  $.ajax
    type: "PUT"
    url: "settings/"+id
    data: form.find("input[type!=hidden], select").serialize()
  if masked == "true"
    form.find("input#setting_value").attr("type", "password")

push = (trigger) ->
  form = trigger.parents("tr")
  $("img#loader").css {"display": "inline"}
  $.ajax
    type: "POST"
    url: "settings"
    data: form.find("input").serialize()

$(document).ready ->
  $(document).on "change", "select[id^=setting_protected]", ->
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
    synchronize $(this)

  $("input[id^=setting_]").on "change", ->
    synchronize $(this)

  $("a#new").on "click", ->
    parent_row = $(this).parents("tr");
    parent_table = $(this).parents("table");
    if parent_table.find("tr#new_setting").size() == 0
      parent_row.before '<tr class="control-group" id="new_setting"><td><input class="input-large" id="setting_key" name="setting[key]" type="text" value=""></td><td><input class="input-medium" id="setting_value" name="setting[value]" type="text" value=""></td><td colspan=3><input class="btn btn-primary" type="submit"></td></tr>'
      parent_row.hide()

  $(document).on "click", "tr#new_setting input[type=submit]", ->
    push $(this)
