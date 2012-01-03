# encoding: UTF-8

require 'rubygems'
require 'sinatra'
require 'rack-flash'
require 'sinatra/content_for'
require 'sinatra/redirect_with_flash'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'rdiscount'
require 'nokogiri'

get '/' do
  @index = RDiscount.new( File.open("content/index.md").read ).to_html
  haml :index
end

get '/:article' do
  @content = RDiscount.new( File.open("content/" + params["article"].gsub("-", "_").concat(".md")).read ).to_html
  doc_title = Nokogiri::HTML::DocumentFragment.parse( @content ).css('h1').inner_html()  
  @title = "#{doc_title} | Observaciones de un explorador, por César Salazar"
  haml :article
end
  
get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
