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

 def show_time(e)

   #helper to show date if mail older than five days
   ((Time.now - e.created_at)/5.day) > 1
 end


  def show_mess(e,length=10)

    #helper to trim message if longer than length

    if e.message.blank?
      "..."

    elsif e.message.length > length
      e.message.first(length) + "..."

    else
      e.message

    end

  end

end