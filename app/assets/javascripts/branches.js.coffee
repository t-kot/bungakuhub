$ ->
  $("#tab_menu a").click (e)->
    e.preventDefault()
    $(this).tab 'show'
