# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App.cable.subscriptions.create "ConversationChannel",
  # Called when the subscription is ready for use on the server.
  connected: ->
    @install()
    @appear()
 
  # Called when the WebSocket connection is closed.
  disconnected: ->
    @uninstall()
 
  # Called when the subscription is rejected by the server.
  rejected: ->
    @uninstall()
 
  appear: ->
    # Calls `AppearanceChannel#appear(data)` on the server.
    @perform("appear", appearing_on: $("main").data("appearing-on"))
 
  away: ->
    # Calls `AppearanceChannel#away` on the server.
    @perform("away")
 	
 	

 
  install: ->

  
    $(document).on "turbolinks:load.appearance", =>
      @appear()
 
    $(document).on "click.appearance", buttonSelector, =>
      @away()
      false
 
    $(buttonSelector).show()
 
  uninstall: ->
    $(document).off(".appearance")
    $(buttonSelector).hide()
	buttonSelector = "[data-behavior~=appear_away]"
