class Application

  @@items = ["Apples","Carrots","Pears"] #class array that holds list of all items 
  @@cart = [] #class array that will hold items in your cart 

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #route 'items'
      @@items.each do |item| #iterates through all items 
        resp.write "#{item}\n" #and prints them out 
      end
    elsif req.path.match(/cart/) #route 'cart'
      if @@cart.length < 1 #if the cart is empty
        resp.write "Your cart is empty"
      else #if there are items in the cart
        @@cart.each do |item| #iterate through them 
          resp.write "#{item}\n" #print them out (similar to items)
        end
      end
    elsif req.path.match(/search/) #route 'searc'
      search_term = req.params["q"] #takes in a GET param with key 'q'-- assigned to variable 
      resp.write handle_search(search_term) 
    elsif req.path.match(/add/) #route 'add'
      item_to_add = req.params["item"] #takes in GET param item and assigns to variable 
      if @@items.include? item_to_add #if item is in the list of all items 
        @@cart << item_to_add #shovel into cart class variable 
        resp.write "added #{item_to_add}" #write out what item was added 
      else #if item is not in item list 
        resp.write "We don't have that item"
      end
    else
      resp.write "Path Not Found"
    end
    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
