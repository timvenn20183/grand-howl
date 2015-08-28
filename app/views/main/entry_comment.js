$("#comments_section").html("<%= j render :partial => 'entries/comments', :locals => {:entry => @entry} %>");


