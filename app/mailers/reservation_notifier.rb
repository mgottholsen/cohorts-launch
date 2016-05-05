class ReservationNotifier < ApplicationMailer
  def notify(email_address:, reservation:)
    @email_address = email_address
    @reservation = reservation

    attachments['event.ics'] = { mime_type: 'application/ics', content: generate_ical(reservation) }

    mail(to: email_address,
         from: reservation.user.email,
         bcc: reservation.user.email,
         subject: 'Interview scheduled',
         content_type: 'multipart/mixed')
  end

  private

    # FIXME: Refactor and re-enable cop
    # rubocop:disable Metrics/MethodLength
    def generate_ical(reservation)
      cal = Icalendar::Calendar.new
      cal.event do |e|
        e.dtstart = Icalendar::Values::DateTime.new(reservation.start_datetime)
        e.dtend   = Icalendar::Values::DateTime.new(reservation.end_datetime)
        e.summary     = reservation.title
        e.description = reservation.description
        e.alarm do |a|
          a.summary = reservation.event.description
          a.trigger = '-P1DT0H0M0S' # 1 day before
        end
      end
      cal.publish
      cal.to_ical
    end
  # rubocop:enable Metrics/MethodLength
end
