# app/models/quote.rb
class Quote < ApplicationRecord
    belongs_to :company
    validates :name, presence: true
    scope :ordered, -> { order(id: :desc) }


    #a lot of syntatic sugar
    #async
    ##after_create_commit -> { broadcast_prepend_later_to "quotes" }
    #async
    ##after_update_commit -> { broadcast_replace_later_to "quotes" }
    #sync
    #because as the quote gets deleted from the database, 
    #it would be impossible for a background job to retrieve this quote in the database later to perform the job.
    ##after_destroy_commit -> { broadcast_remove_to "quotes" }

    #more syntatic sugar
    broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend
  end
  