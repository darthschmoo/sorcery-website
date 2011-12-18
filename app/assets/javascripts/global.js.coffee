
next_boot_item = ->
  $('#boot_sequence p.visible').removeClass('visible')
  candidates = $('#boot_sequence p')
  index = Math.floor( candidates.size() * Math.random() )
  $(candidates[index]).addClass('visible')

hide_boot_sequence = ->
	$('#boot_sequence').hide()

boot_sequence = ->
  setTimeout( next_boot_item, 300 )
  setTimeout( next_boot_item, 600 )
  setTimeout( next_boot_item, 900 )
  setTimeout( next_boot_item, 1200 )
  setTimeout( hide_boot_sequence, 1500 )
  true
  
decorate_form_focus = ->
  $('form.decorated input').blur -> 
    $(this).parent('div').removeClass('focused')
  
  $('form.decorated input').focus -> 
    $(this).parent('div').addClass('focused')

$(document).ready -> 
  decorate_form_focus()
  boot_sequence()





