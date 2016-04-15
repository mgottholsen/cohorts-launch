# == Schema Information
#
# Table name: v2_reservations
#
#  id           :integer          not null, primary key
#  time_slot_id :integer
#  person_id    :integer
#

class V2::Reservation < ActiveRecord::Base
  self.table_name = 'v2_reservations'

  belongs_to :time_slot, class_name: '::V2::TimeSlot'
  has_one    :event, through: :time_slot
  has_one    :user,  through: :event
  belongs_to :person

  validates :person, presence: true
  validates :time_slot, presence: true

  # do we check this here?
  # User can't book over themselves.
  # validates 'time_slot.start_time', 'time_slot.end_time',
  #   overlap: {
  #     query_options: { includes: [:time_slot, :event] },
  #     scope: { 'event.user_id' => proc { |event| event.user_id } }
  #   }

  # # person can only have one reservation at a time.
  # validates 'time_slot.start_time', 'time_slot.ends_time',
  #   overlap: {
  #     query_options: { includes: :time_slot },
  #     scope: 'person_id',
  #     exclude_edges: %w( time_slot.start_time time_slot.end_time )
  #   }
end
