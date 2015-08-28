$("#comments_section").html("<%= j render :partial => 'venues/comments', :locals => {:venue => @venue} %>");


