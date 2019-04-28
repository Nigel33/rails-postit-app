module ApplicationHelper
	def fix_url(str)
		str.starts_with?('http') ? str : "http://#{str}" 
	end 

	def display_datetime(dt)
		dt.strftime("%m/%d/%Y %l:%M%P %Z")
	end 

	def ajax_flash(div_id) 
		response = ''

		flash.each do |name, msg|
			if msg.is_a?(String)
				response = "<div class=\"alert alert-#{name == "notice" ? "success" : "error"}\"> \
				 	 					  <a class=\"close\" data-dismiss=\"alert\">&#215;</a> \
				 	 					  <div id=\"flash_#{name}\">#{msg}</div> \
				 	 				 </div>"
			end
		end 
		
		"$('#{div_id}').html('#{response}')".html_safe
	end 
end
 