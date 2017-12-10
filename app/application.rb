require 'pry'

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/cart/)
      if @@cart.empty?
        resp.write "Your cart is empty"
      else
        @@cart.each {|cart| resp.write "#{cart}\n"}
      end
    elsif req.path.match(/add/)
      added_term = req.params["q"]
      binding.pry
      resp.write added_term
      # if @@items.include?(added_term)
      #   @@cart << added_term
      #   resp.write "added #{added_term}"
      # elsif
      #   resp.write "We don't have that item"
      # end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
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
