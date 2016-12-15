$ ->
    do disable_autoplay = -> # Called immediately
        autoplay = $ 'div.checkbox-on-off'
        chkbox = autoplay.find 'input'

        if autoplay? and chkbox?
            chkbox.click() if chkbox.is ':checked' # Disable autoplay if enabled
            autoplay.remove() # Delete the autoplay div

    $(@).on 'spfdone', disable_autoplay # Call when the page navigates
