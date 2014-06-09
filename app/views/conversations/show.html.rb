<%= conversation.subject %>
 
A conversation with
<% conversation.participants.each do |participant| %>
 <% if participant != current_user %>
  <%= link_to participant.full_name, participant %>
 <% end %>
<% end %>
<%= content_tag_for(:li, conversation.receipts_for(current_user)) do |receipt| %>
 <% message = receipt.message %>
 <%= message.sender.full_name %>
 
 < %= simple_format h message.body %>
 
 Sent <%= conversation.updated_at.strftime("%a, %m/%e/%Y %I:%M %p") %>
 
<% end %>
 
<%= render 'messages/form', conversation: conversation %>