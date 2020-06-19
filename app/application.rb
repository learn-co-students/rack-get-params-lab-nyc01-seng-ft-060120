class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []
  @@add = []
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
   
    if req.path.match(/cart/)
      @@cart.each do |cart|
        resp.write "#{cart}\n"
        end
    end
    if @@cart.count(/cart/)==0
      resp.write "Your cart is empty"
    end
  
    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
    end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end


     req.path.match(/add/)
          item = req.params["item"]
          if @@items.include?(item)
            @@cart << item
            resp.write "added #{item}\n"
          elsif
            resp.write "We don't have that item"
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
