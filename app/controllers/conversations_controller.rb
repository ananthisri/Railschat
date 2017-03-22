class ConversationsController < ApplicationController
	


	def create	
		@conversation = Conversation.get(current_user.id, params[:user_id])
		@messages = @conversation.messages
		if @messages.length > 0
			@over_one =true
		else
			@over_one=false
		end

		respond_to do |format|
			format.js	
		end

	end


	def close	
		@conversation = Conversation.find(params[:id])
		session[:conversations].delete(@conversation.id)
		respond_to do |format|
			format.js
		end		
	end

	def destroy
		session[:person] = nil
		redirect_to '/users/sign_in'
	end

	

	#def add_to_conversations
	#session[:conversations] ||= []
	#session[:ConversationsController] << @conversation.id
	#end

	#def conversated?
	#session[:conversations].include?(@conversation.id)
	#end
end
