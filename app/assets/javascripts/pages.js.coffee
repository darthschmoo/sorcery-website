# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

normalize_to_range = (val, min, max) =>
  if val > max
    return max
  
  if val < min
    return min
    
  return val

# opacity_shift = (e) ->
#   e = $(e)
#   old_opacity = e.css('fill-opacity')
#   new_opacity = normalize_to_range( new Number(old_opacity) + (Math.random() * 0.2 - 0.1 ), 0, 1 )
#   e.css( 'fill-opacity', new_opacity )
# 
# run_opacity_shift = ->
#   path = $('path')[Math.floor( Math.random() * $('path').length )]
#   opacity_shift( path )
#   window.setTimeout( run_opacity_shift, 50 )

# run_opacity_shift()

get_transform_coordinates = (e) ->
  coords = e.attr('transform').match( /rotate\(([\s\d.,]+)\)/ )
  if coords && coords[1]
    coords[1].split(",").map (input) ->
      new Number( input )
  else
    debugger
    null
    
get_scale = (e) ->
  e = $(e)
  min = 0.3
  max = 1.2
  
  current_scale = new Number( e.attr('transform').match( /scale\(([0-9.]+)\)/)[1] )
  increment = new Number( e.attr('data-scale-increment') )
  if current_scale + increment > max
    e.attr('data-scale-increment', Math.random() * (-0.1) )
    return current_scale
  if current_scale + increment < min
    e.attr('data-scale-increment', Math.random() * (0.1) )
    return current_scale
  
  current_scale + increment


prepare = ->
  # $('g#layer1').attr('transform', '')
  $('g g').each (i,e) ->
    $(e).attr('transform', "rotate(0,300,750) scale(1.0)")
    $(e).attr('data-rotation-speed', (Math.random() - 0.5) * 3)
        # $(e).attr('data-scale-min', 0.8)
        # $(e).attr('data-scale-max', 1.2)
    $(e).attr('data-scale-increment', Math.random() * 0.1)
    
    
    
transformify = ->
  $('g g').each (i,e) ->
    e = $(e)
    data = get_transform_coordinates(e)
    rotation_speed = new Number( e.attr("data-rotation-speed") )
    scale = get_scale(e)
    
    # alert( "" + data + ":" + $.type(data) )
    e.attr("transform", "rotate( #{ (data[0] + rotation_speed + 360) % 360 }, #{300 / 360.0}, #{750 / 750.0}) scale(#{scale})"  )  
  setTimeout( transformify, 50 )
  
$(document).ready( prepare )
$(document).ready( transformify )