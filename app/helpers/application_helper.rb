module ApplicationHelper

	# def hidden_div_if(condition, attributes = {}, &block)
	# 	if condition
	# 		print "<div " + attributes.map { |k,v| "#{k}=\"#{v}\"" }.join(' ') + "style=\"display: none;\"" + ">" + yield + "</div>"
	# 	else
	# 		print "<div " + attributes.map { |k,v| "#{k}=\"#{v}\"" }.join(' ') + ">" + yield + "</div>"
	# 	end

	# end

	def hidden_div_if(condition, attributes = {}, &block)
		if condition
			attributes["style"] = "display: none"
		end
		content_tag("div", attributes, &block)
	end

end
