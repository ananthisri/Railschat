var size;
App.conversation = App.cable.subscriptions.create("ConversationChannel", {
	
	connected: function() {
		console.log("connecetedd  database");
	},
	disconnected: function() {
		console.log("disconnnected database");
	},
	received: function(data)
	{

		var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
		console.log("size:"+size);

		if (data['window'] !== undefined) 
		{
			console.log("size1:"+size);
			var conversation_visible = conversation.is(':visible');
			if (conversation_visible) 
			{	
				console.log("window is opened");
				conversation.find('.messages-list').find('ul').append(data['message']);
			}
			else 
			{	
				console.log('window is not opened');
				$('#conversations-list').append(data['window']);
				conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");		
			}
		}
		else 
		{
			conversation.find('ul').append(data['message']);
			console.log("Else part");
		}
		var messages_list = conversation.find('.messages-list');
		var height = messages_list[0].scrollHeight;
		messages_list.scrollTop(height);
	},
	speak: function(message) 
	{
		return this.perform('speak', {
		message: message,
		});
	}
});

$(document).on('submit', '.new_message','#dialog-confirm',function(e) {
		var values = $(this).serializeArray();
		size =$("#parent li").length;
		
		if(size==0)
		{
			$( "#dialog-confirm" ).dialog({
							resizable: false,
							height: "auto",
							width: 400,
							modal: true,
							buttons: {
								"Allow": function() {
									$( this ).dialog( "close" );
									App.conversation.speak(values);
									$(this).trigger('reset');
									return false;
								},
								Decline: function() {
									$( this ).dialog( "close" );
								}
							}
						});
				return false
		}
		else
		{
				App.conversation.speak(values);
				$(this).trigger('reset');
				return false;
		}	
});
