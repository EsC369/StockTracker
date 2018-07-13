class StocksController < ApplicationController

    def search
        if params[:stock].present?
            @stock = Stock.new_from_lookup(params[:stock])
            if @stock 
                render "users/my_portfolio"
            else
                flash[:danger] = "You Have Entered An Invalid Input!"
                redirect_to my_portfolio_path
            end
        else
            flash[:danger] = "Ticker Field Cannot Be Blank!"
            redirect_to my_portfolio_path
        end
    end

end
