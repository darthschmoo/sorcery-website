
next_boot_item = ->
  $('#boot_sequence p.visible').removeClass('visible')
  candidates = $('#boot_sequence p')
  index = Math.floor( candidates.size() * Math.random() )
  $(candidates[index]).addClass('visible')

hide_boot_sequence = ->
	$('#boot_sequence').hide()

$(document).ready ->
  # $('h1').mouseover -> $(this).html( $(this).html() + "?" )
  #   $('h1').click -> $(this).html( $(this).html() + "!" )
	setTimeout( next_boot_item, 300 )
	setTimeout( next_boot_item, 600 )
	setTimeout( next_boot_item, 900 )
	setTimeout( next_boot_item, 1200 )
	setTimeout( hide_boot_sequence, 1500 )
