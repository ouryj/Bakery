require "sinatra"
require 'sendgrid-ruby'
require_relative "mainclass"


template = Bakery.new
@my_cake = template.cakes({price:9.74,des:'makeup cake',src:'/images/cake1.jpg'},{price:5.89,des:'mixberry cake',src:'/images/cake2.jpg'},{price:6.54,des:'pink cake',src:'/images/cake3.jpeg'},{price:4.5,des:'banana cake',src:'/images/cake4.jpeg'},{price:6.97,des:'coco cake',src:'/images/cake5.png'},{price:6.45,des:'high cake',src:'/images/cake6.jpg'},{price:8.9,des:'dreamy cake',src:'/images/cake7.jpeg'},{price:5.75,des:'fly cake',src:'/images/cake8.jpeg'},{price:7.89,des:'munchies cake',src:'/images/cake9.jpg'})
 

get "/" do 

    erb :home
end 

get "/cakes" do 
    @template = Bakery.new
   @my_cake = @template.cakes({price:9.74,des:'makeup cake',src:'/images/cake1.jpg'},{price:5.89,des:'mixberry cake',src:'/images/cake2.jpg'},{price:6.54,des:'pink cake',src:'/images/cake3.jpeg'},{price:4.5,des:'banana cake',src:'/images/cake4.jpeg'},{price:6.97,des:'coco cake',src:'/images/cake5.png'},{price:6.45,des:'high cake',src:'/images/cake6.jpg'},{price:8.9,des:'dreamy cake',src:'/images/cake7.jpeg'},{price:5.75,des:'fly cake',src:'/images/cake8.jpeg'},{price:7.89,des:'munchies cake',src:'/images/cake9.jpg'})
    
    erb :cakes
end

get "/cookies" do
    @display = Bakery.new
    @my_cookie = @display.cookies({price:2.4,des:'cookie bae',src:'/images/cookie1.jpg'},{price:5.78,des:'lemon cookie',src:'/images/cookie2.jpg'},{price:7.90,des:'nuff cooke',src:'/images/cookie3.jpg'},{price:9.78,des:'blank cookie',src:'/images/cookie4.jpeg'},{price:4.25,des:'hell cake',src:'/images/cookie5.jpg'},{price:8.93,des:'true cookie',src:'/images/cookie6.jpg'},{price:5.3,des:'dark cookie',src:'/images/cookie7.jpeg'},{price:3.45,des:'lam-cookie',src:'/images/cookie8.jpeg'},{price:5.34,des:'last-call',src:'/images/cookie9.jpg'})
    erb :cookies
end

get "/muffin" do
    @muff = Bakery.new
    @my_muffin = @muff.muffin({price:2.5,des:'muffin lace',src:'/images/muffin1.jpg'},{price:6.8,des:'hello muffin',src:'/images/muffin2.jpg'},{price:8.9,des:'muffin -plaza',src:'/images/muffin3.jpeg'},{price:3.45,des:'baddy',src:'/images/muffin4.jpeg'},{price:8.45,des:'muff pad',src:'/images/muffin5.jpg'},{price:6.89,des:'lucky',src:'/images/muffin6.jpeg'},{price:9.8,des:'clost muffin',src:'/images/muffin7.jpg'},{price:4.6,des:'yummy',src:'/images/muffin8.jpg'},{price:4.55,des:'lammy',src:'/images/muffin9.jpg'})
    erb :muffin
end

post "/form" do 
    if params[:email].empty?
        erb :home
    else

from = SendGrid::Email.new(email: 'test@example.com')
to = SendGrid::Email.new(email: params[:email])
subject = 'here is your catalog'
content = SendGrid::Content.new(type: 'text/plain', value: @my_cake)
mail = SendGrid::Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: ENV['SABI_PIA'])
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
#puts response.parsed_body
puts response.headers
erb :home
    end
end