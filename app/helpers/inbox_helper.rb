module InboxHelper

 def show_inbox (e)
   
   if e.receivers.map(&:is_read).first == true
     return true
   else
     return false
   end

 end

 def show_sent(e)

   #count should be same and not equal to zero
   if e.receivers.count == e.receivers.where(:is_read=> true).count && e.receivers.count!=0
     return true
   else
     return false
   end

end


  def show_mess(e)


    if e.message.blank?
      "..."
    else
      e.message.first(3) + "..."
    end

  end

end