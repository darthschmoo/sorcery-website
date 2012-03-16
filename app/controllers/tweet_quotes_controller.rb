class TweetQuotesController < ApplicationController
  before_filter :get_tweet_quote, only: %w(destroy)
  def create
    @tweet_quote = TweetQuote.new( params[:tweet_quote] )
    respond_to do |format|
      if @tweet_quote.save
        format.html{
          render partial: "/tweet_quotes/tweet_quote", object: @tweet_quote, layout: nil
        }
      else
        raise "TODO"
      end
    end
  end
  
  def destroy
    standard_destroy_response( @tweet_quote )
  end
  # def show
  #   @tweet_quote = TweetQuote.find( params[:id] )
  #   if response.xhr?
  #     render :partial =>
  #   end
  # end
  
  protected
  def get_tweet_quote
    @tweet_quote = TweetQuote.find_by_id( params[:id] )
    abandon_action "No TweetQuote found with id #{ params[:id] }" if @tweet_quote.nil?  
  end
end
