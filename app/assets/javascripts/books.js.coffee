# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

actions_for_create_tweet_form = ->
  $('form#create_tweet_quote').bind( "ajax:success", (event, data, status, xhr) ->
    $('#tweet_quotes').append(data)
    $('form#create_tweet_quote :input[type=text]').val("")
  ).bind( "ajax:complete", (event, data, status, xhr) ->
    actions_for_destroy_tweet_link()   # needs to be
  )


actions_for_destroy_tweet_link = ->
  $('a.destroy_tweet_quote').bind( "ajax:success", (event, data, status, xhr) ->
    $(this).parents('div.tweet_quote').replaceWith( data )
  )

$(document).ready ->
  actions_for_create_tweet_form()
  actions_for_destroy_tweet_link()
    
    