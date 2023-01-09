Passwordless.after_session_save = lambda do |session, request|
    session = Passwordless::Session.new({
        authenticatable: @manager,
        user_agent: 'Command Line',
        remote_addr: 'unknown',
    })
    session.save!
    @magic_link = "#{@magic_link}?destination_path=/dashboard/"
end

