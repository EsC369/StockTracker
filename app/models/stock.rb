class Stock < ActiveRecord::Base
    has_many :user_stocks
    has_many :users, through: :user_stocks

    def self.find_by_ticker(ticker_symbol) 
        where(ticker: ticker_symbol).first
    end

    def self.new_from_lookup(ticker_symbol)
        begin
            looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
            price = looked_up_stock.latest_price
            new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
        rescue Exception => e
            return nil
        end
    end

    # def self.strip_commas(number)
    #     number.gsub(",","")
    # end

    # WHEN NOT WORKING WITH AN INSTANCE, YOU MUST USE SELF
    # def self.stripcommas(number)
    #     number.gsub(",", " ")
    #     #gsub passes in what i want to strip, second argument passes in what you want to remove from it
    #     # so your taking the "," and replacing it with " " which is nothing
    # end
end
