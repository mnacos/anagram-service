class AnagramsController < ApplicationController
  def show
    input = params[:query]
    response = {}
    if !input.blank?
      input.split(',').each do |string|
        response[string] = Word.anagram string
      end
    end
    render json: response
  end
end
