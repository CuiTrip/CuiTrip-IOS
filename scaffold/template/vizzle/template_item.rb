#encoding:utf-8

module T_Item 

require 'erb'

#{
# property : [{name:xx,class:xxx},{name:xx,class:xxx},...]
# class:xxx
# superclass:xxx 
#}

def T_Item::renderH(hash)

  list = hash["property"]
  template = <<-TEMPLATE

#import "<%= hash["superclass"] %>.h"

@interface <%=hash["class"] %> : <%= hash["superclass"] %>
<% list.each{|obj| %> <% name = obj["name"] %> <% clz = obj["class"] %>
@property(nonatomic,strong)<%= clz %> *<%= name %>;<%} if list%>

@end

  
  TEMPLATE
 
  erb = ERB.new(template)
  erb.result(binding)

end

def T_Item::renderM(hash)
  
  template = <<-TEMPLATE

#import "<%= hash["class"] %>.h"

@interface <%= hash["class"] %>()

@end

@implementation <%= hash["class"] %>

- (void)autoKVCBinding:(NSDictionary *)dictionary
{
    [super autoKVCBinding:dictionary];
    
    //todo...
}

@end

  TEMPLATE
  
  erb = ERB.new(template)
  erb.result(binding)
  
end

end