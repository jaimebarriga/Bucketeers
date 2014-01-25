class ListCommander

# add(id_below, content)
# delete(id)

  def self.give_instructions(old_arr, complete_new_arr)

    new_arr = complete_new_arr.map{|a| a[:user_id]}
    old_i = 0
    new_i = 0
    old_length = old_arr.count
    new_length = new_arr.count

    inst = []

    while (old_i < old_length) && (new_i < new_length) do
      if (old_arr[old_i] < new_arr[new_i])
        inst << ["delete",old_arr[old_i]]
        old_i+=1
      elsif (old_arr[old_i] > new_arr[new_i])
        inst << ["add",old_arr[old_i],complete_new_arr[new_i]]
        new_i+=1
      else
        old_i+=1
        new_i+=1
      end
    end

    if (old_i == old_length)
      # reached max of old_list
      # append the rest
      (new_i..new_length-1).each do |c|
        inst << ["add",-1,complete_new_arr[c]]
      end
    elsif (new_i == new_length)
      (old_i..old_length-1).each do |c|
        inst << ["delete",old_arr[c]]
      end
    end

    inst
  end
end