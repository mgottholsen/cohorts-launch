class V2::SmsReservationsController < ApplicationController
  skip_before_action :authenticate_user!

  # rubocop:disable Metrics/MethodLength
  def create
    send_error_notification && return unless valid_message?
    if declined?
      send_decline_notifications(person, event)
    else
      reservation = V2::Reservation.new(person: person, time_slot: time_slot)
      if reservation.save
        send_notifications(person, reservation)
      else
        resend_available_slots(person, event)
      end
    end
    render text: 'OK'
  end
  # rubocop:enable Metrics/MethodLength

  private

    def message
      reservation_params[:Body]
    end

    def person
      @person ||= Person.find_by(phone_number: reservation_params[:From])
    end

    # TODO: needs to be smarter in the edge case where
    # there are more than 9 slot options and 0 comes up again
    def selection
      slot_letter = message.downcase.delete('^a-z')
      # "a".ord - ("A".ord + 32) == 0
      # "b".ord - ("A".ord + 32) == 1
      # (0 + 97).chr == a
      # (1 + 97).chr == b
      slot_letter.ord - ('A'.ord + 32)
    end

    def event
      event_id = message.delete('^0-9')
      V2::Event.find_by(id: event_id)
    end

    def time_slot
      event.time_slots[selection]
    end

    def send_notifications(person, reservation)
      ::ReservationSms.new(to: person, reservation: reservation).send
    end

    def send_decline_notifications(person, event)
      ::DeclineInvitationSms.new(to: person, event: event).send
    end

    def send_error_notification
      ::InvalidOptionSms.new(to: reservation_params[:From]).send

      render text: 'OK'
    end

    def resend_available_slots(person, event)
      ::TimeSlotNotAvailableSms.new(to: person, event: event).send
    end

    def only_numbers_and_at_least_two_of_them?
      message =~ /^\d(\d)+\s?$/
    end

    def declined?
      # up to 10k events.
      message.downcase =~ /^\d{1,5}-decline?/
    end

    def letters_and_numbers_only?
      # up to 10k events
      message.downcase =~ /\b\d{1,5}[a-z]\b/
    end

    def valid_message?
      return true if declined?
      return true if letters_and_numbers_only?
      false
    end

    def reservation_params
      params.permit(:From, :Body)
    end
end
