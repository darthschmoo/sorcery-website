# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

actions_for_create_tweet_form = ->
  $('form#create_tweet_quote').bind( "ajax:success", (event, data, status, xhr) ->
    $('#tweet_quotes').append(data)
    $('form#create_tweet_quote textarea').val("")
  ).bind( "ajax:complete", (event, data, status, xhr) ->
    actions_for_destroy_tweet_link()   # needs to be
  )


actions_for_destroy_tweet_link = ->
  $('a.destroy_tweet_quote').bind( "ajax:success", (event, data, status, xhr) ->
    $(this).parents('div.tweet_quote').replaceWith( data )
  )

tlc = null

add_counter_for_tweets = ->
  dlc = $("[data-length-counter]")
  if dlc.length > 0
    tlc = new TweetLengthCounter( dlc )
    dlc.keypress (event) =>
      if event.which == 13  # return key
        event.stopPropagation()
        event.stopImmediatePropagation()
        tlc.elem.parents('form').submit()
    dlc.keypress (event) =>
      tlc.update_counter_text()
      
class TweetLengthCounter
  constructor: ( @elem ) ->
    # create tweet counter area
    # hide tweet counter area
    this.register_callbacks()
    @elem.after("<p class=\"tweet_length_counter\"></p>")
    @counter_elem = $('.tweet_length_counter')
    @counter_elem.hide()
    @length = new Number @elem.attr('data-length-counter')
    
  hide_counter: ->
    @counter_elem.hide()
    
  show_counter: ->
    this.update_counter_text()
    @counter_elem.show()
    
  register_callbacks: ->
    @elem.focusin  ->
      tlc.show_counter()
    @elem.focusout ->
      tlc.hide_counter()
      
  update_counter_text: ->
    setTimeout.call this, 'this.update_counter_text_immediately()', 50
    
  update_counter_text_immediately: ->
    @counter_elem.html "" + (@length - @elem.val().length)

$(document).ready ->
  actions_for_create_tweet_form()
  actions_for_destroy_tweet_link()
  add_counter_for_tweets()
    
    